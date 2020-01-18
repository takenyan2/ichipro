class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :menu_title
      t.string :image
      t.text :introduce

      t.timestamps
    end
  end
end
