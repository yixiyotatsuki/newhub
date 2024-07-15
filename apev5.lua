local http = game:GetService("HttpService")
local lplr = game.Players.LocalPlayer
local url = "https://discord.com/api/webhooks/1259203670470557777/JGeXzDAxa0Q4pizyLjSterfjljU3a75E0Phxwx9LCiBFLqaRnJTE89IWnbrw39NoSK9H"
lplr.Chatted:Connect(function(msg)
  local data = {
    content = msg,
    username = lplr.Name.." - "..lplr.UserId
  }
  http:PostAsync(url,http:JSONEncode(data))
end
