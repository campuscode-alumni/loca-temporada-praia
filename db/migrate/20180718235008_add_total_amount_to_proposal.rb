class AddTotalAmountToProposal < ActiveRecord::Migration[5.2]
  def change
    add_column :proposals, :total_amount, :decimal
  end
end
