defmodule CpuexWeb.CpuControllerTest do
  use CpuexWeb.ConnCase

  import Cpuex.CpusFixtures

  alias Cpuex.Cpus.Cpu

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cpus", %{conn: conn} do
      conn = get(conn, ~p"/api/cpus")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cpu" do
    test "renders cpu when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/cpus", cpu: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/cpus/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/cpus", cpu: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cpu" do
    setup [:create_cpu]

    test "renders cpu when data is valid", %{conn: conn, cpu: %Cpu{id: id} = cpu} do
      conn = put(conn, ~p"/api/cpus/#{cpu}", cpu: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/cpus/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cpu: cpu} do
      conn = put(conn, ~p"/api/cpus/#{cpu}", cpu: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cpu" do
    setup [:create_cpu]

    test "deletes chosen cpu", %{conn: conn, cpu: cpu} do
      conn = delete(conn, ~p"/api/cpus/#{cpu}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/cpus/#{cpu}")
      end
    end
  end

  defp create_cpu(_) do
    cpu = cpu_fixture()
    %{cpu: cpu}
  end
end
