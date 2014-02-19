require 'spec_helper'
describe GFSR do
	before do
		@filename = File.join(Rails.root, "spec", "fixtures", "gfsd.csv")
		@raw_data = File.open(@filename) do |f|
			CSV.parse(f)
		end
	end

  describe '.normalize_line' do
  	it 'normalizes a line' do
  		raw_line = @raw_data[1]
  		result = GFSR.normalize_line(raw_line)
  		result.should include({
  			name: raw_line[1],
        submitted_at: GFSR.parse_date(raw_line[0]),
        assignment: raw_line[2],
        submitter_comments: raw_line[3],
        gh_nickname: "g3jfv697i",
        link: "https://github.com/g3jfv697i/lab_20140106"
  		})
      result[:name].should == "messenger bag"
  	end
    it 'reads a line with a non-github link' do
      result = GFSR.normalize_line(@raw_data[10])
      result[:gh_nickname].should == nil
    end

    it 'reads the gh_nickname from a gist correctly' do
      n = 7
      @raw_data[n][5].should include("gist")
      result = GFSR.normalize_line(@raw_data[n])
      result[:gh_nickname].should == "bp6yzf5wpl"
    end
    it 'reads the gh_nickname from a tree/master link' do
      n = 16
      @raw_data[n][5].should include("tree/master")
      result = GFSR.normalize_line(@raw_data[n])
      result[:gh_nickname].should == "n3h84uurt"
    end
  end
  describe '.from_file' do
    it 'pulls the results from a file' do
      res = GFSR.from_file(@filename)
      res[0].should == GFSR.normalize_line(@raw_data[1])
    end
  end
end
