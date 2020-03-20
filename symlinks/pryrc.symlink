Pry.config.pager = false

# Rails prompt formatter.
def formatted_env
  return "irb" unless defined?(Rails)
  case Rails.env
  when "production"
    Pry::Helpers::Text.red(Pry::Helpers::Text.bold(Rails.env))
  when "staging"
    Pry::Helpers::Text.yellow(Rails.env)
  when "development"
    Pry::Helpers::Text.green(Rails.env)
  else
    Rails.env
  end
end

def app_name
  ENV["HEROKU_APP_NAME"] || ENV["APP_NAME"] || File.basename(Rails.root)
end

if defined?(Rails)
  Pry.config.prompt = proc { |obj, nest_level, _| "[#{app_name}][#{formatted_env}] #{obj}:#{nest_level} » " }
end
