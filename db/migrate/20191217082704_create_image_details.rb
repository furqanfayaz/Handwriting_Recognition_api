class CreateImageDetails < ActiveRecord::Migration[5.0]
  def up
    create_table :image_details, id: :uuid do |t|
      t.string :url
      t.string :text

      t.timestamps
    end
  end

  def down
    drop_table :image_details
  end
end