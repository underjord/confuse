defmodule Confuse.Fwup do
  @moduledoc """
  Special-purpose functionality for usage of config files by the [fwup](https://github.com/fwup-home/fwup) tool.

  Primarily to provide functionality for Nerves firmware update introspection.
  """

  @doc """
  Get all tasks with their delta-enabled resources.
  """

  defmodule Features do
    @absolute_minimum_fwup "0.2.0"
    @encrypted_delta_fwup "1.13.0"
    @fat_deltas_fwup "1.10.0"
    @raw_deltas_fwup "1.6.0"
    @encryption_fwup "1.5.0"

    @versions %{
      raw_deltas?: @raw_deltas_fwup,
      fat_deltas?: @fat_deltas_fwup,
      encryption?: @encryption_fwup,
      encrypted_deltas?: @encrypted_delta_fwup
    }
    defstruct raw_deltas?: false,
              fat_deltas?: false,
              encryption?: false,
              encrypted_deltas?: false,
              require_fwup_version: Version.parse!(@absolute_minimum_fwup)

    @type t() :: %__MODULE__{
            raw_deltas?: boolean(),
            fat_deltas?: boolean(),
            encryption?: boolean(),
            encrypted_deltas?: boolean(),
            require_fwup_version: Version.t()
          }

    def squash(feature_usages) do
      feature_usages
      |> Enum.reduce(%Features{}, fn f, acc ->
        acc =
          case f do
            %{encryption?: true, raw_deltas?: true} ->
              %{acc | encryption?: true, raw_deltas?: true, encrypted_deltas?: true}

            %{encryption?: true} ->
              %{acc | encryption?: true}

            _ ->
              acc
          end

        acc =
          case f do
            %{fat_deltas?: true} ->
              %{acc | fat_deltas?: true}

            _ ->
              acc
          end

        case f do
          %{raw_deltas?: true} ->
            %{acc | raw_deltas?: true}

          _ ->
            acc
        end
      end)
      |> calculate_version()
    end

    defp calculate_version(features) do
      version =
        @versions
        |> Enum.filter(fn {feature, _} ->
          Map.get(features, feature)
        end)
        |> Enum.map(fn {_, v} -> Version.parse!(v) end)
        |> Enum.sort({:desc, Version})
        |> case do
          [highest | _] -> highest
          [] -> @absolute_minimum_fwup
        end

      %{features | require_fwup_version: version}
    end
  end

  @spec get_delta_files(file :: String.t()) ::
          {:ok, map()} | {:error, :parsing_failed | File.posix()}
  def get_delta_files(file) do
    with {:ok, contents} <- File.read(file),
         {:ok, parsed} <- Confuse.parse(contents) do
      output =
        parsed
        |> get_tasks()
        |> only_tasks_with_deltas()

      {:ok, output}
    end
  end

  @spec get_feature_usage(file :: String.t()) ::
          {:ok, Features.t()} | {:error, :parsing_failed | File.posix()}
  def get_feature_usage(file) do
    with {:ok, contents} <- File.read(file),
         {:ok, parsed} <- Confuse.parse(contents) do
      output =
        parsed
        |> get_tasks()
        |> reduce_on_resource(%{}, &check_feature/3)
        |> Map.values()
        |> Features.squash()

      {:ok, output}
    end
  end

  defp check_feature(resource, resource_contents, feature_usage) do
    features = Map.get(feature_usage, resource, %Features{})

    features =
      Enum.reduce(resource_contents, features, fn statement, features ->
        case statement do
          {"delta-source-raw-" <> _, _} ->
            %{features | raw_deltas?: true}

          {"delta-source-fat-" <> _, _} ->
            %{features | fat_deltas?: true}

          {{:function, "raw_write"}, opts} when is_list(opts) ->
            opts = to_string(opts)

            if opts =~ "cipher=" do
              %{features | encryption?: true}
            else
              features
            end

          _ ->
            features
        end
      end)

    Map.put(feature_usage, resource, features)
  end

  defp get_tasks(parsed) do
    for {{"task", tag}, value} <- parsed, into: %{} do
      {tag, value}
    end
  end

  defp reduce_on_resource(tasks, acc, fun) do
    Enum.reduce(tasks, acc, fn {_task, contents}, acc ->
      Enum.reduce(contents, acc, fn {task_key, sub_contents}, acc ->
        case task_key do
          {"on-resource", resource} ->
            fun.(resource, sub_contents, acc)

          _ ->
            acc
        end
      end)
    end)
  end

  defp only_tasks_with_deltas(tasks) do
    for {task, contents} <- tasks, into: %{} do
      items =
        contents
        |> Enum.flat_map(fn
          {{"on-resource", resource}, contents} ->
            only_resource_with_deltas(resource, contents)

          _ ->
            []
        end)
        |> Enum.sort()
        |> Enum.uniq()

      {task, items}
    end
  end

  defp only_resource_with_deltas(resource, contents) do
    if Enum.any?(contents, fn
         {"delta-source-" <> _, _} -> true
         _ -> false
       end) do
      [resource]
    else
      []
    end
  end
end
