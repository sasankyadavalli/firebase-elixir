defmodule Firebase.Auth do
  @moduledoc false

  @returnSecureToken true
  @headers [{"Content-Type", "application/json"}]

  defp encode_custom_token_to_id_or_refresh_token(token) when is_binary(token) do
    {:ok, token} = Poison.encode(%{"token" => token, "returnSecureToken" => @returnSecureToken})

    token
  end

  defp url_custom_to_id_token do
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken?key=" <> System.get_env("FIREBASE")
  end

  @doc """
    Exchange custom token for an ID and refresh token

    Function no: 1
  """
  def custom_token_to_id_or_refresh_token(token) when is_binary(token) do
    HTTPoison.post(url_custom_to_id_token(), encode_custom_token_to_id_or_refresh_token(token), @headers)
  end

  def refresh_to_id_token(token) when is_binary(token) do
    HTTPoison.post(url_refresh_to_id_token(), encode_refresh_to_id_token(token), [{"Content-Type", "application/x-www-form-urlencoded"}])
  end
  
  def url_refresh_to_id_token do
    "https://securetoken.googleapis.com/v1/token?key=" <> System.get_env("FIREBASE")
  end

  def encode_refresh_to_id_token(token) when is_binary(token) do
    {:ok, token} = Poison.encode(%{"refresh_token" => token, "grant_type" => "refresh_token"})

    token
  end

  defp url_signup_with_email do
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=" <> System.get_env("FIREBASE")
  end

  defp encode_signup_with_email(email, password) do
    {:ok, attrs} = Poison.encode(%{"email" => email, "password" => password, "returnSecureToken" => @returnSecureToken})
    attrs
  end

  def signup_with_email(email, password) do
    HTTPoison.post(url_signup_with_email(), encode_signup_with_email(email, password), @headers)
  end

  defp url_signin_with_email do
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=" <> System.get_env("FIREBASE")
  end

  defp encode_signin_with_email(email, password) do
    {:ok, attrs} = Poison.encode(%{"email" => email, "password" => password, "returnSecureToken" => @returnSecureToken})
    attrs
  end

  def signin_with_email(email, password) do
    HTTPoison.post(url_signin_with_email(), encode_signin_with_email(email, password), @headers)
  end

  defp url_signin_anonymously do
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=" <> System.get_env("FIREBASE")
  end

  defp encode_signin_anonymously() do
    {:ok, attrs} = Poison.encode(%{"returnSecureToken" => @returnSecureToken})

    attrs
  end

  def signin_anonymously() do
    HTTPoison.post(url_signin_anonymously(), encode_signin_anonymously(), @headers)
  end

  defp url_send_password_reset do
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/getOobConfirmationCode?key=" <> System.get_env("FIREBASE")
  end

  defp encode_send_password_reset(email) do
    {:ok, attrs} = Poison.encode(%{"email" => email, "requestType" => "PASSWORD_RESET"})

    attrs
  end

  def send_password_reset(email) do
    HTTPoison.post(url_send_password_reset(), encode_send_password_reset(email), @headers)
  end

  defp url_verify_password_reset() do
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/resetPassword?key=" <> System.get_env("FIREBASE")
  end

  defp encode_verify_password_reset(code) do
    {:ok, attrs} = Poison.encode(%{"oobCode" => code})

    attrs
  end

  def verify_password_reset(code) do
    HTTPoison.post(url_verify_password_reset(), encode_verify_password_reset(code), @headers)
  end

  defp url_confirm_password_reset do
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/resetPassword?key=" <> System.get_env("FIREBASE")
  end

  defp encode_confirm_password_reset(code, new_password) do
    {:ok, attrs} = Poison.encode(%{"oobCode" => code, "newPassword" => new_password})
    attrs
  end

  def confirm_password_reset(code, new_password) do
    HTTPoison.post(url_confirm_password_reset(), encode_confirm_password_reset(code, new_password), @headers)
  end

  defp url_change_email do
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo?key=" <> System.get_env("FIREBASE")
  end

  defp encode_change_email(token, email) do
    {:ok, attrs} = Poison.encode(%{"idToken" => token, "email" => email, "returnSecureToken" => @returnSecureToken})

    attrs
  end

  def change_email(token, email) do
    HTTPoison.post(url_change_email(), encode_change_email(token, email), @headers)
  end

  defp url_change_password do
    "https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo?key=" <> System.get_env("FIREBASE")
  end

  defp encode_change_password(token, password) do
    {:ok, attrs} = Poison.encode(%{"idToken" => token, "password" => password, "returnSecureToken" => @returnSecureToken})
    attrs
  end

  def change_password(token, password) do
    HTTPoison.post(url_change_password(), encode_change_password(token, password), @headers)
  end
end
