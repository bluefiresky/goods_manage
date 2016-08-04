defmodule GoodsManage.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :customer, :string
      add :sales_department, :string
      add :customer_address, :string
      add :telephone, :string
      add :phone, :string
      add :purchase_date, :integer
      add :customer_demand, :string
      add :goods_name, :string
      add :receive_num, :integer
      add :receive_date, :integer
      add :install_date, :integer
      add :order_no, :string
      add :dispatching_date_local, :integer
      add :dispatching_date_service, :integer
      add :is_installed, :boolean, default: false

      timestamps()
    end

  end
end
