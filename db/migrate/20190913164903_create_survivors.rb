class CreateSurvivors < ActiveRecord::Migration[6.0]
  def change
    create_table :survivors do |t|
      t.string :description
      t.string :age
      t.string :sex
      t.string :latitude
      t.string :longitude
      t.boolean :abducted, default:false

    end
  end
end
