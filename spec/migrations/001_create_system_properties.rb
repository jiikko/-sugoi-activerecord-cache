class CreateSystemProperties < ActiveRecord::Migration
  def change
    create_table :system_properties do |t|
      t.string :key,    null: false
      t.string :value, null: false
    end
  end
end
