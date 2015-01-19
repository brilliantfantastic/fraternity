Sequel.migration do
  change do
    create_table :pledges do
      primary_key :id
      String      :token
      String      :email
      String      :first_name
      String      :last_name
      Integer     :initiation_number
      DateTime    :invited_at
      DateTime    :accepted_at
    end
  end
end
