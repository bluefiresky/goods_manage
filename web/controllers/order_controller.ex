defmodule GoodsManage.OrderController do
  use GoodsManage.Web, :controller

  alias GoodsManage.Order
  alias GoodsManage.ReturnView, as: Return

  def index(conn, _params) do
    changeset = Order.changeset(%Order{})
    return(conn, {:index, %{changeset: changeset}})
  end

  def create(conn, %{"order" => order_params}) do
    changeset = Order.changeset(%Order{})
    case Order.insert(order_params) do
      {:ok, _order} ->
        return(conn, {:info, "保存成功", %{changeset: changeset}, "index.html"})
      {:error, error} ->
        return(conn, {:error, error, %{changeset: changeset}, "index.html"})
    end
  end

  def orders(conn, %{"type" => t, "installed" => i, "offset" => o, "limit" => l}) do
    orders = Order.orders(i,o,l)
    return(conn, {:orders, %{orders: orders, type: t}})
  end

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

  defp return(conn, params) do
    case params do
      {:error, error, p, template} ->
        Return.return(conn, "app.html", template, p, nil, error)
      {:info, info, p, template} ->
        Return.return(conn, "app.html", template, p, info, nil)
      {:index, p} ->
        Return.return(conn, "app.html", "index.html", p, nil, nil)
      {:orders, p} ->
        Return.return(conn, "app.html", "order.html", p, nil, nil)
    end
  end
end
