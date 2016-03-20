defmodule Loysen.GifTest do
  use Loysen.ModelCase

  alias Loysen.Gif

  @valid_attrs %{name: "some content", points: 42, tags: [], url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Gif.changeset(%Gif{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Gif.changeset(%Gif{}, @invalid_attrs)
    refute changeset.valid?
  end
end
