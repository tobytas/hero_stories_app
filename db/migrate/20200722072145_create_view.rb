class CreateView < ActiveRecord::Migration[6.0]

  def up
    execute <<-SQL
      CREATE VIEW searches AS

        SELECT
          stories.id AS searchable_id,
          'Story' AS searchable_type,
          stories.title AS term
        FROM stories

        UNION

        SELECT
          stories.id AS searchable_id,
          'Story' AS searchable_type,
          stories.description AS term
        FROM stories

        UNION
        
        SELECT
          chapters.id AS searchable_id,
          'Chapter' AS searchable_type,
          chapters.content AS term
        FROM chapters

        UNION

        SELECT
          chapters.id AS searchable_id,
          'Chapter' AS searchable_type,
          comments.body AS term
        FROM chapters
        JOIN comments ON chapters.id = comments.chapter_id;

      CREATE INDEX index_stories_on_title        ON stories  USING gin(to_tsvector('english', title));
      CREATE INDEX index_stories_on_description  ON stories  USING gin(to_tsvector('english', description));
      CREATE INDEX index_chapters_on_content     ON chapters USING gin(to_tsvector('english', content));
      CREATE INDEX index_comments_on_body        ON comments USING gin(to_tsvector('english', body));
    SQL
  end

  def down

  end
end
