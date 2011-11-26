Sequel.migration do
  up do
    create_table :sources do
      primary_key :id
      Integer :root_id, null: false
      String :url, null: false
      String :content, null: false
      DateTime :created_at
      DateTime :updated_at
    end

    add_index :sources, :root_id
  end

  down do
    drop_table :sources
  end

end
