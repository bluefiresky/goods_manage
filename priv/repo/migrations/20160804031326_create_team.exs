defmodule GoodsManage.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :uuid, :uuid
      add :name, :string
      add :phone, :string
      add :operation, :string, default: ""

      timestamps()
    end

  end
end
