defmodule CpuexWeb.CpuController do
  use CpuexWeb, :controller

  alias Cpuex.Cpus
  alias Cpuex.Cpus.Cpu

  action_fallback CpuexWeb.FallbackController

  def index(conn, _params) do
    cpus = Cpus.list_cpus()
    render(conn, :index, cpus: cpus)
  end

  def create(conn, %{"cpu" => cpu_params}) do
    with {:ok, %Cpu{} = cpu} <- Cpus.create_cpu(cpu_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/cpus/#{cpu}")
      |> render(:show, cpu: cpu)
    end
  end

  def show(conn, %{"id" => id}) do
    cpu = Cpus.get_cpu!(id)
    render(conn, :show, cpu: cpu)
  end

  def update(conn, %{"id" => id, "cpu" => cpu_params}) do
    cpu = Cpus.get_cpu!(id)

    with {:ok, %Cpu{} = cpu} <- Cpus.update_cpu(cpu, cpu_params) do
      render(conn, :show, cpu: cpu)
    end
  end

  def delete(conn, %{"id" => id}) do
    cpu = Cpus.get_cpu!(id)

    with {:ok, %Cpu{}} <- Cpus.delete_cpu(cpu) do
      send_resp(conn, :no_content, "")
    end
  end
end
