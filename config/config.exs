import Config

config :recaptcha,
  base_url: System.get_env("RECAPTCHA_BASE_URL", "https://www.recaptcha.net/recaptcha/api"),
  public_key: System.get_env("RECAPTCHA_PUBLIC_KEY"),
  secret: System.get_env("RECAPTCHA_PRIVATE_KEY")
