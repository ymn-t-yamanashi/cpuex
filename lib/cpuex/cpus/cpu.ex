defmodule Cpuex.Cpus.Cpu do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cpus" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cpu, attrs) do
    cpu
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
