defmodule GoodsManage.OrderController do
  use GoodsManage.Web, :controller

  alias GoodsManage.Order
  alias GoodsManage.ReturnView, as: Return

  def index(conn, _params) do
    changeset = Order.changeset(%Order{})
    return(conn, {:index, %{changeset: changeset}}, nil)
  end

  def create(conn, %{"order" => order_params}) do
    case Order.insert(order_params) do
      {:ok, _order} ->
        changeset = Order.changeset(%Order{})
        return(conn, {:info, "保存成功", %{changeset: changeset}}, nil)
      {:error, error} ->
        return(conn, {:error, error}, nil)
    end
  end

  def orders(conn, %{"offset" => o, "limit" => l})

  def show(conn, %{"id" => id}) do
    order = Repo.get!(Order, id)
    render(conn, "show.html", order: order)
  end

  def edit(conn, %{"id" => id}) do
    order = Repo.get!(Order, id)
    changeset = Order.changeset(order)
    render(conn, "edit.html", order: order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Repo.get!(Order, id)
    changeset = Order.changeset(order, order_params)

    case Repo.update(changeset) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order updated successfully.")
        |> redirect(to: order_path(conn, :show, order))
      {:error, changeset} ->
        render(conn, "edit.html", order: order, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Repo.get!(Order, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(order)

    conn
    |> put_flash(:info, "Order deleted successfully.")
    |> redirect(to: order_path(conn, :index))
  end

  defp return(conn, params, template) do
    if template == nil, do: template = "index.html"
    case params do
      {:error, error, p} ->
        Return.return(conn, "app.html", template, p, nil, error)
      {:info, info, p} ->
        Return.return(conn, "app.html", template, p, info, nil)
      {:index, p} ->
        Return.return(conn, "app.html", template, p, nil, nil)
    end
  end
end
