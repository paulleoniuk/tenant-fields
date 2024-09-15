class CreateCustomFields < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_fields do |t|
      t.string :name
      t.string :field_type
      t.text :options, array: true, default: []
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
