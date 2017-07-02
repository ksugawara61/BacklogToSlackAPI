# coding: utf-8

@path = '/var/www/html/example.com/sinatra-template/'  # modify your environment

worker_processes 1
working_directory @path

timeout 300
listen "#{@path}tmp/sock/unicorn.sock"
pid    "#{@path}tmp/pid/unicorn.pid"

stderr_path "#{@path}logs/unicorn.stderr.log"
stdout_path "#{@path}logs/unicorn.stdout.log"
preload_app true
