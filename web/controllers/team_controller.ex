defmodule GoodsManage.TeamController do
  use GoodsManage.Web, :controller

  alias GoodsManage.Team
  alias GoodsManage.ReturnView, as: Return

  def index(conn, %{"offset" => o, "limit" => l}) do
    teams = Team.teams(o, l)
    return(conn, {:index, %{teams: teams}})
  end

  def new(conn, _params) do
    changeset = Team.changeset(%Team{})
    return(conn, {:new, %{changeset: changeset}})
  end

  def create(conn, %{"team" => team_params}) do
    case Team.insert(team_params) do
      {:ok, _team} ->
        conn
        |> redirect(to: "/teams?offset=0&limit=1")
      {:error, error, changeset} ->
        return(conn, {:error, error, %{changeset: changeset}, "new.html"})
    end
  end

  def show(conn, %{"id" => id}) do
    team = Repo.get!(Team, id)
    render(conn, "show.html", team: team)
  end

  def edit(conn, %{"id" => id}) do
    team = Repo.get!(Team, id)
    changeset = Team.changeset(team)
    render(conn, "edit.html", team: team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Repo.get!(Team, id)
    changeset = Team.changeset(team, team_params)

    case Repo.update(changeset) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team updated successfully.")
        |> redirect(to: team_path(conn, :show, team))
      {:error, changeset} ->
        render(conn, "edit.html", team: team, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Repo.get!(Team, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(team)

    conn
    |> put_flash(:info, "Team deleted successfully.")
    |> redirect(to: team_path(conn, :index))
  end

  defp return(conn, params) do
    case params do
      {:error, error, p, template} ->
        Return.return(conn, "app.html", template, p, nil, error)
      {:info, info, p, template} ->
        Return.return(conn, "app.html", template, p, info, nil)
      {:index, p} ->
        Return.return(conn, "app.html", "index.html", p, nil, nil)
      {:new, p} ->
        Return.return(conn, "app.html", "new.html", p, nil, nil)
    end
  end
end
