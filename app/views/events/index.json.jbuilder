json.array!(@events) do |event|
  json.extract! event, :id
  json.title event.title+"\n"+event.description
  json.start event.start_time
  json.end event.end_time
end