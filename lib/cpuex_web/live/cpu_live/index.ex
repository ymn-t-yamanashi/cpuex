defmodule CpuexWeb.CpuLive.Index do
  alias VegaLite, as: Vl
  alias Cpuex.CpuInfo
  use CpuexWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Process.send_after(self(), :update, 250)
    cpuinfo = CpuInfo.get_cpuinfo()
    max_mhz = Enum.max(cpuinfo)

    socket
    |> assign(max_mhz: max_mhz)
    |> assign(graph: create_graph(cpuinfo))
    |> ok()
  end

  @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 250)
    cpuinfo = CpuInfo.get_cpuinfo()

    max_mhz = Enum.max(cpuinfo ++ [socket.assigns.max_mhz])

    socket
    |> assign(max_mhz: max_mhz)
    |> assign(graph: create_graph(cpuinfo))
    |> noreply()
  end

  def create_graph(cpuinfo) do
    Vl.new(width: 800, height: 400)
    |> Vl.data_from_values(x: 1..32, y: cpuinfo)
    |> Vl.mark(:bar, color: "#ffaaaa", width: 20)
    |> Vl.encode_field(:x, "x", type: :quantitative)
    |> Vl.encode_field(:y, "y", type: :quantitative)
    |> Vl.Export.to_png()
    |> Base.encode64()
    |> then(&"data:image/png;base64,#{&1}")
  end

  def ok(socket), do: {:ok, socket}
  def noreply(socket), do: {:noreply, socket}
end
