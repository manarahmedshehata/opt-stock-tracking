class CreatePortofliosAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :portoflios_assets do |t|
      t.references :portfolio, foreign_key: true
      t.references :asset, foreign_key: true
      t.integer :amount
    end
  end
end
