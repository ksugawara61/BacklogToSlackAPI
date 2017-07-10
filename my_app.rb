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
    param = JSON.parse tmp

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
      text += "*課題の削除*\n"
    end

    # 課題ID
    issue_id = project['projectKey'] + '-' + content['key_id'].to_s

    # URLを設定
    url = 'https://' + ENV['BACKLOG_HOST'] + '/view/' + issue_id

    # Slackに通知する内容を追記
    text += '[' + issue_id + '] - '
    text += content['summary'] if content.has_key?('summary')
    text += ' by ' + createdUser['name']
    if content.has_key?('comment')
      text += "\n" + content['comment']['content']
      url  += '#comment-' + content['comment']['id'].to_s
    end
    text += "\n>" + url

    # Slack API通信
    response = HTTP.post("https://slack.com/api/chat.postMessage", params: {
                           token:    ENV['SLACK_API_TOKEN'],
                           channel:  ENV['SLACK_CHANNEL'],
                           text:     text,
                           username: ENV['SLACK_BOT_USERNAME']
                         })

    JSON.pretty_generate(JSON.parse(response.body))
  end

end
