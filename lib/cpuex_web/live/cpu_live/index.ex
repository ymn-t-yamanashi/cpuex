defmodule CpuexWeb.CpuLive.Index do
  alias Cpuex.CpuInfo
  use CpuexWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Process.send_after(self(), :update, 250)

    socket
    |> assign_cpuinfo()
    |> ok()
  end

  @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 250)

    socket
    |> assign_cpuinfo()
    |> noreply()
  end

  defp assign_cpuinfo(socket) do
    cpuinfo = CpuInfo.get_cpuinfo()
    max_mhz = Map.get(socket.assigns, :max_mhz, 0)

    max_mhz = Enum.max(cpuinfo ++ [max_mhz])

    socket
    |> assign(max_mhz: max_mhz)
    |> assign(graph: CpuInfo.create_graph(cpuinfo))
  end

  defp ok(socket), do: {:ok, socket}
  defp noreply(socket), do: {:noreply, socket}
end
