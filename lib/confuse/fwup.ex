defmodule Confuse.Fwup do
  @moduledoc """
  Special-purpose functionality for usage of config files by the [fwup](https://github.com/fwup-home/fwup) tool.

  Primarily to provide functionality for Nerves firmware update introspection.
  """

  @doc """
  Get all tasks with their delta-enabled resources.
  """
  @spec get_delta_files(file :: String.t()) :: map()
  def get_delta_files(file) do
    with {:ok, contents} <- File.read(file),
         {:ok, parsed} <- Confuse.parse(contents) do
      parsed
      |> get_tasks()
      |> only_tasks_with_deltas()
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
