class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.boolean :group

      t.timestamps
    end
  end
end
