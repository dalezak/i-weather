Geocoder.configure(
  # street address geocoding service (default :nominatim)
  lookup: :nominatim,

  # # IP address geocoding service (default :ipinfo_io)
  ip_lookup: :ipinfo_io,

  # # to use an API key:
  # api_key: "...",

  # geocoding service request timeout, in seconds (default 3):
  timeout: 5,

  # set default units to kilometers:
  units: :km,

  # caching (see Caching section below for details):
  # cache: Redis.new,
  # cache_options: {
  #   expiration: 1.day, # Defaults to `nil`
  #   prefix: "another_key:" # Defaults to `geocoder:`
  # }
)
