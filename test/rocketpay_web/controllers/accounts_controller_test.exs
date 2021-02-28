defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "John Doe",
        password: "123456",
        nickname: "johndoe",
        email: "john@doe.com",
        age: 51
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      username_password_base64 = Base.encode64("#{params.nickname}:#{params.password}")
      conn = put_req_header(conn, "authorization", "Basic #{username_password_base64}")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposity", %{conn: conn, account_id: account_id} do

      params = %{"value" => "50.00"}

      response =
      conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:ok)

      assert %{
        "account" => %{"balance" => "50.00", "id" => _id } ,
        "message" => "Balance changed successfully"
      } = response

    end

    test "when there are invalid params returns error", %{conn: conn, account_id: account_id} do

      params = %{"value" => "xpto"}

      response =
      conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:bad_request)

      expected_response = %{
        "message" => "Invalid deposit value!"
      }

      assert response == expected_response

    end



  end
end
