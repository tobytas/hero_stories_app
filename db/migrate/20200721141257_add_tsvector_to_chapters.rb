class AddTsvectorToChapters < ActiveRecord::Migration[6.0]

  def up
    add_column :chapters, :tsv, :tsvector
    add_index :chapters, :tsv, using: 'gin'

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON chapters FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(tsv, 'pg_catalog.english', description);
    SQL

    now = Time.current.to_s(:db)
    update("UPDATE chapters SET updated_at = '#{now}'")
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON chapters
    SQL

    remove_index :chapters, :tsv
    remove_column :chapters, :tsv
  end
end
