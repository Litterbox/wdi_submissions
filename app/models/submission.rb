class Submission < ActiveRecord::Base
  belongs_to :student 
  has_many :comments, :as => :commentable
  belongs_to :assignment

  def self.new_from_gfsd(sub_data)
    submission_fields = [:submitted_at, :submitter_comments, :feelings, :link]
    new(sub_data.slice(*submission_fields)).tap do |sub|
      if sub_data[:gh_nickname]
        sub.student = Student.find_or_initialize_by(:gh_nickname => sub_data[:gh_nickname])
      end
      sub.student ||= Student.find_by(:name => sub_data[:name]) 
      sub.student ||= Student.find_by(:name => sub_data[:name].titleize)
      sub.student ||= Student.find_by(:name => sub_data[:name].downcase)

      if sub.student 
        if sub_data[:name]
          current_name_l = sub.student.name ? sub.student.name.length : 0
          sub.student.name = sub_data[:name] if sub_data[:name].length > current_name_l
        end
        sub.student.squad_leader = Instructor.find_by(:first_name => sub_data[:squad_leader]) if sub_data[:squad_leader]
      end
      
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
      :feelings => sub_data[:feelings],
      :assignments => {:name => sub_data[:assignment]},
      :submitted_at => sub_data[:submitted_at]
    ).first
    unless submission
      submission = new_from_gfsd(sub_data)
      submission.save!
      submission.student.save! if submission.student
    end
    submission
  end
end
