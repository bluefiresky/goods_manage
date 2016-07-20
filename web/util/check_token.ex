defmodule GoodsManage.CheckoutToken do
  import Plug.Conn
  @to_root ["/session"]

  # init 在程序启动时运行，用以初始化产给call的参数，eg:default
  def init(default), do: ["/session", "/"]

  def call(conn, default) do
    r = Enum.member?(default, conn.request_path)
    if r do
      assign(conn, :local, default)
    else
      IO.puts "doing need token"
      assign(conn, :local, default)
    end
  end

  defp check_to_root(conn, path) do
    Enum.member?(@to_root, path)
  end

  defp return_to(conn, path) do
    Phoenix.Controller.redirect conn, to: path
    raise "invalid request"
  end

end
