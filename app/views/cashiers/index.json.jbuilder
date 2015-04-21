json.array!(@cashiers) do |cashier|
  json.extract! cashier, :id, :organization_id, :user_id, :money
  json.url cashier_url(cashier, format: :json)
end
