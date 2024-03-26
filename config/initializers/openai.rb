OpenAI.configure do |config|
    config.access_token = ENV.fetch("openai_key")
end