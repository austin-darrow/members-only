class RemoveReferenceFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_reference :users, :posts, type: :integer, foreign_key: true
  end
end
