class CreateCustomFieldValues < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_field_values do |t|
      t.references :custom_field, null: false, foreign_key: true
      t.references :customizable, polymorphic: true, null: false
      t.jsonb :value, default: {}

      t.timestamps
    end

    add_index :custom_field_values, :value, using: :gin
    add_index :custom_field_values, [:customizable_type, :customizable_id]
  end
end
