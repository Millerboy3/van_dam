class ApplicationController < ActionController::Base
  before_action :auto_login_single_user
  before_action :authenticate_user!
  before_action :check_scan_status
  before_action :remember_ordering

  def auto_login_single_user
    # If there is a single user with no password set,
    # then log in automatically as that user.
    if User.count == 1 && User.first.encrypted_password == ""
      sign_in(:user, User.first)
    end
  end

  def authenticate_admin_user!
    authenticate_user!
    render plain: "401 Unauthorized", status: :unauthorized unless current_user.admin?
  end

  def check_scan_status
    @scan_in_progress = Delayed::Job.count > 0
  end

  def remember_ordering
    session["order"] ||= "name"
    session["order"] = params["order"] if params["order"]
  end
end
