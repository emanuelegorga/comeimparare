class CreateProgressTracks < ActiveRecord::Migration[7.0]
  def up
    create_table :progress_tracks, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.references :lecture, null: false, foreign_key: true, type: :uuid, index: true
      t.references :user, null: false, foreign_key: true, type: :uuid, index: true
      t.integer :views, null: false, default: 0
    end
  end

  def down
    drop_table :progress_tracks
  end
end
