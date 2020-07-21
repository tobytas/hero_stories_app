class AddTsvectorToChapters < ActiveRecord::Migration[6.0]

  # https://postgrespro.ru/docs/postgrespro/9.5/textsearch-tables#textsearch-tables-search
  # https://thoughtbot.com/blog/optimizing-full-text-search-with-postgres-tsvector-columns-and-triggers
  # https://postgrespro.ru/docs/postgrespro/9.5/textsearch-features#textsearch-update-triggers
  def up
    add_column :chapters, :tsv, :tsvector
    add_index :chapters, :tsv, using: 'gin'

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON chapters FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        tsv, 'pg_catalog.english', content
      );
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
