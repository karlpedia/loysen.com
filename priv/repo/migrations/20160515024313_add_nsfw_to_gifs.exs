defmodule Loysen.Repo.Migrations.AddNsfwToGifs do
  use Ecto.Migration

  def change do
    alter table(:gifs) do
        add :nsfw, :boolean
    end
  end
end
