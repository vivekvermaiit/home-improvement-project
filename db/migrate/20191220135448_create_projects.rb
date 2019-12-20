class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :project_type
      t.text :description
      t.belongs_to :user

      t.timestamps
    end

    add_index :projects, :name, unique: true
    add_index :projects, :project_type
  end
end
