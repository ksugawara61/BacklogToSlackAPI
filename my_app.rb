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
    tmp = request.body.read
    params = JSON.parse tmp

    params.each do |param|
      project     = param['project']
      content     = param['content']
      createdUser = param['createdUser']

      text = '[' + project['projectKey'] + '-' + content['key_id'].to_s +
        '] - ' + content['summary'] + ' by ' + createdUser['name']
      if content['comment']['content']
        text += "\n" + content['comment']['content']
      end

      response = HTTP.post("https://slack.com/api/chat.postMessage", params: {
                             token:    ENV['SLACK_API_TOKEN'],
                             channel:  ENV['SLACK_CHANNEL'],
                             text:     text,
                             username: ENV['SLACK_BOT_USERNAME']
                           })

    end

    status = {
      'status'  => 'success',
      'message' => ''
    }

    JSON.pretty_generate(status)
  end

end
