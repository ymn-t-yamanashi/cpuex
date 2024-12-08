defmodule CpuexWeb.CpuController do
  use CpuexWeb, :controller
  alias Cpuex.CpuInfo

  action_fallback CpuexWeb.FallbackController

  def index(conn, _params) do
    get_cpuinfo = CpuInfo.get_cpuinfo()
    |> CpuInfo.create_graph_map()
    render(conn, :index, cpu: get_cpuinfo)
  end

  def create(_conn, _) do
  end

  def show(_conn, _) do
  end

  def update(_conn, _) do
  end

  def delete(_conn, _) do
  end
end
