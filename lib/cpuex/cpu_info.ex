defmodule Cpuex.CpuInfo do
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
end
