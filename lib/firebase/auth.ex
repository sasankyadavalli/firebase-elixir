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

  
end