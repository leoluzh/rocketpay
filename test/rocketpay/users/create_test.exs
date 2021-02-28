defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create, as: Create


  describe "call/1" do

    test "when all params are valid, returns an user" do

      params = %{
        name: "John Doe",
        password: "123456",
        nickname: "jondoe",
        email: "john@doe.com",
        age: 51
      }

      {:ok , %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "John Doe", age: 51, id: ^user_id } = user

    end

    test "when thera are params invalid, not returns an user" do

      params = %{
        name: "John Doe",
        nickname: "jondoe",
        email: "jane@doe.com",
        age: 17
      }

      {:error , changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response

    end
  end
end
