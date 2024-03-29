# coding: utf-8
class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  # 未ログインリダイレクト
  before_filter :authorize

  # httpsリダイレクト
  before_filter :ssl_redirect unless Rails.env.development?
  
  # セッション有効期限延長
  before_filter :reset_session_expires

  private

  #-----------#
  # authorize #
  #-----------#
  # ログイン認証
  def authorize
    # セッション、トップコントローラ以外で
    if params[:controller] != "sessions" and params[:controller] != "top"
      # 未ログインであればルートヘリダイレクト
      if session[:user_id].blank?
        redirect_to :root and return
      end
    end
    
    # トップコントローラで
    if params[:controller] == "top"
      # ログイン済みであればtaskへリダイレクト
      unless session[:user_id].blank?
        redirect_to :controller => "tasks" and return
      end
    end
  end

  #--------------#
  # ssl_redirect #
  #--------------#
  def ssl_redirect
    unless request.env["HTTP_X_FORWARDED_PROTO"].to_s == "https"
      # httpsへリダイレクト
      request.env["HTTP_X_FORWARDED_PROTO"] = "https"
      redirect_to request.url and return
    end
  end
  
  #-----------------------#
  # reset_session_expires #
  #-----------------------#
  # セッション期限延長
  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end

  #--------------#
  # current_user #
  #--------------#
  def current_user
    @current_user ||= User.where( :id => session[:user_id] ).first
  end
  
  helper_method :current_user

end
