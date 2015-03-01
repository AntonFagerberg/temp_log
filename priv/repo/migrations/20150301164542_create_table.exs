defmodule Repo.Migrations.CreateTable do
  use Ecto.Migration

  def up do
    create table(:entry) do
      add :temperature, :integer, null: false
      add :timestamp, :datetime, null: false, default: fragment("now()")
      add :sensor, :string, null: false, size: 40
    end
  end

  def down do
    drop table(:entry)
  end
end
