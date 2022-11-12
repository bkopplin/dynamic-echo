class Endpoint < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoints do |t|
      t.string :endpoint_type
      t.string :verb
      t.string :path
      t.integer :res_code
      t.text :res_headers
      t.text :res_body
    
      t.timestamps
    end
    
  end
end
