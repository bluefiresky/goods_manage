defmodule GoodsManage.Team do
  use GoodsManage.Web, :model

  schema "teams" do
    field :uuid, Ecto.UUID
    field :name, :string
    field :phone, :string
    field :operation, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uuid, :name, :phone])
    |> validate_required([:uuid, :name, :phone])
  end

  def teams(offset, limit) do
    query = GoodsManage.Team
      |> select([t], t)
      |> limit([t], ^limit)
      |> offset([t], ^offset)
      |> order_by([t], desc: t.updated_at)
    Repo.all(query)
  end

  def insert(params) do
    name = String.strip(params["name"])
    phone = String.strip(params["phone"])
    uuid = UUID.uuid3(:dns, name)
    changeset = GoodsManage.Team.changeset(%GoodsManage.Team{}, %{uuid: uuid, name: name, phone: phone})
    case get_by_uuid(uuid) do
      :ok ->
        case Repo.insert(changeset) do
          {:ok, _team} ->
            {:ok, _team}
          {:error, changeset} ->
            {:error, "保存数据失败", changeset}
        end
      :error ->
        {:error, "保存数据失败", changeset}
    end

  end

  def get_by_uuid(uuid) do
    team = Repo.get_by(GoodsManage.Team, uuid: uuid)
    if is_nil(team) do
      :ok
    else
      :error
    end
  end
end
