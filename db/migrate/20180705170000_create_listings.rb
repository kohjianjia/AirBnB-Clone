class CreateListings < ActiveRecord::Migration[5.2]
  
  def change
    create_table :listings do |t| 

      t.string :title
      t.string :city
      t.string :address
      t.string :summary
      t.string :description
      t.string :home_type
      t.string :room_type
      t.text :amenity, array: true, default: []
      t.integer :guest_number
      t.integer :pricing

      t.belongs_to :user

      t.timestamps
    end
  end

end