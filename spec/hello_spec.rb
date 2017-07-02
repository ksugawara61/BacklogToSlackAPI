# encoding: utf-8

require File.dirname(__FILE__) + '/spec_helper'

describe "App" do
  def app
    APPS.first
  end

  before do
    get '/'
  end

  it "正常なレスポンスが返ること" do
    expect(last_response).to be_ok
  end

end
