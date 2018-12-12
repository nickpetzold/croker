class AddStateToTopUps < ActiveRecord::Migration[5.2]
  def change
    add_column :top_ups, :state, :string
  end
end
