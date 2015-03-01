defmodule Repo do
  use Ecto.Repo,
    otp_app: :temp_log,
    adapter: Ecto.Adapters.Postgres
end
