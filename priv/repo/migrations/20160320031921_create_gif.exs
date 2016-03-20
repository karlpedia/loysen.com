defmodule Loysen.Repo.Migrations.CreateGif do
  use Ecto.Migration

  def change do
    create table(:gifs) do
      add :name, :string
      add :url, :string
      add :points, :integer
      add :tags, {:array, :string}

      timestamps
    end

  end
end
