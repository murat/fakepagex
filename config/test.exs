import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fakepage, FakepageWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "gbdN3nQVUAp4T0agy/CNYVZRiZn4FufSMS0Gl53X/jbrASOckAx7ChnXgqvM9FZE",
  server: false

# In test we don't send emails.
config :fakepage, Fakepage.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
