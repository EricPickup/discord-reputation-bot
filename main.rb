require 'require_all'
require 'active_record'
require 'pry'
require 'discordrb'
require 'json'
require_all '../rep-bot'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: '../uwindsor-css-hub/db/production.sqlite3'
)

class Main
  SECRETS = JSON.parse(File.read('secrets.json'))

  bot = Discordrb::Commands::CommandBot.new(
    token: SECRETS["api_token"],
    client_id: SECRETS["api_client_id"],
    prefix: '~',
  )

  bot.command(:rep) do |event|
    return if command_sent_as_direct_message_to_bot? (event)

    mentions = event.message.mentions
    binding.pry
  end

  def self.command_sent_as_direct_message_to_bot?(event)
    if event.server.nil?
      return_error(event.user.pm, "This command can only be used in the Discord server. Try sending this command in the #bot-commands channel in the CSS server.")
      return true
    end
    return false
  end

  def self.return_error(channel, message)
    DiscordMessageSender.send_embedded(
      channel,
      title: "Error",
      description: ":bangbang: " + message,
    )
  end

  puts "This bot's invite URL is #{bot.invite_url}."
  puts 'Click on it to invite it to your server.'
  bot.run
end
