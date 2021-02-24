defmodule Rocketpay.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias Rocketpay.Account

  ## module variable - binary_id means uuid
  @primary_key{:id, :binary_id , autogenerate: true }
  ## module variable
  @required_params [:name, :age, :email, :password, :nickname]

  @mail_regex ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password_hash, :string
    field :password, :string , virtual: true
    field :nickname, :string
    field :ssn, :string
    has_one :account, Account

    timestamps()
  end

  def changeset( params ) do
    #module is an empty struct of user
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_number(:age , greater_than_or_equal_to: 18 )
    |> validate_format(:email, @mail_regex)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset ) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash( changeset ), do: changeset

end
