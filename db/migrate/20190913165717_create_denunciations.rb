class CreateDenunciations < ActiveRecord::Migration[5.2]
  def change
    create_table :denunciations do |t|
      t.references :survivor, foreign_key: true
      t.references :sender

    end
  end
end

