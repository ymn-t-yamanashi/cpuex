defmodule CpuexWeb.CpuLive.Index do
  use CpuexWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Process.send_after(self(), :update, 250)

    socket
    |> assign(cpus: get_cpuinfo())
    |> ok()
  end

  @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 250)
    socket
    |> assign(cpus: get_cpuinfo())
    |> noreply()
  end

  def get_cpuinfo do
    File.read!("/proc/cpuinfo")
    |> String.split("\n")
    |> Enum.filter(&String.match?(&1, ~r/cpu MHz/))
  end

  def ok(socket), do: {:ok, socket}
  def noreply(socket), do: {:noreply, socket}
end
