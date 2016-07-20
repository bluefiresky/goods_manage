defmodule GoodsManage.PageController do
  use GoodsManage.Web, :controller
  import Ecto.Query

  alias GoodsManage.ErrorView, as: Error
  alias GoodsManage.ReturnView, as: Return
  alias GoodsManage.Account
  alias GoodsManage.Utility

  def index(conn, _params) do
    return(conn, {:index, %{}})
  end

  def session(conn, %{"account" => a, "password" => p}) do
    account = Repo.get_by(Account, %{account: a, password: :crypto.md5(p)|> Base.encode16})
    if account != nil do
      case Utility.generate_token(account.uuid) do
        {:ok, token} ->
          return(conn, {:session, token[:access_token]})
        {:error, err} ->
          return(conn, {:error, "服务器内部错误"})
      end
    else
      return(conn, {:error, "帐号或密码不正确"})
    end
  end

  defp return(conn, params) do
    case params do
      {:error, error} ->
        Return.return(conn, "page_layout.html", "index.html", %{}, nil, error)
      {:info, info} ->
        Return.return(conn, "page_layout.html", "index.html", %{}, info, nil)
      {:index, p} ->
        Return.return(conn, "page_layout.html", "index.html", p, nil, nil)
      {:session, p} ->
        redirect conn, to: "/orders"
    end
  end

end
