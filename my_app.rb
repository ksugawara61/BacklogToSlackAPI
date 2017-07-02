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

    puts params

    params.each do |param|
      project       = param['project']
      type          = param['type']
      content       = param['content']
      createdUser   = param['createdUser']
      notifications = param['notifications']

      text = ''

      # Backlogからのレスポンス結果を通知するユーザを追記
      notifications.each do |notification|
        if !notification['alreadyRead']
          text += '@' + notification['user']['name'] + "\n"
        end
      end

      # Backlogからの変更内容を追記
      case type
      when 1
        text += "*課題の追加*\n"
      when 2,3
        text += "*課題の更新*\n"
      when 4
        text += "*課題のコメント*\n"
      end

      # Slackに通知する内容を追記
      text += '[' + project['projectKey'] + '-' + content['key_id'].to_s +
        '] - ' + content['summary'] + ' by ' + createdUser['name']
      if content['comment']['content']
        text += "\n" + content['comment']['content']
      end

      # Slack API通信
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
