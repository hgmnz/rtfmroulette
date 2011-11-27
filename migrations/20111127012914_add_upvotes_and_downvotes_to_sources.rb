Sequel.migration do
  up do
    alter_table :sources do
      add_column :upvotes, Integer, null: false, default: 0
      add_column :downvotes, Integer, null: false, default: 0
    end
  end

  down do
    alter_table :sources do
      remove_column :upvotes
      remove_column :downvotes
    end
  end
end
