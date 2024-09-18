defmodule Cpuex.Repo.Migrations.CreateCpus do
  use Ecto.Migration

  def change do
    create table(:cpus) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
