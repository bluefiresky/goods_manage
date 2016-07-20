defmodule GoodsManage.OrderView do
  use GoodsManage.Web, :view
end


# <%= for order <- @orders do %> -->
#     <tr>
#      <td><%= order.customer %></td>
#      <td><%= order.sales_department %></td>
#      <td><%= order.customer_address %></td>
#      <td><%= order.telephone %></td>
#      <td><%= order.phone %></td>
#      <td><%= order.perchase_date %></td>
#      <td><%= order.customer_demand %></td>
#      <td><%= order.goods_name %></td>
#      <td><%= order.receive_num %></td>
#      <td><%= order.receive_address %></td>
#      <td><%= order.receive_date %></td>
#      <td><%= order.install_date %></td>
#      <td><%= order.order_no %></td>
#      <td><%= order.dispatching_date_local %></td>
#      <td><%= order.dispatching_date_service %></td>
#
#      <td class="text-right">
#        <%= link "Show", to: order_path(@conn, :show, order), class: "btn btn-default btn-xs" %>
#        <%= link "Edit", to: order_path(@conn, :edit, order), class: "btn btn-default btn-xs" %>
#        <%= link "Delete", to: order_path(@conn, :delete, order), method: :delete, data: [confirm: "Are you sure?"], class: "btn btn-danger btn-xs" %>
#      </td>
#    </tr>
# <% end %>
# <%= link "New order", to: order_path(@conn, :new) %>
