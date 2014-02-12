class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.timestamps

      # Omniauth pks
      t.string :uid, :null => false
      t.string :provider, :null => false
      
      # Instructor or Student
      t.string :type, :null => false

      # Attributes for both
      t.string :name
      t.string :gh_nickname, :null => false, :unique => :true
      t.string :avatar_url
      
      # Student attributes
      t.integer :squad_leader_id

      # Instructor attributes
      t.string :first_name # This is for finding the right instructor for a comment from the google forms data
    end
    add_index :users, [:provider, :uid], :unique => true
    add_index :users, :gh_nickname, :unique => true
  end
end
