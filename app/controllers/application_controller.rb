class ApplicationController < ActionController::Base
  # csrf対策
  protect_from_forgery with: :exception
  include SessionsHelper
  
  COLOR_AND_HIGHLIGHT = {
    'food' => {:color => '#9acce3', :highlight => '#aadbf2'},
    'eating_out' => {:color => '#70b062', :highlight => '#7fc170'},
    'daily_necessities' => {:color => '#dbdf19', :highlight => '#ecef23'},
    'traffic' => {:color => '#a979ad', :highlight => '#bb8ebf'},
    'clothes' => {:color => '#cd5638', :highlight => '#e2694a'},
    'companionship' => {:color => '#FFABCE', :highlight => '#FFBEDA'},
    'hobby' => {:color => '#222222', :highlight => '#333333'},
    'other' => {:color => '#AAAAAA', :highlight => '#BBBBBB'}
  }
end
