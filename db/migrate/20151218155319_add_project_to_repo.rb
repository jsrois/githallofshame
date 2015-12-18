class AddProjectToRepo < ActiveRecord::Migration
  def change
    add_column :repos, :project, :string
  end
end
