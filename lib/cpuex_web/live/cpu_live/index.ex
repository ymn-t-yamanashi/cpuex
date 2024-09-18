defmodule CpuexWeb.CpuLive.Index do
  alias Cpuex.CpuInfo
  use CpuexWeb, :live_view
  @update_time 2500

  @impl true
  def mount(_params, _session, socket) do
    update_cpu_info()

    socket
    |> assign_cpuinfo()
    |> ok()
  end

  @impl true
  def handle_info(:update, socket) do
    update_cpu_info()

    socket
    |> assign_cpuinfo()
    |> noreply()
  end

  defp assign_cpuinfo(socket) do
    cpuinfo = CpuInfo.get_cpuinfo()

    history =
      Map.get(socket.assigns, :history, [])
      |> then(&(&1 ++ [cpuinfo]))
      |> Enum.take(-20)

    max_mhz =
      Map.get(socket.assigns, :max_mhz, 0)
      |> then(&Enum.max(cpuinfo ++ [&1]))

    socket
    |> assign(max_mhz: max_mhz)
    |> assign(history: history)
    |> assign(graph: CpuInfo.create_graph(cpuinfo, history_to_list(history)))
  end

  defp history_to_list(history) do
    history
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list(&1))
  end

  defp update_cpu_info(), do: Process.send_after(self(), :update, @update_time)
  defp ok(socket), do: {:ok, socket}
  defp noreply(socket), do: {:noreply, socket}
end
