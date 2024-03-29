class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(res)
    stored_location_for(res) ||
      if res.is_a? Instructor
        submissions_path
      else
        student_path(res)
      end
  end
end
