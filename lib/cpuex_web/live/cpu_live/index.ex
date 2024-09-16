defmodule CpuexWeb.CpuLive.Index do
  use CpuexWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Process.send_after(self(), :update, 250)
    {:ok, socket}
  end

  @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 250)
    {:noreply, socket}
  end
end
