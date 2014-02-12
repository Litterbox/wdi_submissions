require 'csv'
namespace :data do
	desc "Load the data submitted to the google form."
	task :load_gfsd, [:filename] => :environment do |t,args|
		data = GFSR.from_file(args)
	end

	task :seed_instructors, [] => :environment do
		CSV.foreach("instructors.csv", :headers => true, :header_converters => :symbol) do |l|
			boilerplate = {:provider => :github}
			Instructor.create!(l.to_hash.merge(boilerplate))
		end
	end
end
