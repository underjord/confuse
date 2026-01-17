defmodule Confuse.Fwup do
  @moduledoc """
  Special-purpose functionality for usage of config files by the [fwup](https://github.com/fwup-home/fwup) tool.

  Primarily to provide functionality for Nerves firmware update introspection.
  """

  @doc """
  Get all necessary detail about the firmware for determining safe delta delivery.
  """
  @spec get_feature_usage(file :: String.t()) ::
          {:ok, map()} | {:error, :parsing_failed | File.posix()}
  def get_delta_details(file) do
    with {:ok, contents} <- File.read(file),
         {:ok, parsed} <- Confuse.parse(contents) do
      output =
        parsed
        |> get_tasks()
        |> tasks_to_details()

      {:ok, output}
    end
  end

  # TODO: Use the plain parser and then a few different functions
  #       to pull information from that parsed structure
  # TODO: Get feature usage, almost done, booleans for various features
  # TODO: Get a structure that is easy to check for compatibility between
  #       two configs. Including resource file names

  @doc """
  Get all tasks with their delta-enabled resources.
  """
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

  defp get_tasks(parsed) do
    for {{"task", tag}, value} <- parsed, into: %{} do
      {tag, value}
    end
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

  defp tasks_to_details(tasks) do
    features_used = %{
      deltas?: false,
      raw?: false,
      fat?: false,
      encryption?: false
    }

    tasks
    |> Enum.reduce(features_used, fn {task, contents}, used ->
      contents
      |> Enum.reduce(used, fn {key, value}, used ->
        case key do
          {"on-resource", _resource} ->
            check_usage(usage, value)

          _ ->
            used
        end
      end)
    end)
  end

  defp check_usage(usage, value) do
    Enum.reduce(value, usage, fn {k, _v}, usage ->
      case k do
        "delta-source-raw" <> _ ->
          %{usage | deltas?: true, raw?: true}

        "delta-source-fat" <> _ ->
          %{usage | deltas?: true, fat?: true}

        "delta-source-raw-options" <> _ ->
          %{usage | deltas?: true, raw?: true, encryption?: true}
      end
    end)
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
