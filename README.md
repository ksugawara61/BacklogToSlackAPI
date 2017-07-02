# sinatra template

## How to Install

```
$ bundle install --path vendor/bundle
```

## How to Test

* All files

```
$ bundle exec rspec spec
```

* Only specific file

```
$ bundle exec rspec spec/hello_spec.rb
```

## Initial Setting

```
$ export SLACK_API_TOKEN="xoxp-XXXXXXXXXXXXXXXXXXXXXXXXXXXX" # API TOKEN of Slack
$ export SLACK_CHANNEL="#backlog-slack"
$ export SLACK_BOT_USERNAME="Backlog"
```

## How to Run

```
$ bundle exec rackup -o 0.0.0.0 -p 8080
```

## Deploy heroku

```
$ heroku create backlog-to-slack-api
$ heroku config:set SLACK_API_TOKEN=xoxp-XXXXXXXXXXXXXXXXXXXXXXXXXXXX" # API TOKEN of Slack
$ heroku config:set SLACK_CHANNEL=#backlog-slack
$ heroku config:set SLACK_BOT_USERNAME=Backlog
$ git push heroku master
```

## References
1. Sinatra, http://www.sinatrarb.com/, Online; accessed 19-July-2016. 
2. rbenvを用いたruby環境構築手順（CentOS7.1） - Qiita, http://qiita.com/ksugawara61/items/e3bb87d5e0dd49d20c8f, Online; accessed 14-September-2016.
3. ruby+rbenv+sinatraの環境構築 - Qiita, http://qiita.com/ksugawara61/items/c1a0572353668c58e87a, Online; accessed 14-September-2016.

