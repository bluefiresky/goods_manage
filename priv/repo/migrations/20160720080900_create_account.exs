defmodule GoodsManage.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :uuid, :uuid
      add :account, :string
      add :password, :string
      add :is_admin, :boolean, default: false, null: false
      add :enabled, :boolean, default: false, null: false

      timestamps()
    end

  end
end
