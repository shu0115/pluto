class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.string :span
      t.integer :priority, :default => 0
      t.boolean :complete_flag, :default => false
      t.timestamp :added_at
      t.timestamp :completed_at

      t.timestamps
    end
  end
end
