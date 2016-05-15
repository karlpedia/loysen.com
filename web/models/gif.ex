defmodule Loysen.Gif do
  use Loysen.Web, :model

  schema "gifs" do
    field :name, :string
    field :url, :string
    field :points, :integer
    field :tags, {:array, :string}
    field :nsfw, :boolean

    timestamps
  end

  @required_fields ~w(name url points nsfw)
  @optional_fields ~w(tags)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
