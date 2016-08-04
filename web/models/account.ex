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
    |> validate_required([:uuid, :account, :password])
  end

  def get_by_account_password(account, password) do
    Repo.get_by(GoodsManage.Account, %{account: account, password: :crypto.hash(:md5, password)|> Base.encode16})
  end

  def get_by_uuid(uuid) do
    account = Repo.get_by(GoodsManage.Account, uuid: uuid)
    %{uuid: account.uuid, account: account.account, is_admin: account.is_admin, enabled: account.enabled}
  end

  def modify_password(uuid, password) do
    account = Repo.get_by(GoodsManage.Account, uuid: uuid)
    cs = changeset(account, %{password: :crypto.md5(password)|> Base.encode16})
    case Repo.update(cs) do
      {:ok, account} ->
        {:ok, account}
      {:error, cs} ->
        {:ok, "保存数据失败"}
    end
  end
end
