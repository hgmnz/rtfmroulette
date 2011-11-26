Sequel.migration do
  up do
    alter_table :sources do
      add_column :title, String, null: false
    end
  end

  down do
    alter_table :sources do
      remove_column :title
    end
  end
end
