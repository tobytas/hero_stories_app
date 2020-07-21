class CreateComments < ActiveRecord::Migration[6.0]

  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :chapter

      t.timestamps
    end
    add_index :comments, [:user_id, :chapter_id], unique: true
  end
end
