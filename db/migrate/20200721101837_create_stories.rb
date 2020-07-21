class CreateStories < ActiveRecord::Migration[6.0]

  def change
    create_table :stories do |t|
      t.belongs_to :user
      t.string     :title
      t.string     :genre
      t.text       :description

      t.timestamps
    end
  end
end
