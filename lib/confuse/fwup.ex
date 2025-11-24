defmodule Confuse.Fwup do
  @moduledoc """
  Special-purpose functionality for usage of config files by the [fwup](https://github.com/fwup-home/fwup) tool.

  Primarily to provide functionality for Nerves firmware update introspection.
  """

  defmodule Features do
    @moduledoc """
    Fwup features.

    Data structure to provide information about fwup features detected in a config file.
    """

    @absolute_minimum_fwup "0.2.0"
    @encrypted_delta_fwup "1.13.0"
    @fat_deltas_fwup "1.10.0"
    @raw_deltas_fwup "1.6.0"
    @encryption_fwup "1.5.0"

    @complete_versions %{
      encryption?: @encryption_fwup
    }
    @delta_versions %{
      raw_deltas?: @raw_deltas_fwup,
      fat_deltas?: @fat_deltas_fwup,
      encryption?: @encryption_fwup,
      encrypted_deltas?: @encrypted_delta_fwup
    }
    defstruct raw_deltas?: false,
              fat_deltas?: false,
              encryption?: false,
              encrypted_deltas?: false,
              specified_fwup_version: nil,
              complete_fwup_version: Version.parse!(@absolute_minimum_fwup),
              delta_fwup_version: Version.parse!(@raw_deltas_fwup),
              valid?: false

    @type t() :: %__MODULE__{
            raw_deltas?: boolean(),
            fat_deltas?: boolean(),
            encryption?: boolean(),
            encrypted_deltas?: boolean(),
            specified_fwup_version: Version.t() | nil,
            complete_fwup_version: Version.t(),
            delta_fwup_version: Version.t(),
            valid?: boolean()
          }

    @spec squash([Confuse.Fwup.validation()], String.t() | nil) :: t()
    def squash(feature_usages, fwup_version) do
      fwup_version = Version.parse!(fwup_version || @absolute_minimum_fwup)

      feature_usages
      |> Enum.reduce(%Features{valid?: true}, fn f, acc ->
        %{
          acc
          | raw_deltas?: acc.raw_deltas? or f.raw_deltas_valid?,
            fat_deltas?: acc.fat_deltas? or f.fat_deltas_valid?,
            encryption?:
              acc.encryption? or (f.raw_write? and f.raw_write_cipher? and f.raw_write_secret?),
            encrypted_deltas?:
              acc.encrypted_deltas? or (f.raw_write_cipher? and f.raw_deltas_valid?),
            # Valid if not using deltas or if deltas are valid
            valid?:
              not acc.valid? or
                ((not f.delta_source_raw_offset? or f.raw_deltas_valid?) and
                   (not f.delta_source_fat_offset? or f.fat_deltas_valid?))
        }
      end)
      |> calculate_version(fwup_version)
    end

    defp calculate_version(features, minimum_version) do
      raw_deltas_version = Version.parse!(@raw_deltas_fwup)

      complete_version =
        @complete_versions
        |> Enum.filter(fn {feature, _} ->
          Map.get(features, feature)
        end)
        |> Enum.map(fn {_, v} -> Version.parse!(v) end)
        |> Enum.sort({:desc, Version})
        |> case do
          [highest | _] -> highest
          [] -> minimum_version
        end

      delta_version =
        @delta_versions
        |> Enum.filter(fn {feature, _} ->
          Map.get(features, feature)
        end)
        |> Enum.map(fn {_, v} -> Version.parse!(v) end)
        |> Enum.sort({:desc, Version})
        |> case do
          [highest | _] ->
            highest

          [] ->
            case Version.compare(raw_deltas_version, minimum_version) do
              :gt -> raw_deltas_version
              _ -> minimum_version
            end
        end

      %{features | complete_fwup_version: complete_version, delta_fwup_version: delta_version}
    end
  end

  @type validation() :: %{
          delta_source_raw_offset?: boolean(),
          delta_source_raw_count?: boolean(),
          delta_source_raw_options_cipher?: boolean(),
          delta_source_raw_options_secret?: boolean(),
          raw_write?: boolean(),
          raw_write_cipher?: boolean(),
          raw_write_secret?: boolean(),
          raw_deltas_valid?: boolean(),
          delta_source_fat_offset?: boolean(),
          delta_source_fat_path?: boolean(),
          fat_write?: boolean(),
          fat_deltas_valid?: boolean()
        }

  defp new_validation() do
    %{
      delta_source_raw_offset?: false,
      delta_source_raw_count?: false,
      delta_source_raw_options_cipher?: false,
      delta_source_raw_options_secret?: false,
      raw_write?: false,
      raw_write_cipher?: false,
      raw_write_secret?: false,
      raw_deltas_valid?: false,
      delta_source_fat_offset?: false,
      delta_source_fat_path?: false,
      fat_write?: false,
      fat_deltas_valid?: false
    }
  end

  @spec get_delta_files_from_config(config_data :: String.t()) ::
          {:ok, map()} | {:error, :parsing_failed | File.posix()}
  def get_delta_files_from_config(config_data) do
    with {:ok, parsed} <- Confuse.parse(config_data) do
      output =
        parsed
        |> get_tasks()
        |> only_tasks_with_deltas()

      {:ok, output}
    end
  end

  @spec get_delta_files(file :: String.t()) ::
          {:ok, map()} | {:error, :parsing_failed | File.posix()}
  def get_delta_files(file) do
    with {:ok, contents} <- File.read(file) do
      get_delta_files_from_config(contents)
    end
  end

  @spec get_feature_usage_from_config(config_data :: String.t()) ::
          {:ok, Features.t()} | {:error, :parsing_failed | File.posix()}
  def get_feature_usage_from_config(config_data) do
    with {:ok, parsed} <- Confuse.parse(config_data) do
      output =
        parsed
        |> get_tasks()
        |> reduce_on_resource(%{}, &check_feature/3)
        |> Map.values()
        |> Features.squash(parsed["require-fwup-version"])

      {:ok, output}
    end
  end

  @spec get_feature_usage(file :: String.t()) ::
          {:ok, Features.t()} | {:error, :parsing_failed | File.posix()}
  def get_feature_usage(file) do
    with {:ok, contents} <- File.read(file) do
      get_feature_usage_from_config(contents)
    end
  end

  @spec validate_delta(
          source_meta_conf :: String.t(),
          target_meta_conf :: String.t(),
          using_fwup_version :: nil | Version.t()
        ) :: :ok | {:error, list(String.t())}
  def validate_delta(source_meta_conf, target_meta_conf, using_fwup_version \\ nil) do
    with {:ok, source} <- Confuse.parse(source_meta_conf),
         {:ok, target} <- Confuse.parse(target_meta_conf) do
      s = get_feature_by_resource(source)
      t = get_feature_by_resource(target)

      fwup_warnings =
        if using_fwup_version do
          target_features =
            t
            |> Map.values()
            |> Features.squash(t["require-fwup-version"])

          if Version.compare(using_fwup_version, target_features.delta_fwup_version) == :gt do
            []
          else
            [
              "Delta firmware update requires fwup version #{target_features.delta_fwup_version} or higher, using #{using_fwup_version}."
            ]
          end
        else
          []
        end

      result =
        s
        |> Enum.flat_map(fn {resource, v} ->
          {_, target_resource} = Enum.find(t, fn {r, _} -> r == resource end)
          validate_delta_resource(resource, v, target_resource)
        end)

      case result ++ fwup_warnings do
        [] -> :ok
        warnings -> {:error, warnings}
      end
    end
  end

  defp validate_delta_resource(resource, sv, tv) do
    [
      (tv.raw_deltas_valid? and not sv.raw_write?) &&
        "#{resource}: Target uses raw deltas but source has no raw writes.",
      (tv.fat_deltas_valid? and not sv.fat_write?) &&
        "#{resource}: Target uses FAT deltas but source has no FAT writes.",
      (tv.raw_deltas_valid? and sv.raw_write_cipher? and sv.raw_write_secret? and
         not (tv.delta_source_raw_options_cipher? and tv.delta_source_raw_options_secret?)) &&
        "#{resource}: Target uses raw deltas and source firmware uses encryption for the same resource but target firmware has no cipher or secret options for the resource. This should not be able to work."
    ]
    |> Enum.filter(&is_binary/1)
  end

  defp get_feature_by_resource(parsed) do
    parsed
    |> get_tasks()
    |> reduce_on_resource(%{}, &check_feature/3)
  end

  defp check_feature(resource, resource_contents, feature_usage) do
    f = Map.get(feature_usage, resource, new_validation())

    f =
      Enum.reduce(resource_contents, f, &do_check_feature/2)

    f = %{
      f
      | raw_deltas_valid?:
          f.raw_write? and f.delta_source_raw_offset? and f.delta_source_raw_count? and
            (not f.raw_write_cipher? or
               (f.raw_write_secret? and
                  f.delta_source_raw_options_cipher? and
                  f.delta_source_raw_options_secret?)),
        fat_deltas_valid?:
          f.fat_write? and f.delta_source_fat_offset? and f.delta_source_fat_path?
    }

    Map.put(feature_usage, resource, f)
  end

  defp do_check_feature(statement, features) do
    case statement do
      {"delta-source-raw-offset" <> _, _} ->
        %{features | delta_source_raw_offset?: true}

      {"delta-source-raw-count" <> _, _} ->
        %{features | delta_source_raw_count?: true}

      {"delta-source-raw-options" <> _, opts} ->
        opts = to_string(opts)

        %{
          features
          | delta_source_raw_options_cipher?: opts =~ "cipher=",
            delta_source_raw_options_secret?: opts =~ "secret="
        }

      {"delta-source-fat-offset" <> _, _} ->
        %{features | delta_source_fat_offset?: true}

      {"delta-source-fat-path" <> _, _} ->
        %{features | delta_source_fat_path?: true}

      {{:function, "raw_write"}, opts} when is_list(opts) ->
        opts = to_string(opts)

        %{
          features
          | raw_write?: true,
            raw_write_cipher?: opts =~ "cipher=",
            raw_write_secret?: opts =~ "secret="
        }

      {"funlist", [_ | ["raw_write" | opts]]} ->
        opts = Enum.join(opts)

        %{
          features
          | raw_write?: true,
            raw_write_cipher?: opts =~ "cipher=",
            raw_write_secret?: opts =~ "secret="
        }

      {{:function, "fat_write"}, _} ->
        %{features | fat_write?: true}

      {"funlist", ["3", "fat_write", _, _]} ->
        %{features | fat_write?: true}

      _ ->
        features
    end
  end

  defp get_tasks(parsed) do
    for {{"task", tag}, value} <- parsed, into: %{} do
      {tag, value}
    end
  end

  defp reduce_on_resource(tasks, acc, fun) do
    Enum.reduce(tasks, acc, fn {_task, contents}, acc ->
      Enum.reduce(contents, acc, fn item, acc ->
        on_resource(item, acc, fun)
      end)
    end)
  end

  defp on_resource({{"on-resource", resource}, sub_contents}, acc, fun) do
    fun.(resource, sub_contents, acc)
  end

  defp on_resource(_, acc, _) do
    acc
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
