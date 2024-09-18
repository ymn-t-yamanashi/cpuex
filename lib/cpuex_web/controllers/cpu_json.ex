defmodule CpuexWeb.CpuJSON do
  @doc """
  Renders a list of cpus.
  """
  def index(%{cpu: cpu}) do
    cpu.spec
  end

  @doc """
  Renders a single cpu.
  """
  def show(_) do
  end
end
