defmodule TempLog.Entry do
  use Ecto.Model

  # weather is the DB table
  schema "entry" do
    field :temperature, :integer, null: false
    field :timestamp, :datetime, null: false, default: :calendar.local_time
    field :sensor, :string, null: false, size: 40
  end
end
