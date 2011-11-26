Sequel.migration do
  up do
    create_table :roots do
      primary_key :id
      String :url, null: false
      String :crawl_scope, null: false
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table :roots
  end
end
