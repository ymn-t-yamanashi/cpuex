defmodule Cpuex.CpuInfo do
  alias VegaLite, as: Vl

  def get_cpuinfo do
    File.read!("/proc/cpuinfo")
    |> String.split("\n")
    |> Enum.filter(&String.match?(&1, ~r/cpu MHz/))
    |> Enum.map(&get_mhz(&1))
  end

  defp get_mhz(v) do
    String.split(v, ":")
    |> List.last()
    |> String.split(".")
    |> List.first()
    |> String.trim()
    |> String.to_integer()
  end

  def create_graph(cpuinfo, history \\ []) do
    Vl.new(width: 800, height: 400)
    |> Vl.concat(
      [
        create_bar_graph(cpuinfo),
        create_line_graph(history |> List.first())
      ],
      :vertical
    )
    |> Vl.Export.to_png()
    |> Base.encode64()
    |> then(&"data:image/png;base64,#{&1}")
  end

  defp create_bar_graph(cpuinfo) do
    Vl.new(width: 800)
    |> Vl.data_from_values(x: 1..32, y: cpuinfo)
    |> Vl.mark(:bar, color: "#ffaaaa", width: 20)
    |> Vl.encode_field(:x, "x", type: :quantitative, scale: %{domain: [0, 32]})
    |> Vl.encode_field(:y, "y", type: :quantitative, scale: %{domain: [0, 6000]})
  end

  defp create_line_graph(cpuinfo) do
    Vl.new(width: 800)
    |> Vl.data_from_values(x: 1..10, y: cpuinfo)
    |> Vl.mark(:line, color: "#ffaaaa", width: 20)
    |> Vl.encode_field(:x, "x", type: :quantitative, scale: %{domain: [0, 100]})
    |> Vl.encode_field(:y, "y", type: :quantitative, scale: %{domain: [0, 6000]})
  end
end
