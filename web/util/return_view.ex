defmodule GoodsManage.ReturnView do

  def return(conn, layout, template, params, info, error) do
    if error != nil, do: conn = conn |> Phoenix.Controller.put_flash(:error, error)
    if info != nil, do: conn = conn |> Phoenix.Controller.put_flash(:info, info)
    conn
    |> Phoenix.Controller.put_layout(layout)
    |> Phoenix.Controller.render(template, params)
  end

end
