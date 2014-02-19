require 'csv'
namespace :data do
	desc "Load the instructors, then the google forms data"
	task :load_all do
		Rake::Task["data:load_instructors"].invoke
		Rake::Task["data:load_gfsd"].invoke
	end

	desc "Load the data submitted to the google form."
	task :load_gfsd, [:filename] => :environment do |t,args|
		data = GFSR.from_file("data.csv")
		data.each do |sub_data|
			Submission.find_or_create_from_gfsd(sub_data)
		end
	end

	task :load_instructors, [] => :environment do
		CSV.foreach("instructors.csv", :headers => true, :header_converters => :symbol) do |l|
			boilerplate = {:provider => :github}
			Instructor.create!(l.to_hash.merge(boilerplate))
		end
	end
end
