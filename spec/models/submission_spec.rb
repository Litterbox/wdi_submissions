require 'spec_helper'

describe Submission do
  context 'google forms data' do
	let(:submission_fixtures) do
		GFSR.from_file(File.join(Rails.root, "spec", "fixtures", "gfsd.csv"))
	end
      let(:data)              {submission_fixtures[0] }
    let(:data_without_gh)   {submission_fixtures[9] }
    let(:data_with_comment) {submission_fixtures[19]}
  describe '.new_from_gfsd' do


  	it 'sets up a submission for saving' do
      sub = Submission.new_from_gfsd(data)
      sub.id.should == nil
      [:submitted_at, :submitter_comments, :feelings, :link].each do |field|
        sub.send(field).should == data[field]
      end
  	end

    it 'correctly sets up the new submitting student' do
      sub = Submission.new_from_gfsd(data)
      student = sub.student
      student.should_not == nil
      student.id.should == nil
  		student.gh_nickname.should == data[:gh_nickname]
    end
    it 'correctly sets up the already existing submitting student' do
      old_student = FactoryGirl.create(:student, :gh_nickname => data[:gh_nickname])
      sub = Submission.new_from_gfsd(data)

      student = sub.student
      student.should_not == nil
      student.id.should == old_student.id
  		student.gh_nickname.should == data[:gh_nickname]
    end
    it 'correctly leaves a student nil when there is no gh_nickname' do
      data_without_gh[:gh_nickname].should == nil # Just to be sure.
      sub = Submission.new_from_gfsd(data_without_gh)
      sub.student.should == nil
    end
    it 'correctly sets up the comments' do
      instructor = FactoryGirl.create(:instructor, :name => "Tim Garcia")

      sub = Submission.new_from_gfsd(data_with_comment)
      sub.comments.length.should == 1
      sub.comments.first.user.should == instructor
      sub.comments.first.id.should == nil
    end

    it 'correctly sets up the assignment when the assignment already exists' do
      assignment = Assignment.create!(:name => data[:assignment])
      sub = Submission.new_from_gfsd(data)
      sub.assignment.should == assignment
    end

    it 'correctly sets up the assignment when the assignment does not already exist' do
      sub = Submission.new_from_gfsd(data)
      sub.assignment.should_not == nil
      sub.assignment.id.should == nil
    end
  end

  describe '.find_or_create_from_gfsd' do
    it 'retrieves a persisted submission if it exists' do 
      sub = Submission.new_from_gfsd(data)
      sub.save!

      found_sub = Submission.find_or_create_from_gfsd(data)
      found_sub.should == sub
    end

    it 'builds and saves a submission if it does not exist' do
      new_sub = double
      Submission.should_receive(:new_from_gfsd).and_return(new_sub)
      new_sub.should_receive(:save!)

      sub = Submission.find_or_create_from_gfsd(data)
    end
  end
end
end
