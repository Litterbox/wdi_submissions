class Submission < ActiveRecord::Base
  belongs_to :student
  def self.new_from_gfsd(sub_data)
    puts sub_data.inspect
    submission_fields = [:submitted_at, :submitter_comments, :feelings, :link]
    new(sub_data.slice(*submission_fields)).tap do |sub|
      sub.student = Student.find_or_initialize_by_gh_nickname(sub_data[:gh_nickname]) if sub_data[:gh_nickname]
    end
  end
end
