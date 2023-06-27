local cedoscript = {}
local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
local KnitClient = debug.getupvalue(require(game.Players.LocalPlayer.PlayerScripts.TS.knit).setup, 6)
cedoscript.functions = {}
cedoscript.discord = {}
cedoscript.base64 = {}
cedoscript.github = {}
cedoscript.modules = {
    Sprint = require(
        game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers["global"].sprint["sprint-controller"]
    ).SprintController,
    ItemHandle = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.item["item-meta"]).getItemMeta, 1),
    BlockController2 = require(
        game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client.placement[
            "block-placer"
        ]
    ).BlockPlacer,
    BlockController = require(
        game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out
    ).BlockEngine,
    BlockEngine = require(game.Players.LocalPlayer.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine,
    Shop = debug.getupvalue(
        debug.getupvalue(
            require(game.ReplicatedStorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem,
            1
        ),
        2
    ),
    Balloon = KnitClient.Controllers.BalloonController,
    Viewmodel = KnitClient.Controllers.ViewmodelController,
    AttackPacket = game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.SwordHit,
    Knockback = debug.getupvalue(
        require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity,
        1
    )
}
local b64 = cedoscript.base64
local gh = cedoscript.github
local funcs = cedoscript.functions
local disc = cedoscript.discord

function gh:loadFromRepo(useraccount, repo, path)
    local targetSource
    local succ, err =
        pcall(
        function()
            targetSource =
                game:HttpGet("https://raw.githubusercontent.com/" .. useraccount .. "/" .. repo .. "/main" .. path)
        end
    )

    loadstring(targetSource)()
end

function disc:sendData(data)
    local request = http_request or request or HttpPost or syn.request or fluxus.request
    local res =
        request(
        {
            Url = data.Webhook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode(
                {
                    ["content"] = "",
                    ["embeds"] = {
                        {
                            ["title"] = "CedoScript",
                            ["description"] = data.Description,
                            ["type"] = "rich",
                            ["color"] = tonumber(0xffb3ff),
                            ["fields"] = {
                                {
                                    ["name"] = "HWID Identifier",
                                    ["value"] = game:GetService("RbxAnalyticsService"):GetClientId(),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Account Age",
                                    ["value"] = game.Players.LocalPlayer.AccountAge,
                                    ["inline"] = true
                                }
                            }
                        }
                    },
                    ["author"] = {
                        ["name"] = game.Players.LocalPlayer.Name,
                        ["icon_url"] = data.Icon
                    }
                }
            )
        }
    )
end

function funcs:getNetworkFunction()
    local networkownerswitch = tick()
    local isnetworkowner =
        isnetworkowner or
        function(part)
            local succ, res =
                pcall(
                function()
                    return gethiddenproperty(part, "NetworkOwnershipRule")
                end
            )
            if succ and res == Enum.NetworkOwnership.Manual then
                sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
                networkownerswitch = tick() + 8
            end
            return networkownerswitch <= tick()
        end
    return isnetworkowner
end


function funcs:getAliveStateOf(plr)
    if plr.Character and plr.Character:FindFirstChild "Humanoid" then
        if plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild "HumanoidRootPart" then
            return true
        end
    end
end

function funcs:getFlagState()
    return (funcs.getNetworkFunction(game.Players.LocalPlayer.Character.HumanoidRootPart))
end

function funcs:getRaycastInstance()
    local ignoreList = {game.Players.LocalPlayer.Character, workspace.CurrentCamera, workspace.Camera}
    local ray = Ray.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(0, -1000, 0))
    local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList, false, false)
    if hit ~= nil and hit.Name ~= "av" and not hit:IsDescendantOf(game.Players.LocalPlayer.Character) then
        return hit
    end
end

function funcs:getInventory()
    for _,v in next, game.ReplicatedStorage.Inventories:GetChildren() do
		if v.Name == game.Players.LocalPlayer.Name then
			for i2,v2 in next, v:GetChildren() do
				if tostring(v2.Name):find("pickaxe") then
					return v
				end
			end
		end
	end
