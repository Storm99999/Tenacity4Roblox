local module = {}
local uh = nil

function module:CreateTimer()
  -- Gui to Lua
  -- Version: 3.2

  -- Instances:

  local ScreenGui = Instance.new("ScreenGui")
  local timeleft = Instance.new("Frame")
  local TextLabel = Instance.new("TextLabel")
  local UIGradient = Instance.new("UIGradient")
  local UICorner = Instance.new("UICorner")

  --Properties:

  ScreenGui.Parent = game:WaitForChild("CoreGui")
  ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

  timeleft.Name = "timeleft"
  timeleft.Parent = ScreenGui
  timeleft.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
  timeleft.BackgroundTransparency = 1.000
  timeleft.Position = UDim2.new(0.387049109, 0, 0.822180867, 0)
  timeleft.Size = UDim2.new(0.352087229, 0, 0.0169904511, 0)
  uh = TextLabel
  TextLabel.Parent = timeleft
  TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  TextLabel.BackgroundTransparency = 1.000
  TextLabel.Position = UDim2.new(0.17883271, 0, -47.188015, 0)
  TextLabel.Size = UDim2.new(0, 200, 0, 50)
  TextLabel.Font = Enum.Font.Unknown
  TextLabel.Text = "2"
  TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  TextLabel.TextSize = 43.000
  TextLabel.Visible = false

  UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 85, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(75, 150, 225))}
  UIGradient.Parent = TextLabel

  UICorner.CornerRadius = UDim.new(0, 13)
  UICorner.Parent = timeleft
end


function module:StartTimer()
    local script = uh
    local waitvalue = 2

    for i = 0, 19 do
      task.wait(.3)
      if waitvalue < 0 then
        script.Parent.TextLabel.Visible = false
        break
      end
      waitvalue -= .1
      script.Parent.TextLabel.Text = string.sub(tostring(waitvalue), 1, 3)
      if script.Parent.TextLabel.Text:find('-') then
        script.Parent.TextLabel.Visible = false
        break
      end
    end  
end
