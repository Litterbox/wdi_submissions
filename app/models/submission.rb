class Submission < ActiveRecord::Base
  belongs_to :student 
  has_many :comments, :as => :commentable
  belongs_to :assignment

  def self.new_from_gfsd(sub_data)
    submission_fields = [:submitted_at, :submitter_comments, :feelings, :link]
    new(sub_data.slice(*submission_fields)).tap do |sub|
      sub.student = Student.find_or_initialize_by(:gh_nickname => sub_data[:gh_nickname]) if sub_data[:gh_nickname]
      
      sub.student.squad_leader = Instructor.find_by(:first_name => sub_data[:squad_leader]) if sub_data[:squad_leader]
      
      sub_data[:instructor_comments].each do |commenter_name, comment|
      	if comment
      		instructor = Instructor.where(:first_name => commenter_name).first
      		sub.comments.build(:user => instructor,
      								:text => comment)
      	end
      end

      sub.assignment = Assignment.find_or_initialize_by(:name => sub_data[:assignment])
    end
  end

  def self.find_or_create_from_gfsd(sub_data)
  	submission = Submission.joins(:student, :assignment).where(
      :users => {:gh_nickname => sub_data[:gh_nickname]},
      :assignments => {:name => sub_data[:assignment]},
      :submitted_at => sub_data[:submitted_at]
    ).first
    unless submission
      submission = new_from_gfsd(sub_data)
      submission.save!
    end
    submission
  end
end
