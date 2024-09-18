defmodule Cpuex.CpusTest do
  use Cpuex.DataCase

  alias Cpuex.Cpus

  describe "cpus" do
    alias Cpuex.Cpus.Cpu

    import Cpuex.CpusFixtures

    @invalid_attrs %{name: nil}

    test "list_cpus/0 returns all cpus" do
      cpu = cpu_fixture()
      assert Cpus.list_cpus() == [cpu]
    end

    test "get_cpu!/1 returns the cpu with given id" do
      cpu = cpu_fixture()
      assert Cpus.get_cpu!(cpu.id) == cpu
    end

    test "create_cpu/1 with valid data creates a cpu" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Cpu{} = cpu} = Cpus.create_cpu(valid_attrs)
      assert cpu.name == "some name"
    end

    test "create_cpu/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cpus.create_cpu(@invalid_attrs)
    end

    test "update_cpu/2 with valid data updates the cpu" do
      cpu = cpu_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Cpu{} = cpu} = Cpus.update_cpu(cpu, update_attrs)
      assert cpu.name == "some updated name"
    end

    test "update_cpu/2 with invalid data returns error changeset" do
      cpu = cpu_fixture()
      assert {:error, %Ecto.Changeset{}} = Cpus.update_cpu(cpu, @invalid_attrs)
      assert cpu == Cpus.get_cpu!(cpu.id)
    end

    test "delete_cpu/1 deletes the cpu" do
      cpu = cpu_fixture()
      assert {:ok, %Cpu{}} = Cpus.delete_cpu(cpu)
      assert_raise Ecto.NoResultsError, fn -> Cpus.get_cpu!(cpu.id) end
    end

    test "change_cpu/1 returns a cpu changeset" do
      cpu = cpu_fixture()
      assert %Ecto.Changeset{} = Cpus.change_cpu(cpu)
    end
  end
end
