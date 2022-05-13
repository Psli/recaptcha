defmodule Tesla.Middleware.RecaptchaSimpleResponse do
  @behaviour Tesla.Middleware

  def call(env, next, _opts) do
    env
    |> Tesla.run(next)
    |> build_response()
  end

  def build_response({:error, reasonn}), do: {:error, reasonn}

  def build_response({:ok, env}) do
    body = env.body

    cond do
      body["success"] -> {:ok, body}
      true -> {:error, body}
    end
  end
end

defmodule Recaptcha.Client do
  use Tesla

  @decode_content_types ["application/json", "text/javascript", "text/plain"]

  adapter Tesla.Adapter.Mint

  plug Tesla.Middleware.RecaptchaSimpleResponse
  plug Tesla.Middleware.BaseUrl, Recaptcha.get_base_url()
  plug Tesla.Middleware.FormUrlencoded
  plug Tesla.Middleware.JSON, decode_content_types: @decode_content_types
end
