defmodule Loysen.GifControllerTest do
  use Loysen.ConnCase

  alias Loysen.Gif
  @valid_attrs %{name: "some content", points: 42, tags: [], url: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, gif_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing gifs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, gif_path(conn, :new)
    assert html_response(conn, 200) =~ "New gif"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, gif_path(conn, :create), gif: @valid_attrs
    assert redirected_to(conn) == gif_path(conn, :index)
    assert Repo.get_by(Gif, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, gif_path(conn, :create), gif: @invalid_attrs
    assert html_response(conn, 200) =~ "New gif"
  end

  test "shows chosen resource", %{conn: conn} do
    gif = Repo.insert! %Gif{}
    conn = get conn, gif_path(conn, :show, gif)
    assert html_response(conn, 200) =~ "Show gif"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, gif_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    gif = Repo.insert! %Gif{}
    conn = get conn, gif_path(conn, :edit, gif)
    assert html_response(conn, 200) =~ "Edit gif"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    gif = Repo.insert! %Gif{}
    conn = put conn, gif_path(conn, :update, gif), gif: @valid_attrs
    assert redirected_to(conn) == gif_path(conn, :show, gif)
    assert Repo.get_by(Gif, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    gif = Repo.insert! %Gif{}
    conn = put conn, gif_path(conn, :update, gif), gif: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit gif"
  end

  test "deletes chosen resource", %{conn: conn} do
    gif = Repo.insert! %Gif{}
    conn = delete conn, gif_path(conn, :delete, gif)
    assert redirected_to(conn) == gif_path(conn, :index)
    refute Repo.get(Gif, gif.id)
  end
end
