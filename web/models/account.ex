defmodule GoodsManage.Account do
  use GoodsManage.Web, :model

  schema "accounts" do
    field :uuid, Ecto.UUID
    field :account, :string
    field :password, :string
    field :is_admin, :boolean, default: false
    field :enabled, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uuid, :account, :password])
    |> validate_required([:uuid, :password, :account])
  end
end
