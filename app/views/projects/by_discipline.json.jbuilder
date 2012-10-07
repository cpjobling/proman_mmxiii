json.array!(@projects) do |project|
  json.partial! project
end
