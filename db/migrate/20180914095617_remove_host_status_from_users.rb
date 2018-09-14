class RemoveHostStatusFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :host_status, :string
  end
end
