defmodule Loysen.GifController do
  use Loysen.Web, :controller

  alias Loysen.Gif

  plug :scrub_params, "gif" when action in [:create, :update]

  @optional_params %{"search" => "", "ignoreNSFW" => false}

  def index(conn, params) do
    params = Map.merge(@optional_params, params)
    search = Map.get(params, "search");
    ignoreNSFW = Map.get(params, "ignoreNSFW")

    gifs = Gif
    |> nameSearch(search)
    |> filterNSFW(ignoreNSFW)
    |> Repo.all

    conn
    |> assign(:gifs, gifs)
    |> assign(:query, search)
    |> assign(:ignoreNSFW, true)
    |> render("index.html")
  end
  
  defp nameSearch(query, "") do
    query
  end

  defp nameSearch(query, queryString) do
    likeString = [queryString, "%"] |> Enum.join
    from g in query, where: ilike(g.name, ^likeString)
  end

  defp filterNSFW(query, ignoreNSFW) do
    if ignoreNSFW do
        from g in query,
        where: g.nsfw == false
    else
        query
    end
  end

  def new(conn, _params) do
    changeset = Gif.changeset(%Gif{}, %{points: 0})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gif" => gif_params}) do
    changeset = Gif.changeset(%Gif{}, gif_params)

    case Repo.insert(changeset) do
      {:ok, _gif} ->
        conn
        |> put_flash(:info, "Gif created successfully.")
        |> redirect(to: gif_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    gif = Repo.get!(Gif, id)
    render(conn, "show.html", gif: gif)
  end

  def edit(conn, %{"id" => id}) do
    gif = Repo.get!(Gif, id)
    changeset = Gif.changeset(gif)
    render(conn, "edit.html", gif: gif, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gif" => gif_params}) do
    gif = Repo.get!(Gif, id)
    changeset = Gif.changeset(gif, gif_params)

    case Repo.update(changeset) do
      {:ok, gif} ->
        conn
        |> put_flash(:info, "Gif updated successfully.")
        |> redirect(to: gif_path(conn, :show, gif))
      {:error, changeset} ->
        render(conn, "edit.html", gif: gif, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gif = Repo.get!(Gif, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(gif)

    conn
    |> put_flash(:info, "Gif deleted successfully.")
    |> redirect(to: gif_path(conn, :index))
  end
end
