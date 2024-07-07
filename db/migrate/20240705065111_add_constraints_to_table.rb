class AddConstraintsToTable < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :admin, :boolean, default: false
    change_column :loans, :state, :string, default: "requested"
    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
    change_column_null :wallets, :balance, false
    change_column_null :loans, :amount, false
    change_column_null :loans, :interest_rate, false
    change_column_null :loans, :state, false
    add_reference :loans, :approved_by,  foreign_key: { to_table: :users }
    add_reference :loans, :rejected_by,  foreign_key: { to_table: :users }

  end
  
  def down
    change_column :users, :admin, :boolean, default: nil
    change_column :loans, :state, :string, default: nil
    change_column_null :users, :name, true
    change_column_null :users, :email, true
    change_column_null :users, :email, true
    change_column_null :users, :password_digest, true
    change_column_null :wallets, :balance, true
    change_column_null :loans, :amount, true
    change_column_null :loans, :interest_rate, true
    change_column_null :loans, :state, true
  end
end
