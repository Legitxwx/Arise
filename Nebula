-- Anti-AFK //
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- // Services //
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

-- // Teleport Points //
local coords = {
    Vector3.new(-4529.82, 20.96, 5754.18),
    Vector3.new(-4574.25, 20.96, 5911.58),
    Vector3.new(-4441.83, 20.96, 6060.51),
    Vector3.new(-4302.81, 22.44, 6346.78),
    Vector3.new(-4174.19, 20.96, 6103.48),
    Vector3.new(-4267.64, 21.96, 5756.46)
}

-- // Anti-Cheat & Anti-Kick //
local function preventAntiCheat()
    -- Disabling certain actions that might trigger the anti-cheat systems.
    -- Using PlatformStand to avoid player detection as being moved unusually.
    local char = lp.Character or lp.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildWhichIsA("Humanoid")

    if humanoid then
        humanoid.PlatformStand = true
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        humanoid.PlatformStand = false
    end
end

-- // Prevent AFK //
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- // Safe Teleport to Prevent Detection //
local function teleportTo(pos)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:FindFirstChildWhichIsA("Humanoid")

    if hrp and hum then
        -- Temporarily disable movement to avoid anti-cheat detection
        hrp.Anchored = true
        hum.PlatformStand = true
        hrp.CFrame = CFrame.new(pos)
        hrp.Velocity = Vector3.zero
        task.wait(0.2)
        hrp.Anchored = false
        hum.PlatformStand = false
    end
end

-- // Find Mob with Humanoid and Health //
local function findMobWithHumanoid()
    local mobs = {}
    for _, mob in pairs(workspace:GetChildren()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(mob) then
            table.insert(mobs, mob)
        end
    end
    return mobs
end

-- // Monitor Mobs Health and Teleport //
local function monitorMobs()
    local mobs = findMobWithHumanoid()
    for _, mob in ipairs(mobs) do
        local humanoid = mob:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.HealthChanged:Connect(function()
                if humanoid.Health <= 0 then
                    -- Teleport to another coordinate after the mob is killed
                    teleportTo(coords[math.random(1, #coords)])  -- Change to teleport to another mob's coordinate
                    -- Optional: Use next mob's coordinates in the list or a different system
                end
            end)
        end
    end
end

-- // GUI Setup //
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NebulaAutoFarm"
gui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Name = "Main"
frame.Size = UDim2.new(0, 270, 0, 210)
frame.Position = UDim2.new(0.35, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

local uicorner = Instance.new("UICorner", frame)
uicorner.CornerRadius = UDim.new(0, 12)

local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30,30,30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(45,45,45))
}

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "Nebula | Auto Farm"
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Delay Box
local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Delay (min 2s)"
box.Text = "3"
box.Size = UDim2.new(0.8, 0, 0.2, 0)
box.Position = UDim2.new(0.1, 0, 0.25, 0)
box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
box.TextColor3 = Color3.new(1,1,1)
box.Font = Enum.Font.Gotham
box.TextScaled = true
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

-- Toggle Button
local toggle = Instance.new("TextButton", frame)
toggle.Text = "Start Auto Farm"
toggle.Size = UDim2.new(0.8, 0, 0.2, 0)
toggle.Position = UDim2.new(0.1, 0, 0.5, 0)
toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

-- Timer Label
local timer = Instance.new("TextLabel", frame)
timer.Text = "Grind Time: 00:00:00"
timer.Size = UDim2.new(1, -10, 0.15, 0)
timer.Position = UDim2.new(0.05, 0, 0.75, 0)
timer.BackgroundTransparency = 1
timer.TextColor3 = Color3.new(1,1,1)
timer.Font = Enum.Font.Gotham
timer.TextScaled = true

-- Toggle GUI w/ RightShift
local visible = true
UIS.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightShift then
        visible = not visible
        frame.Visible = visible
    end
end)

-- Timer System
local startTime = tick()
RunService.RenderStepped:Connect(function()
    local dt = tick() - startTime
    local h = math.floor(dt / 3600)
    local m = math.floor((dt % 3600) / 60)
    local s = math.floor(dt % 60)
    timer.Text = string.format("Grind Time: %02d:%02d:%02d", h, m, s)
end)

-- Start Farm
local farming = false
toggle.MouseButton1Click:Connect(function()
    farming = not farming
    toggle.Text = farming and "Stop Auto Farm" or "Start Auto Farm"
    toggle.BackgroundColor3 = farming and Color3.fromRGB(170,0,0) or Color3.fromRGB(0,170,0)

    while farming do
        local delay = tonumber(box.Text) or 2
        if delay < 2 then delay = 2 end

        -- Monitor mobs and teleport to new coordinates when a mob is killed
        monitorMobs()

        task.wait(delay)
    end
end)

-- Start the Anti-Cheat & Anti-Kick Prevention
while true do
    preventAntiCheat()
    task.wait(1)  -- Run every second to prevent detection
end
