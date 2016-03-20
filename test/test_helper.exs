ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Loysen.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Loysen.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Loysen.Repo)

