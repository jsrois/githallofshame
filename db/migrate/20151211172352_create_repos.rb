class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.decimal :size
      t.boolean :has_readme_file

      t.timestamps null: false
    end
  end
end
