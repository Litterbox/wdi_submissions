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
      t.string :provider, :null => false
      t.string :uid, :null => false

      t.string :name
      t.string :gh_nickname, :null => false, :unique => :true
      t.string :avatar_url
      t.boolean :is_instructor, :default => false, :null => false
      t.integer :squad_leader_id
    end
    add_index :users, [:provider, :uid], :unique => true
    add_index :users, :gh_nickname
  end
end
