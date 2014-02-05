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
      t.string :provider
      t.string :uid

      t.string :name
      t.string :gh_nickname
      t.string :avatar_url
    end
    add_index :users, [:provider, :uid]
  end
end
