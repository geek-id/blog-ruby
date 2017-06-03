json.array! (@postattach) do |attach|
  json.id attach.id
  json.thumb attach.attach_url(:thumb)
  json.url attach.attach_url
end
