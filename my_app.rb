require 'bundler'
require 'sinatra'
require 'http'
require 'json'
Bundler.require

class MyApp < Sinatra::Base

  get '/' do
    "Hello World!\n"
  end

  post '/backlog' do
    response = HTTP.post("https://slack.com/api/chat.postMessage", params: {
                           token: ENV['SLACK_API_TOKEN'],
                           channel: ENV['SLACK_CHANNEL'],
                           text: "@katsuya hello world!",
                           username: ENV['SLACK_BOT_USERNAME']
                         })

    JSON.pretty_generate(JSON.parse(response.body))
  end

end
