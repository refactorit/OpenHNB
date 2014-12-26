class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :currency, index: true
      t.integer :unit
      t.float :buy
      t.float :mean
      t.float :sell
      t.date :date

      t.timestamps null: false
    end
    add_foreign_key :rates, :currencies
  end
end
