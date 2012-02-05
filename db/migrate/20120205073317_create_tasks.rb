class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :span
      t.integer :priority
      t.timestamp :added_at
      t.timestamp :completed_at

      t.timestamps
    end
  end
end
