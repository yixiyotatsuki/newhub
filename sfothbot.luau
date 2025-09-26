-- i made this a github page because delta is so fucking annoying
-- no ui lib this time

local funclib=loadstring(game:HttpGet("https://raw.githubusercontent.com/yixiyotatsuki/stuff/main/funclib.lua"))()
local Players=game:GetService("Players")
local Owner=Players:FindFirstChild("Jacobthecool292")
local TextChatService=game:GetService("TextChatService")
local RunService=game:GetService("RunService")
local HB=RunService.Heartbeat
local Player=Players.LocalPlayer
local Character:Model=Player.Character
local HumanoidRootPart:BasePart=Character:WaitForChild("HumanoidRootPart",9e9)
Player.CharacterAdded:Connect(function(character)
    Character=character
    HumanoidRootPart=Character:WaitForChild("HumanoidRootPart",9e9)
end)
local funcs={}
Players.PlayerRemoving:Connect(function(player)
    if player==Owner then game:Shutdown() end
end)
function funcs:GetSword() -- this is quite literally just a function from funclib but i replaced it with waitforchild
    local object=Player:WaitForChild("Backpack"):WaitForChild("Sword",.01)
    if object==nil and Player.Character~=nil then object=game:GetService("Players").LocalPlayer.Character:WaitForChild("Sword",.01) end
    return object
end
local looplist={}
HB:Connect(function(deltaTime)
    Character:TranslateBy(Vector3.new(0,1e6,0)-Character:GetPivot().Position)
    local sword=funcs:GetSword()
    Character:WaitForChild("Humanoid"):EquipTool(sword)
    sword:Activate()
    for i,v in pairs(looplist) do
        v.Character:BreakJoints()
        if v.Character:WaitForChild("Sword",deltaTime) then v.Character:WaitForChild("Sword",deltaTime):Destroy() end
        for i,v in pairs(v.Character:GetChildren()) do
            if v:IsA("BasePart") then
                v.CFrame=CFrame.new(sword.Handle.Position,v.Position+Vector3.new(math.random(-1,1)*5,math.random(-1,1)*5,math.random(-1,1)*5))
            end
        end
    end
end)

TextChatService.OnIncomingMessage=function(msg:TextChatMessage)
    if msg.TextSource then
        if msg.TextChannel.Name=="RBXWhisper" and msg.TextSource.UserId==Owner.UserId then
            local msg=msg.Text
            local args=msg:sub(2,#msg):split(" ")
            local cmd=args[1]
            table.remove(args,1)
            if msg:sub(1,1)==";" then
                if cmd=="kill" then
                    local delta=task.wait()
                    local v=funclib:GetPlayer(args[1],false)
                    task.spawn(function()
                        v.Character:BreakJoints()
                        while v.Character:WaitForChild("Humanoid").Health>1 do
                            if v.Character:waitforchild("Sword",delta) then v.Character:WaitForChild("Sword",delta):Destroy() end
                            for _,v in pairs(v.Character:GetChildren()) do
                                if v:IsA("BasePart") then
                                    v.CFrame=CFrame.new(funcs:GetSword().Handle.Position,v.Position+Vector3.new(math.random(-1,1)*5,math.random(-1,1)*5,math.random(-1,1)*5))
                                end
                            end 
                        end
                    end)
                elseif cmd=="loop" then
                    table.insert(looplist,Players:FindFirstChild(args[1]))
                end
            end
        end
    end
end
