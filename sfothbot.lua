-- me when motivation

local funclib=loadstring(game:HttpGet("https://raw.githubusercontent.com/yixiyotatsuki/stuff/main/funclib.lua"))()
local Players=game:GetService("Players")
local TextChatService=game:GetService("TextChatService")
local RunService=game:GetService("RunService")
local Player=Players.LocalPlayer
local Character:Model=Player.Character
local Humanoid:Humanoid=Character:WaitForChild("Humanoid")
Player.CharacterAdded:Connect(function(character)
    Character=character
    Humanoid=Character:WaitForChild("Humanoid")
    pcall(function() -- i pcalled this because i dont know if you can actually set this yet
        Humanoid.RootPart=Character:WaitForChild("HumanoidRootPart")
    end)
end)
workspace.FallenPartsDestroyHeight=0/0

local funcs={}
local whitelist={ -- for anticheat
    "Jacobthecool292", -- myself ofc!!
    "Kandale_Dingul", -- alt
    "HollowGol", -- no coding skid, but we're still friends after all
    "STEVETheReal916", -- i get hard whenever this guy is here
    "HallowGol", -- this guy is gay
    "ColonThreeSpam", -- this guy is only 3 months old + Stella alt
    Player.Name
}
local proloop={} -- loop people ion like
local settings={ -- temporary shit
    fling=nil,
    killing={},
    temp_whitelist={},
    temp_loop={},
    hitlogs={}, -- i will lag the shit from this one function
    fun={
        instakill_sword=false
    }
}
function funcs.anticheat(tag:ObjectValue) -- this is for the kill logs, i made it a . function so it wont autocorrect because this isnt that important
    local victim,creator=tag.Parent.Parent,Players:WaitForChild(tag.Value.Name,5)
    local data={
        victim=victim,
        creator=creator,
        distance=(victim:WaitForChild("Humanoid").RootPart.Position-creator:WaitForChild("Humanoid").RootPart.Position).Magnitude
    }
    if not (table.find(whitelist,creator.Name) or table.find(settings.temp_whitelist,creator.Name)) then
        if data.distance<25 and data.distance>10 then
            table.insert(settings.killing,creator)
        elseif data.distance<25 then
            table.insert(settings.temp_loop,creator)
        end
    end
    table.insert(settings.hitlogs,data)
end

task.spawn(function() -- this is the kill logs shit the anticheat is in the fixed heartbeat
    local players={}
    local function check(player:Player)
        if not players[player.Name] then
            players[player.Name]=player.CharacterAdded:Connect(function(char)
                char:WaitForChild("Humanoid").ChildAdded:Connect(function(child)
                    if string.match(child.Name,"creator") then -- i dont know the tags actual name im pretty sure its just creator but i could be wrong idfk
                        funcs.anticheat(child)
                    end
                end)
            end)
        end
    end
end)

function funcs:GetSword() -- this is quite literally just a function from funclib but i replaced it with waitforchild
    local object=Player:WaitForChild("Backpack"):WaitForChild("Sword",.01)
    if object==nil and Player.Character~=nil then object=game:GetService("Players").LocalPlayer.Character:WaitForChild("Sword",.01) end
    return object
end

function funcs:SetPosition(pos:Vector3) -- it doesnt set rotation
    Character:TranslateBy(pos-Humanoid.RootPart.Position)
end

function funcs:Hit(part,number)
    local sword=funcs:GetSword()
    if sword then
        if sword:IsDescendantOf(Character) then
            firetouchinterest(sword,part,number)
        elseif sword.Parent==Player:WaitForChild("Backpack") then
            Humanoid:EquipTool(sword)
            firetouchinterest(sword,part,number)
        end
    end
end


RunService.FixedHeartbeat:Connect(function(dt)
    if settings.fling==nil then
        funcs:SetPosition(Vector3.new(0,-100000,0))
        for i,v in pairs(settings.killing) do
            for i,v in pairs(v.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    funcs:Hit(v,0)
                end
            end
            if v.Character:WaitForChild("Humanoid").Health==0 then table.remove(settings.killing,i) end
        end        for i,v in pairs(settings.temp_loop) do
            local player
        end
        for i,v in pairs(Players:GetPlayers()) do
            if table.find(whitelist,v.Name) then
                if settings.fun.instakill_sword then
                    for i,v in pairs(settings.hitlogs) do
                        if table.find(settings.temp_whitelist,v.creator) then
                            table.insert(settings.killing,Players:WaitForChild(v.victim.Name))
                        end
                    end
                end
            end
        end
        Humanoid.RootPart.Velocity=Vector3.zero
    elseif settings.fling~=nil then
        local hum=settings.fling.Character:WaitForChild("Humanoid")
        local hrp=hum.RootPart
        if hrp.Velocity.Magnitude<500 then
            local movementprediction=hrp.Velocity/(1.5+funclib:GetPing())
            local pos=hrp.Position+movementprediction
            Humanoid.RootPart.Velocity=Vector3.new(0,-10000,0)
            Humanoid.RootPart.RotVelocity=Vector3.new(0,1000,0)
            funcs:SetPosition(pos)
        else
            settings.fling=nil
        end
    end
end)
-- finaly commands!!!

TextChatService.MessageReceived:Connect(function(msg)
    if table.find(whitelist,Players:GetNameFromUserIdAsync(msg.TextSource.UserId)) then
        if msg.Text:sub(1,3)=="r34." then
            local args=msg.Text:sub(4):split(" ")
            local cmd=args[1]
            table.remove(args,1)

            if cmd=="fling" then
                local player=funclib:GetPlayer(args[1])
                if player then
                    settings.fling=player
                end
            elseif cmd=="kill" then
                local player=funclib:GetPlayer(args[1])
                if player then
                    table.insert(settings.killing,player)
                end
            elseif cmd=="loopkill" then
                local player=funclib:GetPlayer(args[1])
                if player then
                    table.insert(settings.temp_loop,player.Name)
                end
            elseif cmd=="unloopkill" then
                local player=funclib:GetPlayer(args[1])
                if player then
                    for i,v in ipairs(settings.temp_loop) do if v.Name==player.Name then table.remove(settings.temp_loop,i) end end
                end
            elseif cmd=="update" then
                queue_on_teleport(loadstring(game:HttpGet("https://raw.githubusercontent.com/yixiyotatsuki/newhub/heads/main/sfothbot.lua"))())
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,Player)
            elseif cmd=="fake_darkheart" then
                local player=funclib:GetPlayer(args[1])
                settings.fun.instakill_sword=not settings.fun.instakill_sword
            elseif cmd=="whitelist" then
                table.insert(settings.temp_whitelist,player.Name)
            end
        end
    end
end)

print("script made by tatsuki (@.zamnsuki)!!! still lazy but atleast its better than before")

--[[
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
	flinging=true
	repeat
		local RetardPrediction=hrp.Velocity/(1.25+funclib:GetPing())
		cframe_but_its_not_cframe(hrp.Position+RetardPrediction)
		HumanoidRootPart.Velocity=Vector3.new(0,-100000,0)
        HumanoidRootPart.RotVelocity=Vector3.new(0,1000,0)
		time+=task.wait()
	until not hrp:IsDescendantOf(game) or time>5
	flinging=false
end
local looplist={"Guys_imtulimullinew","D_eadkreek","Yuri_Watanabe"}--(ChancedGRIM, reason: annoying), (also chancedgrim), also chancedgrim
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


loadstring(game:HttpGet("https://raw.githubusercontent.com/yixiyotatsuki/newhub/heads/main/sfothbot.lua"))()
]]
