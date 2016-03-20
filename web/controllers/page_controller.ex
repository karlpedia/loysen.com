defmodule Loysen.PageController do
  use Loysen.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
