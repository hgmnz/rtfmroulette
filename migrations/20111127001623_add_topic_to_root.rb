Sequel.migration do
  up do
    alter_table :roots do
      add_column :topic, String
    end
  end

  down do
    alter_table :roots do
      remote_column :topic
    end
  end
end
