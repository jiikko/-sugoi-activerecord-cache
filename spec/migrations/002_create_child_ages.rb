class CreateChildAges < ActiveRecord::Migration
  def change
    create_table :child_ages do |t|
      t.string :name,        null: false
      t.string :description, null: false
    end
  end
end
