-- |★• DW ELITE HUB: ULTIMATE KEYLESS FIX •★|
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DW_Keyless_System"
ScreenGui.Parent = game:GetService("CoreGui") -- Forzamos la aparición en CoreGui

local function makeDraggable(frame)
    frame.Active = true
    frame.Draggable = true
end

-- ==========================================
-- VENTANA PRINCIPAL
-- ==========================================
local MainGui = Instance.new("Frame", ScreenGui)
MainGui.Size = UDim2.new(0, 280, 0, 480)
MainGui.Position = UDim2.new(0.5, -140, 0.5, -240)
MainGui.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Un poco más oscuro para que resalte
MainGui.BorderSizePixel = 5
makeDraggable(MainGui)

-- [EFECTO RAINBOW BORDER]
spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        MainGui.BorderColor3 = Color3.fromHSV(hue, 1, 1)
    end
end)

local Title = Instance.new("TextLabel", MainGui)
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.Text = "DW GUI KEYLESS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", MainGui)
Scroll.Size = UDim2.new(1, 0, 0.88, 0)
Scroll.Position = UDim2.new(0, 0, 0.12, 0)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 3, 0) 
Scroll.ScrollBarThickness = 6

local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 5)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createBtn(name, color)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0.9, 0, 0.07, 0)
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 2
    btn.TextScaled = true
    return btn
end

-- ==========================================
-- FUNCIONES (UNA POR UNA)
-- ==========================================

-- 1. RUDIE DASH
local rudieDash = createBtn("RUDIE DASH (1.0s)", Color3.fromRGB(0, 255, 0))
local canDash = true
rudieDash.MouseButton1Click:Connect(function()
    if canDash then
        canDash = false
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Velocity = hrp.CFrame.LookVector * 120 end
        rudieDash.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        task.wait(3)
        rudieDash.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        canDash = true
    end
end)

-- 2. SPEED 50 (PARA DISTRAER A DYLE)
local speedMode = createBtn("SPEED 50 / UNSPEED", Color3.fromRGB(255, 0, 255))
local speedActive = false
spawn(function()
    while task.wait() do
        if speedActive then
            pcall(function()
                local p = game.Players.LocalPlayer.Character
                local hrp = p.HumanoidRootPart
                local hum = p.Humanoid
                if hum.MoveDirection.Magnitude > 0 then
                    hrp.CFrame = hrp.CFrame + (hum.MoveDirection * 4)
                end
            end)
        end
    end
end)
speedMode.MouseButton1Click:Connect(function() speedActive = not speedActive end)

-- 3. ESP
createBtn("ESP / UNESP", Color3.fromRGB(255, 0, 255)).MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and (v:FindFirstChild("Humanoid") or v.Name:find("Twisted")) then
            if not v:FindFirstChild("Highlight") then
                local h = Instance.new("Highlight", v)
                h.FillColor = Color3.fromRGB(255, 0, 0)
                h.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        end
    end
end)

-- 4. AUTO COMPLETE MACHINES
createBtn("AUTO COMPLETE MACHINES", Color3.fromRGB(0, 255, 0)).MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():find("machine") and v:FindFirstChild("RepairProgress") then
            v.RepairProgress.Value = 100
        end
    end
end)

-- 5. BE INVISIBLE (AUTO-OFF ELEVADOR)
local invBtn = createBtn("BE INVISIBLE", Color3.fromRGB(255, 255, 255))
local invisible = false
invBtn.MouseButton1Click:Connect(function()
    invisible = not invisible
    invBtn.Text = invisible and "INVISIBLE: ON" or "BE INVISIBLE"
end)

-- 6. INF ICHOR & EXTRACT SPEED
createBtn("INF ICHOR", Color3.fromRGB(0, 0, 255)).MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character:SetAttribute("Ichor", 999999)
end)

createBtn("EXTRACT SPEED 999.999", Color3.fromRGB(255, 0, 0)).MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character:SetAttribute("ExtractionSpeed", 999999)
end)

createBtn("NO FOG / LIGHT", Color3.fromRGB(255, 255, 255)).MouseButton1Click:Connect(function()
    game.Lighting.FogEnd = 999999
    local l = Instance.new("PointLight", game.Players.LocalPlayer.Character.HumanoidRootPart)
    l.Range = 100
end)
