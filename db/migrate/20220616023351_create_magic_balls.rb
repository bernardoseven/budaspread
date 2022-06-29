class CreateMagicBalls < ActiveRecord::Migration[7.0]
  def change
    create_table :magic_balls do |t|
      t.string :name

      t.timestamps
    end
  end
end
