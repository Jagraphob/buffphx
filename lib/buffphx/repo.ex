defmodule Buffphx.Repo do
  use Ecto.Repo,
    otp_app: :buffphx,
    adapter: Ecto.Adapters.Postgres
end
