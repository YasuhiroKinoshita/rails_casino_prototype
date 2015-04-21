json.array!(@games) do |game|
  json.extract! game, :id, :title, :buy_in
  json.url game_url(game, format: :json)
end
