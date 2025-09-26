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
function funcs:GetSword() -- this is quite literally just a function from funclib but i replaced it with waitforchild
    local object=Player:WaitForChild("Backpack"):WaitForChild("Sword",.01)
    if object==nil and Player.Character~=nil then object=game:GetService("Players").LocalPlayer.Character:WaitForChild("Sword",.01) end
    return object
end
local looplist={}
HB:Connect(function(deltaTime)
    Character:TranslateBy(Vector3.new(0,1e6,0)-Character:GetPivot().Position)
    HumanoidRootPart.Velocity=Vector3.zero
    local sword=funcs:GetSword()
    sword.Handle.Size=Vector3.new(20,20,20)
    Character:WaitForChild("Humanoid"):EquipTool(sword)
    sword:Activate()
    for i,v in pairs(looplist) do
        if not v.Character then continue end 
        if v.Character:WaitForChild("Sword",deltaTime) then v.Character:WaitForChild("Sword",deltaTime):Destroy() end
        v.Character:PivotTo(CFrame.new(sword.Handle.Position,v.Character:GetPivot().Position+(Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))*5)))
    end
end)

TextChatService.OnIncomingMessage=function(msg:TextChatMessage)
    if msg.TextSource then
        if string.match(msg.TextChannel.Name,"RBXWhisper") and msg.TextSource.UserId==Owner.UserId then
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
                            if v.Character:WaitForChild("Sword",delta) then v.Character:WaitForChild("Sword",delta):Destroy() end
                            v.Character:PivotTo(CFrame.new(funcs:GetSword().Handle.Position,v.Position+(Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))*5)))
                        end
                    end)
                elseif cmd=="loop" then
                    table.insert(looplist,Players:FindFirstChild(args[1]))
                elseif cmd=="unloop" then
                    local index=0
                    for i,v in ipairs(looplist) do if v.Name==args[1] then index=i break end end
                    table.remove(looplist,index)
                end
            end
        end
    end
end
