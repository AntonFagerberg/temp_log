defmodule TempLog.Entry do
  use Ecto.Model

  schema "entry" do
    field :temperature, :integer, null: false
    field :timestamp, Ecto.DateTime, null: false
    field :sensor, :string, null: false, size: 40
  end
end
