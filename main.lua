local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function applyEffectAndSpeed(character)
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local playerGui = player:WaitForChild("PlayerGui")

    -- 1. UI Erstellen
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AccessEffect"
    screenGui.DisplayOrder = 999 -- Sorgt dafür, dass es über allem anderen steht
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(1, 1, 1)
    frame.BorderSizePixel = 0
    frame.Visible = true
    frame.Parent = screenGui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.8, 0, 0.2, 0)
    label.Position = UDim2.new(0.1, 0, 0.4, 0)
    label.BackgroundTransparency = 1
    label.Text = "YouHaventAccess - yha.lol"
    label.TextColor3 = Color3.new(0, 0, 0)
    label.TextScaled = true
    label.ZIndex = 10
    label.Font = Enum.Font.Code
    label.Parent = frame

    -- 2. Flacker-Logik (Rot, Grün, Weiß)
    local colors = {
        Color3.fromRGB(255, 0, 0),   -- Rot
        Color3.fromRGB(0, 255, 0),   -- Grün
        Color3.fromRGB(255, 255, 255) -- Weiß
    }

    local endTime = tick() + 1.5
    while tick() < endTime do
        frame.BackgroundColor3 = colors[math.random(1, #colors)]
        task.wait(0.05) -- Schnelles Flackern
    end

    -- 3. Effekt beenden & Werte setzen
    screenGui:Destroy()
    
    -- Speed setzen
    humanoid.WalkSpeed = 200
    
    -- 2 Studs Boost nach vorne (Relativ zur Blickrichtung)
    rootPart.CFrame = rootPart.CFrame * CFrame.new(0, 0, -2)
end

-- Start-Trigger
if player.Character then
    task.spawn(applyEffectAndSpeed, player.Character)
end

player.CharacterAdded:Connect(function(character)
    applyEffectAndSpeed(character)
end)
