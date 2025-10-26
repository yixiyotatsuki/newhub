-- no ui lib this time

local funclib=loadstring(game:HttpGet("https://raw.githubusercontent.com/yixiyotatsuki/stuff/main/funclib.lua"))()
local Players=game:GetService("Players")
local Owner=Players:FindFirstChild("Kandale_Dingul")
local TextChatService=game:GetService("TextChatService")
local RunService=game:GetService("RunService")
local HB=RunService.Heartbeat
local Player=Players.LocalPlayer
local Character:Model=Player.Character
local HumanoidRootPart:BasePart=Character:WaitForChild("HumanoidRootPart",9e9)
Player.CharacterAdded:Connect(function(character)
    workspace.FallenPartsDestroyHeight=0/0
    Character=character
    HumanoidRootPart=Character:WaitForChild("HumanoidRootPart",9e9)
end)
workspace.FallenPartsDestroyHeight=0/0
if Owner==nil then return print("GANG OWNER DOESNT  EXIST ARE YOU FUCKING RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD") end
local funcs={}
function funcs:GetSword() -- this is quite literally just a function from funclib but i replaced it with waitforchild
    local object=Player:WaitForChild("Backpack"):WaitForChild("Sword",.01)
    if object==nil and Player.Character~=nil then object=game:GetService("Players").LocalPlayer.Character:WaitForChild("Sword",.01) end
    return object
end
	function cframe_but_its_not_cframe(PositionOfCourse:Vector3)
		Character:TranslateBy(PositionOfCourse-HumanoidRootPart.Position)
	end
local flinging=false
function fling(VeryCoolVariableName)
	local layer_iaccidentallymispelledplayerbutidontcare=VeryCoolVariableName
	local hrp,iusuallydontneedavariableforthisbutitsok=layer_iaccidentallymispelledplayerbutidontcare:FindFirstChild("HumanoidRootPart"),layer_iaccidentallymispelledplayerbutidontcare:FindFirstChild("Humanoid")
	if not hrp or not iusuallydontneedavariableforthisbutitsok then return end
	-- from now good variable names.. i think
	local InitCFrame=HumanoidRootPart.CFrame
	local time=0
	local RetardPrediction=iusuallydontneedavariableforthisbutitsok.MoveDirection*(hrp.Velocity.Magnitude/1.25)
	flinging=true
	repeat
		cframe_but_its_not_cframe(hrp.Position+RetardPrediction+Vector3.new(0,0,0))
		HumanoidRootPart.Velocity=Vector3.new(0,-100000,0)
        HumanoidRootPart.RotVelocity=Vector3.new(0,1000,0)
		time+=task.wait()
	until not hrp:IsDescendantOf(game) or time>5
	flinging=false
end
local looplist={"Guys_imtulimullinew","D_eadkreek"}--(ChancedGRIM, reason: annoying), (also chancedgrim)
HB:Connect(function(deltaTime)
    if not flinging then cframe_but_its_not_cframe(Vector3.new(0,-10000,0)) end
    if not flinging then HumanoidRootPart.Velocity=Vector3.zero end
    local sword=funcs:GetSword()
    sword.Handle.Size=Vector3.new(20,20,20)
    sword.Handle.Massless=true
    if flinging then sword.Parent=Player.Backpack else Character:WaitForChild("Humanoid"):EquipTool(sword) end
    for i,v in pairs(looplist) do
        local player=Players:FindFirstChild(v)
        if not player or not player.Character then continue end 
        if player.Character:WaitForChild("Sword",deltaTime) then player.Character:WaitForChild("Sword",deltaTime):Destroy() end
        player.Character:PivotTo(CFrame.new(sword.Handle.Position,player.Character:GetPivot().Position+(Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))*5)))
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
                            v.Character:PivotTo(CFrame.new(funcs:GetSword().Handle.Position,v.Character:GetPivot().Position+(Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))*5)))
                        end
                    end)
                elseif cmd=="loop" then
                    table.insert(looplist,args[1])
                elseif cmd=="unloop" then
                    local index=0
                    for i,v in ipairs(looplist) do if v.Name==args[1] then index=i break end end
                    table.remove(looplist,index)
                elseif cmd=="fling" then
                    local v=funclib:GetPlayer(args[1],false)
                    fling(v.Character)
				elseif cmd=="fakeflinging" then
					flinging=not flinging
                end
            end
        end
    end
end

--[[


loadstring(game:HttpGet("https://raw.githubusercontent.com/yixiyotatsuki/newhub/heads/main/sfothbot.lua"))()
]]
