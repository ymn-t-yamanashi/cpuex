defmodule Cpuex.Cpus do
  @moduledoc """
  The Cpus context.
  """

  import Ecto.Query, warn: false
  alias Cpuex.Repo

  alias Cpuex.Cpus.Cpu

  @doc """
  Returns the list of cpus.

  ## Examples

      iex> list_cpus()
      [%Cpu{}, ...]

  """
  def list_cpus do
    Repo.all(Cpu)
  end

  @doc """
  Gets a single cpu.

  Raises `Ecto.NoResultsError` if the Cpu does not exist.

  ## Examples

      iex> get_cpu!(123)
      %Cpu{}

      iex> get_cpu!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cpu!(id), do: Repo.get!(Cpu, id)

  @doc """
  Creates a cpu.

  ## Examples

      iex> create_cpu(%{field: value})
      {:ok, %Cpu{}}

      iex> create_cpu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cpu(attrs \\ %{}) do
    %Cpu{}
    |> Cpu.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cpu.

  ## Examples

      iex> update_cpu(cpu, %{field: new_value})
      {:ok, %Cpu{}}

      iex> update_cpu(cpu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cpu(%Cpu{} = cpu, attrs) do
    cpu
    |> Cpu.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cpu.

  ## Examples

      iex> delete_cpu(cpu)
      {:ok, %Cpu{}}

      iex> delete_cpu(cpu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cpu(%Cpu{} = cpu) do
    Repo.delete(cpu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cpu changes.

  ## Examples

      iex> change_cpu(cpu)
      %Ecto.Changeset{data: %Cpu{}}

  """
  def change_cpu(%Cpu{} = cpu, attrs \\ %{}) do
    Cpu.changeset(cpu, attrs)
  end
end
