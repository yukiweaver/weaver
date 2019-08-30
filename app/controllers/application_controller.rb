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

  private

  # ログイン中のみ遷移可能
  def login_check
    if user_id.blank?
      redirect_to root_path
    end
  end

  # ログアウト中のみ遷移可能
  def logout_check
    unless user_id.blank?
      redirect_to household_path(user_id: user_id, status: 'expense')
    end
  end

  # 日付が有効か検証 問題なければtrueを返す
  def date_valid?(str)
    !! Date.parse(str) rescue false
  end
end
