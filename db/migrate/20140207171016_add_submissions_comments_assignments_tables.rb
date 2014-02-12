class AddSubmissionsCommentsAssignmentsTables < ActiveRecord::Migration
  def change
  	create_table :submissions do |t|
  		t.timestamps
  		t.integer :student_id
  		t.string :link
  		t.datetime :submitted_at
  		t.string :feelings
  		t.text :submitter_comments
  	end

  	create_table :comments do |t|
  		t.timestamps
  		t.integer :user_id
  		t.integer :commentable_id
  		t.string :commentable_type
  	end

    create_table :assignments do |t|
      t.string :name
    end
  end
end
