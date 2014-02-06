module Instructors
	class BaseController < ApplicationController
		before_filter do
			redirect_to root_path unless user_signed_in?
		end
		
		before_filter do
			redirect_to student_path(current_user) unless current_user.is_instructor?
		end
	end
end