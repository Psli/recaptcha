defmodule Recaptcha do
  @moduledoc """
  Documentation for `Recaptcha`.
  """

  alias Recaptcha.Client

  @doc """
  Verifies a reCAPTCHA response string.
  Returns `true` if the response is valid, `false` otherwise.
  ## Parameters
  `response` is the response from the user.
  `remote_ip` is the IP address of the user.
  """
  def verify(params) do
    params =
      if Map.has_key?(params, :secret) do
        params
      else
        secret = get_secret()
        Map.put(params, :secret, secret)
      end

    "/siteverify"
    |> Client.post(params)
  end

  def get_public_key() do
    Application.get_env(:recaptcha, :public_key)
  end

  def get_secret() do
    Application.get_env(:recaptcha, :secret)
  end

  def get_base_url() do
    Application.get_env(:recaptcha, :base_url)
  end
end
