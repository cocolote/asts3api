class CreateAwsProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :aws_profiles do |t|
      t.string :name, null: false
      t.string :access_key, null: false
      t.string :secret_access_key, null: false

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :deleted_at
    end
  end
end
