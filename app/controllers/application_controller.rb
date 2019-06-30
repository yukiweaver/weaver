class ApplicationController < ActionController::Base
  # csrf対策
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def hello
    render html: "hello, world!"
  end
end
