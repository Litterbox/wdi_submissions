class Instructor < User
	before_save :set_first_name
	
	def set_first_name
	  self.first_name = name.split[0].downcase
	end
end
