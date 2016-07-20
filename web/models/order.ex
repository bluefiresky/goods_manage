defmodule GoodsManage.Order do
  use GoodsManage.Web, :model

  schema "orders" do
    field :customer, :string
    field :sales_department, :string
    field :customer_address, :string
    field :telephone, :string
    field :phone, :string
    field :perchase_date, :integer
    field :customer_demand, :string
    field :goods_name, :string
    field :receive_num, :integer
    field :receive_address, :string
    field :receive_date, :integer
    field :install_date, :integer
    field :order_no, :string
    field :dispatching_date_local, :integer
    field :dispatching_date_service, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:customer, :sales_department, :customer_address, :telephone, :phone, :perchase_date, :customer_demand, :goods_name, :receive_num, :receive_address, :receive_date, :install_date, :order_no, :dispatching_date_local, :dispatching_date_service])
    |> validate_required([:customer, :sales_department, :customer_address, :telephone, :phone, :perchase_date, :customer_demand, :goods_name, :receive_num, :receive_address, :receive_date, :install_date, :order_no, :dispatching_date_local, :dispatching_date_service])
  end
end
