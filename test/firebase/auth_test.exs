defmodule Firebase.AuthTest do
  use ExUnit.Case
  
  test "verify signup_with_email" do
    email = Faker.Internet.safe_email()
    password = Faker.Name.name()

    {:ok, %HTTPoison.Response{body: body, headers: _,request_url: _, status_code: status_code}} = Firebase.Helper.signup_with_email(email, password)

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

    {:ok, _} = Firebase.Helper.signup_with_email(email, password)
    
    {:ok, %HTTPoison.Response{body: body,  headers: _, request_url: _, status_code: status_code}} = Firebase.Helper.signin_with_email(email, password)

    resp_email = 
      body
      |> Poison.decode!()
      |> Map.get("email")

    assert status_code == 200
    assert resp_email == email
  end

  test "verify user signin_anonymously" do
    {:ok, %HTTPoison.Response{body: _, headers: _, request_url: _, status_code: status_code}} = Firebase.Helper.signin_anonymously()

    assert status_code == 200
  end

  test "send password reset email" do
    email = Faker.Internet.safe_email()
    password = Faker.Name.name()

    {:ok, _} = Firebase.Helper.signup_with_email(email, password)

    {:ok, %HTTPoison.Response{body: body, headers: _, request_url: _, status_code: status_code}} = Firebase.Helper.send_password_reset(email)

    resp_email = 
      body
      |> Poison.decode!()
      |> Map.get("email")

    assert status_code == 200
    assert resp_email == email
  end

  test "verify change email" do
    email = Faker.Internet.safe_email()
    password = Faker.Name.name()

    {:ok, _} = Firebase.Helper.signup_with_email(email, password)

    {:ok, %HTTPoison.Response{body: signin_body, headers: _, request_url: _, status_code: _}} = Firebase.Helper.signin_with_email(email, password)

    idToken =
      signin_body
      |> Poison.decode!()
      |> Map.get("idToken")

    new_email = Faker.Internet.safe_email()

    {:ok, %HTTPoison.Response{body: body, headers: _, request_url: _, status_code: status_code}} = Firebase.Helper.change_email(idToken, new_email)

    resp_email = 
      body
      |> Poison.decode!()
      |> Map.get("email")

      assert status_code == 200
      assert resp_email == new_email
  end

  test "verify change password" do
    email = Faker.Internet.safe_email()
    password = Faker.Name.name()

    {:ok, _} = Firebase.Helper.signup_with_email(email, password)

    {:ok, %HTTPoison.Response{body: signin_body, headers: _, request_url: _, status_code: _}} = Firebase.Helper.signin_with_email(email, password)
    
    idToken = 
      signin_body
      |> Poison.decode!()
      |> Map.get("idToken")

    new_password = Faker.Name.name()

    {:ok, %HTTPoison.Response{body: body, headers: _, request_url: _, status_code: status_code}} = Firebase.Helper.change_password(idToken, new_password)

    resp_email =
      body
      |> Poison.decode!()
      |> Map.get("email")

    assert status_code == 200
    assert resp_email == email
  end
end