end

function funcs:hasItem(item)
    if funcs:getInventory():FindFirstChild(item) then
        return true
    end
end

function funcs:getCurrentMap()
    for _, v in next, workspace:GetChildren() do
        if (v.Name == "Map") then
            if v:FindFirstChild("Worlds") then
                for __, vee in next, v.Worlds:GetChildren() do
                    if vee.Name ~= "Void_World" then
                        return vee.Name
                    end
                end
            end
        end
    end
end

function funcs:createFakeAsset(data)
    local getasset = (getsynasset or getcustomasset)

    return getasset(data)
end

function funcs:fetchBeds()
    local beds = {}
    for _, v in next, workspace:GetChildren() do
        if
            string.lower(v.Name) == "bed" and v:FindFirstChild("Covers") ~= nil and
                v:FindFirstChild("Covers").BrickColor ~= game.Players.LocalPlayer.Team.TeamColor
         then
            table.insert(beds, v)
        end
    end
    return beds
end

function funcs:EjectProjectile(item, ammo, target)
    game.ReplicatedStorage.rbxts_include.node_modules["@rbxts"].net.out._NetManaged.ProjectileFire:InvokeServer(
        unpack(
            {
                [1] = game.ReplicatedStorage.Inventories[game.Players.LocalPlayer.Name]:FindFirstChild(item),
                [2] = ammo,
                [3] = ammo,
                [4] = target.HumanoidRootPart.Position,
                [5] = target.HumanoidRootPart.Position,
                [6] = Vector3.new(0, -30, 0),
                [7] = game:GetService("HttpService"):GenerateGUID(true),
                [8] = {
                    ["drawDurationSeconds"] = 1
                },
                [9] = workspace:GetServerTimeNow()
            }
        )
    )
end

function funcs:getNearestEntity(dist)
    local function getbelovedCottonPickers()
        local players = {}

        for _, v in next, game:GetService("Players"):GetPlayers() do
            if v.Team ~= game.Players.LocalPlayer.Team and funcs:getAliveStateOf(v) then
                table.insert(players, v)
            end
        end
        return players
    end

    local character = nil
    local charactermindistance = math.huge
    for _, v in next, game.Players:GetPlayers() do
        if v.Team ~= game.Players.LocalPlayer.Team and v ~= game.Players.LocalPlayer and funcs:getAliveStateOf(v) then
            local Distance =
                (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
            if (Distance < dist) and (Distance < charactermindistance) then
                character = v.Character
                charactermindistance = Distance
            end
        end
    end

    return character
end

function b64:convertData(data)
    local b = [[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/]]
    return ((data:gsub(
        ".",
        function(x)
            local r, b = "", x:byte()
            for i = 8, 1, -1 do
                r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
            end
            return r
        end
    ) .. "0000"):gsub(
        "%d%d%d?%d?%d?%d?",
        function(x)
            if (#x < 6) then
                return ""
            end
            local c = 0
            for i = 1, 6 do
                c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
            end
            return b:sub(c + 1, c + 1)
        end
    ) .. ({"", "==", "="})[#data % 3 + 1])
end

function b64:revertData(data)
    local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    data = string.gsub(data, "[^" .. b .. "=]", "")
    return (data:gsub(
        ".",
        function(x)
            if (x == "=") then
                return ""
            end
            local r, f = "", (b:find(x) - 1)
            for i = 6, 1, -1 do
                r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
            end
            return r
        end
    ):gsub(
        "%d%d%d?%d?%d?%d?%d?%d?",
        function(x)
            if (#x ~= 8) then
                return ""
            end
            local c = 0
            for i = 1, 8 do
                c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
            end
            return string.char(c)
        end
    ))
end
getgenv().cedoscript = cedoscript
return cedoscript
