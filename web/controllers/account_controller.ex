defmodule GoodsManage.AccountController do
  use GoodsManage.Web, :controller

  alias GoodsManage.Account
  alias GoodsManage.ReturnView, as: Return

  def index(conn, _params) do
    return(conn, {:index, %{}})
  end

  def password(conn, _params) do
    return(conn, {:password, %{}})
  end

  def modify_password(conn, %{"password" => p}) do
    case Account.modify_password((conn.assigns[:account]).uuid, p) do
      {:ok, account} ->
        return(conn, {:info, "修改成功", %{}, "show.html"})
      {:error, error} ->
        return(conn, {:error, error, %{}, "show.html"})
    end
  end

  def new(conn, _params) do
    changeset = Account.changeset(%Account{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account" => account_params}) do
    changeset = Account.changeset(%Account{}, account_params)

    case Repo.insert(changeset) do
      {:ok, _account} ->
        conn
        |> put_flash(:info, "Account created successfully.")
        # |> redirect(to: account_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Repo.get!(Account, id)
    render(conn, "show.html", account: account)
  end

  def edit(conn, %{"id" => id}) do
    account = Repo.get!(Account, id)
    changeset = Account.changeset(account)
    render(conn, "edit.html", account: account, changeset: changeset)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Repo.get!(Account, id)
    changeset = Account.changeset(account, account_params)

    case Repo.update(changeset) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account updated successfully.")
        |> redirect(to: account_path(conn, :show, account))
      {:error, changeset} ->
        render(conn, "edit.html", account: account, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Repo.get!(Account, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(account)

    conn
    |> put_flash(:info, "Account deleted successfully.")
    # |> redirect(to: account_path(conn, :index))
  end

  defp return(conn, params) do
    case params do
      {:error, error, p, template} ->
        Return.return(conn, "app.html", template, p, nil, error)
      {:info, info, p, template} ->
        Return.return(conn, "app.html", template, p, info, nil)
      {:index, p} ->
        Return.return(conn, "app.html", "index.html", p, nil, nil)
      {:password, p} ->
        Return.return(conn, "app.html", "show.html", p, nil, nil)
    end
  end
end
