require 'spec_helper'

describe Submission do
	let(:submission_fixtures) do
		GFSR.from_file(File.join(Rails.root, "spec", "fixtures", "gfsd.csv"))
	end
  describe '.new_from_gfsd' do
    before do
  		@data = submission_fixtures[0]
    end

  	it 'sets up a submission for saving' do
      sub = Submission.new_from_gfsd(@data)
      sub.id.should == nil
      [:submitted_at, :submitter_comments, :feelings, :link].each do |field|
        sub.send(field).should == @data[field]
      end
  	end

    it 'correctly sets up the new submitting student' do
      sub = Submission.new_from_gfsd(@data)
      student = sub.student
      student.should_not == nil
      student.id.should == nil
  		student.gh_nickname.should == @data[:gh_nickname]
    end
    it 'correctly sets up the already existing submitting student' do
      old_student = FactoryGirl.create(:student, :gh_nickname => @data[:gh_nickname])
      sub = Submission.new_from_gfsd(@data)

      student = sub.student
      student.should_not == nil
      student.id.should == old_student.id
  		student.gh_nickname.should == @data[:gh_nickname]
    end
    it 'correctly leaves a student nil when there is no gh_nickname' do 
      @data = submission_fixtures[9]
      @data[:gh_nickname].should == nil # Just to be sure.
      sub = Submission.new_from_gfsd(@data)
      sub.student.should == nil
    end
    it 'correctly sets up the comments'
    it 'correctly sets up the assignment when the assignment already exists'
    it 'correctly sets up the assignment when the assignment does not already exist'
  end
end
