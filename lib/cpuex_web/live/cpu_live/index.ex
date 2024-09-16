defmodule CpuexWeb.CpuLive.Index do
  alias VegaLite, as: Vl
  use CpuexWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Process.send_after(self(), :update, 250)

    socket
    |> assign(graph: create_graph())
    |> ok()
  end

  @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 250)

    socket
    |> assign(graph: create_graph())
    |> noreply()
  end

  def get_cpuinfo do
    File.read!("/proc/cpuinfo")
    |> String.split("\n")
    |> Enum.filter(&String.match?(&1, ~r/cpu MHz/))
    |> Enum.map(&get_mhz(&1))
  end

  def get_mhz(v) do
    String.split(v, ":")
    |> List.last()
    |> String.split(".")
    |> List.first()
    |> String.trim()
    |> String.to_integer()
  end

  def create_graph() do
    Vl.new(width: 800, height: 400)
    |> Vl.data_from_values(x: 1..32, y: get_cpuinfo())
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
