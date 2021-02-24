defmodule :"Elixir.Rocketpay.Repo.Migrations.CreateUserTable.exs" do
  use Ecto.Migration

  def change do
    create table :users do
      add :id, :binary_id , primary_key: true , null: false
      add :name, :string , null: false
      add :age, :integer
      add :email, :string , null: false
      add :password_hash, :string , null: false
      add :nickname, :string , null: false
      add :ssn , :string
      timestamps()
    end
    create unique_index(:users, [:uuid])
    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end

end
