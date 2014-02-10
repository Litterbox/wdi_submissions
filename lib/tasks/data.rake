namespace :data do
	desc "Load the data submitted to the google form."
	task :load_gfsd, [:filename] => :environment do |t,args|
		data = GFSR.from_file(args)
	end
end
