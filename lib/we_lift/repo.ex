defmodule WeLift.Repo do
  use Ecto.Repo,
    otp_app: :we_lift,
    adapter: Ecto.Adapters.Postgres
end
