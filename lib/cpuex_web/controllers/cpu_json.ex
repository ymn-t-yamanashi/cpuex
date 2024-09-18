defmodule CpuexWeb.CpuJSON do
  alias Cpuex.Cpus.Cpu

  @doc """
  Renders a list of cpus.
  """
  def index(%{cpus: cpus}) do
    %{data: for(cpu <- cpus, do: data(cpu))}
  end

  @doc """
  Renders a single cpu.
  """
  def show(%{cpu: cpu}) do
    %{data: data(cpu)}
  end

  defp data(%Cpu{} = cpu) do
    %{
      id: cpu.id,
      name: cpu.name
    }
  end
end
