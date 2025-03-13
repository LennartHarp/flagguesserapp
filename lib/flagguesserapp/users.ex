defmodule Flagguesserapp.Users do
  import Ecto.Query, warn: false
  alias Flagguesserapp.Repo
  alias Flagguesserapp.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.registration_changeset(user, attrs)
  end

  def get_user!(id) do
    Repo.get_by!(User, id: id)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.registration_changeset(attrs)
    |> Repo.update()
  end

  def admin_update_user(%User{} = user, attrs) do
    user
    |> User.user_admin_changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end
end
