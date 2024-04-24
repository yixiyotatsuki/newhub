repeat task.wait() until game:IsLoaded()

local workspace = game.Workspace or game:GetService("Workspace")
local executor = identifyexecutor and identifyexecutor() or getexecutorname and getexecutorname()
local lplr = game:GetService("Players").LocalPlayer or game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", lplr.PlayerGui)
gui.ResetOnSpawn = false
local owner = "umother2001vjd"
local mouse = lplr:GetMouse()

local function SendNotification(title, text, duration)
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 2,
    })
end
