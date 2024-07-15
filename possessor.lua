--[[
    __   __   __  _______   _____   __   ___  _______
    \ \ / /_ _\ \/ /_ _\ \ / / _ \  | | | | | | | __ ) 
     \ V / | | \  / | | \ V / | | | | |_| | | | |  _ \ 
      | |  | | /  \ | |  | || |_| | |  _  | |_| | |_) |
      |_| |___/_/\_\___| |_| \___/  |_| |_|\___/|____/ 
    YIXIYOHUB - Possessor

    made by yixiyo, accountunrecognized9764 (discord)
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local lplr = game.Players.LocalPlayer

local Window = Fluent:CreateWindow({
    Title = "YIXIYOHUB | Possessor",
    SubTitle="by x4gx",
    TabWidth=160,
    Size=UDim2.fromOffset(580,460),
    Acrylic=false,
    Theme="Dark",
    MinimizeKey=Enum.KeyCode.LeftControl
})

local tabs = {
    Main=Window:AddTab({Title="Main",Icon=""}),
    Player=Window:AddTab({Title="Player",Icon="user"}),
    Visuals=Window:AddTab({Title="Visuals",Icon="eye"}),
    Misc=Window:AddTab({Title="Miscellaneous",Icon="help-circle"}),
    Settings=Window:AddTab({Title="Settings",Icon="settings"})
}
tabs.Main:AddParagraph({
    Title="Join our discord!",
    Content="discord.gg/example"
})
function esp(io)
    if io == true then
        local highlight = Instance.new("Highlight")
        local billboard = Instance.new("BillboardGui")
        local textgui = Instance.new("TextLabel")
        for _,v in game:GetService("Players"):GetPlayers() do
            if v.Character then
                local highlightClone = highlight:Clone()
                local billboardClone = billboard:Clone()
                local textguiClone = textgui:Clone()

                highlightClone.Name="ESPYixiyoHub"
                highlightClone.Parent=v.Character
                billboardClone.Parent=highlightClone.Parent
                textguiClone.Parent=billboardClone
                billboardClone.Name="ESPYixiyoHub"
                textguiClone.Name="ESPYixiyoHub"
                textgui.BackgroundTransparency=1
                textgui.Font=Enum.Font.Gotham
                textgui.Text=v.Name
            end
        end
    end
    if io == false then
        for _,v in workspace:GetDescendants() do
            if v.Name == "ESPYixiyoHub" then
               v:Destroy()
            end
        end
    end
end
local esptoggle = tabs.Visuals:AddToggle("ESPToggle",{Title="ESP",Description="Display players without any layer problems!"})
esptoggle:OnChanged(function(Value)
    esp(Value)
end)
tabs.Misc:AddButton({
    Title="Copy Jobid&PlaceId",
    Description="Copys the servers jobid and the games placeid.",
    Callback = function()
        setclipboard("Place Id: "..game.PlaceId..", JobId: "..game.JobId)
    end
})
local lighting = game:GetService("Lighting")
function fullbright(io)
    if io == true then
        lighting.Brightness=2
        lighting.ClockTime=14
        lighting.FogEnd=100000
    end
    if io == false then
        lighting.Brightness=1
        lighting.FogEnd=500
    end
end

local fullbrighttoggle = tabs.Visuals:AddToggle("FBToggle",{Title="FullBright",Description="Lets you see better"})

fullbrighttoggle:OnChanged(function(Value)
    fullbright(Value)
end)
