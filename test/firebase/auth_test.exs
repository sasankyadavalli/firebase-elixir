defmodule Firebase.AuthTest do
  use ExUnit.Case
  
  test "verify signup_with_email" do
    email = Faker.Internet.safe_email()
    password = Faker.Name.name()

    {:ok, %HTTPoison.Response{body: body, headers: _,request_url: _, status_code: status_code}} = Firebase.Auth.signup_with_email(email, password)

    resp_email = 
      body
      |> Poison.decode!()
      |> Map.get("email") 
    
    assert status_code == 200
    assert resp_email == email
  end

  test "verify signin_with_email" do
    email = Faker.Internet.safe_email()
    password = Faker.Name.name()

    {:ok, _} = Firebase.Auth.signup_with_email(email, password)
    
    {:ok, %HTTPoison.Response{body: body,  headers: _, request_url: _, status_code: status_code}} = Firebase.Auth.signin_with_email(email, password)

    resp_email = 
      body
      |> Poison.decode!()
      |> Map.get("email")

    assert status_code == 200
    assert resp_email == email
  end

  test "verify user signin_anonymously" do
    {:ok, %HTTPoison.Response{body: _, headers: _, request_url: _, status_code: status_code}} = Firebase.Auth.signin_anonymously()

    assert status_code == 200
  end
end
