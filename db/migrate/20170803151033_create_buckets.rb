class CreateBuckets < ActiveRecord::Migration[5.1]
  def change
    create_table :buckets do |t|
      t.references :aws_profile, foreign_key: true
      t.references :user, foreign_key: true
      t.string :bucket_name, null: false
      t.string :prefix
      t.boolean :bkt_upload, default: false
      t.boolean :bkt_download, default: false
      t.boolean :bkt_copy, default: false
      t.boolean :bkt_delete, default: false

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :deleted_at
    end
  end
end
