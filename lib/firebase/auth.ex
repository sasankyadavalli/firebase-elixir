defmodule Firebase.Auth do
  @moduledoc false

  @returnSecureToken true
  @headers [{"Content-Type", "application/json"}]

  defstruct status_code: nil, body: nil, headers: [], request_url: nil
end
