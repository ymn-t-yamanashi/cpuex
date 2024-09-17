defmodule CpuexWeb.CpuLive.Index do
  alias Cpuex.CpuInfo
  use CpuexWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Process.send_after(self(), :update, 250)
    cpuinfo = CpuInfo.get_cpuinfo()
    max_mhz = Enum.max(cpuinfo)

    socket
    |> assign(max_mhz: max_mhz)
    |> assign(graph: CpuInfo.create_graph(cpuinfo))
    |> ok()
  end

  @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 250)
    cpuinfo = CpuInfo.get_cpuinfo()

    max_mhz = Enum.max(cpuinfo ++ [socket.assigns.max_mhz])

    socket
    |> assign(max_mhz: max_mhz)
    |> assign(graph: CpuInfo.create_graph(cpuinfo))
    |> noreply()
  end

  def ok(socket), do: {:ok, socket}
  def noreply(socket), do: {:noreply, socket}
end
