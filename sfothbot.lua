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
    for i,v in pairs(Players:GetPlayers()) do
        check(v)
    end
    Players.PlayerAdded:Connect(function(player)
        check(player)
    end)
end)
print("hitlog loaded")

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
    if sword:IsDescendantOf(Character) then
        if sword:IsDescendantOf(Character) then
            firetouchinterest(sword,part,number)
        elseif sword.Parent==Player:WaitForChild("Backpack") then
            Humanoid:EquipTool(sword)
            firetouchinterest(sword,part,number)
        end
    end
end


RunService.Heartbeat:Connect(function(dt) -- fixedheartbeat DIDNT WORK BECAUSE OF IDENTITY LEVELS AHAHAHAHAHAHAHA identity level is 8
    if settings.fling==nil then
        funcs:SetPosition(Vector3.new(0,-100000,0))
        for i,v in pairs(settings.killing) do
            for i,v in pairs(v.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    funcs:Hit(v,0)
                end
            end
            if v.Character:WaitForChild("Humanoid").Health==0 then table.remove(settings.killing,i) end
        end         
        for i,v in pairs(settings.temp_loop) do
            local player=Players:WaitForChild(v,dt*1.5)
            if not player then continue end
            funcs:Hit(player.Character.PrimaryPart,0)
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
print("hb loop loaded")
-- finaly commands!!!

TextChatService.MessageReceived:Connect(function(msg)
    if not msg.TextSource then return end
    if not msg.TextSource.UserId then return end
    if table.find(whitelist,Players:GetNameFromUserIdAsync(msg.TextSource.UserId)) then
        print("HELLO")
        if msg.Text:sub(1,4)=="r34." then
            print("HII")
            local args=msg.Text:sub(5,#msg.Text):split(" ")
            local cmd=args[1]
            print(cmd)
            table.remove(args,1)
            print(unpack(args))
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
                local player=funclib:GetPlayer(args[1])
                if player then
                    table.insert(settings.temp_whitelist,player.Name) 
                end
            end
        end
    end
end)
print('cmds loaded')
print("script made by tatsuki (@.zamnsuki)!!! still lazy but atleast its better than before")
