getgenv().radarActive = false
local RadarGui = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local UICorner = Instance.new("UICorner")
local Frame = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local L2 = Instance.new("Frame")
local L1 = Instance.new("Frame")
local PlayerTemplate = Instance.new("ImageLabel")
local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")

--Properties:

RadarGui.Name = "Radar"
RadarGui.Parent = game.CoreGui
RadarGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
getgenv().RadarUI = RadarGui

Background.Name = "Background"
Background.Parent = RadarGui
Background.AnchorPoint = Vector2.new(0, 1)
Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Background.BorderSizePixel = 0
Background.ClipsDescendants = true
Background.Position = UDim2.new(0.0100512523, 0, 0.47035712, 0)
Background.Size = UDim2.new(0.167224079, 0, 0.251889169, 0)

UIAspectRatioConstraint.Parent = Background

UICorner.CornerRadius = UDim.new(0, 13)
UICorner.Parent = Background

Frame.Parent = Background
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.Position = UDim2.new(-0.00391740119, 0, -0.0082418872, 0)
Frame.Size = UDim2.new(1.00998461, 0, 1.01108968, 0)
Frame.ZIndex = 2

UICorner_2.CornerRadius = UDim.new(0, 13)
UICorner_2.Parent = Frame

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 170, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(76, 154, 216))}
UIGradient.Rotation = 90
UIGradient.Parent = Frame

L2.Name = "L2"
L2.Parent = Background
L2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L2.BorderSizePixel = 0
L2.Position = UDim2.new(0.497487575, 0, 0.0123753119, 0)
L2.Rotation = 90.000
L2.Size = UDim2.new(0, 1, 0, 192)
L2.ZIndex = 2

L1.Name = "L1"
L1.Parent = Background
L1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L1.BorderSizePixel = 0
L1.Position = UDim2.new(0.495012492, 0, -0.00990024954, 0)
L1.Size = UDim2.new(0, 1, 0, 202)
L1.ZIndex = 2

PlayerTemplate.Name = "PlayerTemplate"
PlayerTemplate.Parent = RadarGui
PlayerTemplate.AnchorPoint = Vector2.new(0.5, 0.5)
PlayerTemplate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayerTemplate.BackgroundTransparency = 1.000
PlayerTemplate.Position = UDim2.new(0.627615035, 0, 0.405857742, 0)
PlayerTemplate.Size = UDim2.new(0.0399999991, 0, 0.0399999991, 0)
PlayerTemplate.Visible = false
PlayerTemplate.ZIndex = 999
PlayerTemplate.Image = "rbxassetid://6401676565"

UIAspectRatioConstraint_2.Parent = PlayerTemplate

-- Scripts:

local function JZJOV_fake_script() -- RadarGui.RadarScript 
	local script = Instance.new('LocalScript', RadarGui)

	local plr = game.Players.LocalPlayer
	
	local Background = script.Parent:WaitForChild("Background")
	local playerTemplate = script.Parent:WaitForChild('PlayerTemplate')
	
	local character = plr.Character or plr.CharacterAdded:Wait()
	
	game:GetService("RunService").RenderStepped:Connect(function()
    if radarActive then
      for _,v in next, script.Parent.Background:GetChildren()do
        if v:IsA('Frame') or v:IsA('UICorner') or v:IsA('UIGradient') then
          continue
        end

        v:Destroy()
      end
      --Background:ClearAllChildren()
      local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint", Background)

      for i, otherPlayer in pairs(game.Players:GetPlayers()) do

        local otherChar = otherPlayer.Character

        if otherPlayer ~= plr then
          if otherChar and otherChar:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart") then

            local playerDot = playerTemplate:Clone()								
            local offset = otherChar.HumanoidRootPart.Position - character.HumanoidRootPart.Position				
            local distance = 1/200
            playerDot.Visible = true

            offset = offset * distance
            playerDot.Position = UDim2.new(offset.X + 0.5, 0, offset.Z + 0.5, 0)								
            playerDot.Parent = Background
          end
        else			
          local playerDot = playerTemplate:Clone()		
          playerDot.Position = UDim2.new(0.5, 0, 0.5, 0)
          playerDot.Parent = Background
          playerDot.Visible = true
          playerDot.ImageColor3 = Color3.fromRGB(85, 170, 127)
        end
      end
    end
	end)
end
coroutine.wrap(JZJOV_fake_script)()
local function FRKCRA_fake_script() -- RadarGui.LocalScript 
	local script = Instance.new('LocalScript', RadarGui)

	local l1 = script.Parent.Background.L1
	
	l1.Size = UDim2.new(0, 1, 1, 1)
	
	local l2 = script.Parent.Background.L2
	
	l2.Size = UDim2.new(0, 1, 1, 1)
end
coroutine.wrap(FRKCRA_fake_script)()
