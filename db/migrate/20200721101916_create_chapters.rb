class CreateChapters < ActiveRecord::Migration[6.0]

  def change
    create_table :chapters do |t|
      t.belongs_to :story
      t.integer    :number
      t.text       :content

      t.timestamps
    end
  end
end
