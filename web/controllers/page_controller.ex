defmodule GoodsManage.PageController do
  use GoodsManage.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", name: "wolegequ"
  end
end
