defmodule ElixirRetouch.Repo do
  use Ecto.Repo,
    otp_app: :elixir_retouch,
    adapter: Ecto.Adapters.Postgres
end
