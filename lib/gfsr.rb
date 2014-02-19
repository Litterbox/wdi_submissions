require 'csv'
# Google Forms Submissions Reader
module GFSR
	#HEADER_KEYS = ["ncer", "Name", "Assignment", "Comments",
	#               "Feelings", "Link to Submission", "Name",
	#               "Squad Leader",
	#               "Delmer's Comments", "Tripta's Comments",
	#               "Spencer's Comments", "Markus's Comments",
	#               "Alex's Comments", "Tim's Comments"]
	DATE_FORMAT = "%m/%d/%Y %H:%M:%S"
	SQUAD_LEADER_ADDITION_DATE = DateTime.strptime("1/27/2014 12:36:04", DATE_FORMAT )
	
	def self.from_file filename
		data = File.open filename do |f|
			CSV.parse(f)
		end
		from_array(data)
	end

	def self.parse_date d
		DateTime.strptime(d, DATE_FORMAT )
	end

	def self.get_name l
		name1 = l[1]
		name2 = l[6]

		unless name1.blank? && name2.blank?
			if name1.blank? || name1 == name2
				return name2
			elsif name2.blank?
				return name1
			else
				raise ArgumentError.new("Names in line #{l.inspect} do not match")
			end
		else
			return ""
		end
	end

	def self.normalize_line l
		result = {}
		result[:submitted_at] = parse_date(l[0])
		result[:name] = get_name(l)
		result[:assignment] = l[2]
		result[:submitter_comments] = l[3]
		result[:feelings] = l[4]
		result[:link] = l[5]

		if match = /github.com\/(.+)\/(.+)/.match(result[:link])
			result[:gh_nickname] = match[1]
		end
		
		result[:instructor_comments] = {}

		if parse_date(l[0]) >= SQUAD_LEADER_ADDITION_DATE
			result[:squad_leader] = l[7].downcase
			result[:instructor_comments][:raphael] = nil
		else
			result[:instructor_comments][:raphael] = l[7]
		end

		instructor_names = [:delmer, :tripta, :spencer, :markus, :alex, :tim]
		instructor_names.each_with_index do |e, i|
			result[:instructor_comments][e] = l[8 + i]
		end
		
		result
	end

	def self.from_array tabular_data
		data = []
		(1...tabular_data.length).each do |i|
			data << normalize_line(tabular_data[i])
		end
		data
	end

end