defmodule Cpuex.CpusFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cpuex.Cpus` context.
  """

  @doc """
  Generate a cpu.
  """
  def cpu_fixture(attrs \\ %{}) do
    {:ok, cpu} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Cpuex.Cpus.create_cpu()

    cpu
  end
end
