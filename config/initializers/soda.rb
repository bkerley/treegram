SODA_CLIENT = SODA::Client.new(
  domain: "data.miamigov.com",
  app_token: Rails.application.secrets.socrata_app_token
)
