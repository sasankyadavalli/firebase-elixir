defmodule Firebase.AuthTest do
  use ExUnit.Case
  
  test "verify signup_with_email" do
    email = Faker.Internet.safe_email()
    password = "Sasi@$123456"

    {:ok, %HTTPoison.Response{body: body, headers: _,request_url: _, status_code: status_code}} = Firebase.Auth.signup_with_email(email, password)

    resp_email = 
      body
      |> Poison.decode!()
      |> Map.get("email") 
    
    assert status_code == 200
    assert resp_email == email
  end
end
