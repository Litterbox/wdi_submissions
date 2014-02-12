class Submission < ActiveRecord::Base
  belongs_to :student
  has_many :comments, :as => :commentable
  belongs_to :assignment

  def self.new_from_gfsd(sub_data)
    submission_fields = [:submitted_at, :submitter_comments, :feelings, :link]
    new(sub_data.slice(*submission_fields)).tap do |sub|
      sub.student = Student.find_or_initialize_by(:gh_nickname => sub_data[:gh_nickname]) if sub_data[:gh_nickname]
      
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
end
