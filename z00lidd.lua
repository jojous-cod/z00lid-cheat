local CG = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local Run = game:GetService("RunService")
local Plrs = game:GetService("Players")
local lp = Plrs.LocalPlayer

_G.XenoFlySpeed = 60
_G.XenoIsFlying = false
_G.XenoIsNoclip = false
_G.XenoESP = false
_G.XenoKeys = {W = false, S = false, A = false, D = false}

if CG:FindFirstChild("z00lidGUIContainer") then 
    CG.z00lidGUIContainer:Destroy() 
end

local sg = Instance.new("ScreenGui", CG)
sg.Name = "z00lidGUIContainer"
sg.ResetOnSpawn = false
_G.XenoSg = sg

local openBtn = Instance.new("TextButton", sg)
openBtn.Size = UDim2.new(0, 60, 0, 60)
openBtn.Position = UDim2.new(0.02, 0, 0.45, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 22
openBtn.Text = "X"
openBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
openBtn.Active = true
_G.XenoOpenBtn = openBtn

local btnStroke = Instance.new("UIStroke", openBtn)
btnStroke.Thickness = 3.5
btnStroke.Color = Color3.fromRGB(0, 255, 255)
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0.5, 0)

local pan = Instance.new("Frame", sg)
pan.Name = "XenoMainPanel"
pan.Size = UDim2.new(0, 320, 0, 395) -- Сразу увеличен под 4 кнопки
pan.Position = UDim2.new(0.02, 70, 0.22, 0)
pan.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
pan.BackgroundTransparency = 0.1
Instance.new("UICorner", pan)
_G.XenoPan = pan

local pStroke = Instance.new("UIStroke", pan)
pStroke.Thickness = 4
pStroke.Color = Color3.fromRGB(0, 255, 255)

local title = Instance.new("TextLabel", pan)
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(0, 255, 255)

openBtn.MouseButton1Click:Connect(function() 
    pan.Visible = not pan.Visible 
end)

local tickPulse = 0
local chars = {"#", "@", "*", "?", "%", "!", "Ø", "Ω", "Ξ", "Δ", "X", "Z"}

Run.Heartbeat:Connect(function() 
    if not sg.Parent then return end
    tickPulse = tickPulse + 0.04
    local pulse = (math.sin(tickPulse) + 1) / 2
    local neonColor = Color3.fromRGB(0, math.floor(130 + (pulse * 125)), 255)
    
    if math.random(1, 100) <= 35 then 
        local r1 = chars[math.random(1, #chars)]
        local r2 = chars[math.random(1, #chars)]
        title.Text = "z00l" .. r1 .. "d G" .. r2 .. "I"
        openBtn.Text = r1
        local glitchC = (math.random(1, 100) <= 40) and Color3.fromRGB(255, 30, 30) or Color3.fromRGB(255, 255, 255)
        pStroke.Color = glitchC
        btnStroke.Color = glitchC
        title.TextColor3 = glitchC
        openBtn.TextColor3 = glitchC
    else 
        title.Text = "z00lidd GUI Premium"
        openBtn.Text = "X"
        pStroke.Color = neonColor
        btnStroke.Color = neonColor
        title.TextColor3 = Color3.fromRGB(0, 220, 255)
        openBtn.TextColor3 = Color3.fromRGB(0, 220, 255)
    end 
end)

local function drag(g, h)
    local d, o = false, Vector2.new(0, 0)
    local head = h or g
    head.InputBegan:Connect(function(i) 
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
            d = true
            o = Vector2.new(UIS:GetMouseLocation().X - g.AbsolutePosition.X, UIS:GetMouseLocation().Y - g.AbsolutePosition.Y) 
        end 
    end)
    UIS.InputEnded:Connect(function(i) 
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
            d = false 
        end 
    end)
    Run.Heartbeat:Connect(function() 
        if d then 
            g.Position = UDim2.new(0, UIS:GetMouseLocation().X - o.X, 0, UIS:GetMouseLocation().Y - o.Y) 
        end 
    end)
end
drag(openBtn)
drag(pan, title)
local UIS = game:GetService("UserInputService")
local Run = game:GetService("RunService")
local Plrs = game:GetService("Players")
local lp = Plrs.LocalPlayer
local pan = _G.XenoPan
local chars = {"#", "@", "*", "?", "%", "!", "Ø", "Ω", "Ξ", "Δ", "X", "Z"}

local function makeBtn(pos)
    local b = Instance.new("TextButton", pan)
    b.Size = UDim2.new(0, 280, 0, 45)
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    Instance.new("UICorner", b)
    local bs = Instance.new("UIStroke", b)
    bs.Thickness = 1.5
    bs.Color = Color3.fromRGB(0, 150, 255)
    return b 
end

local flyB = makeBtn(UDim2.new(0.5, -140, 0, 55))
local nclB = makeBtn(UDim2.new(0.5, -140, 0, 110))
local espB = makeBtn(UDim2.new(0.5, -140, 0, 165))
local destB = makeBtn(UDim2.new(0.5, -140, 0, 220)) -- Кнопка аннигиляции карты

flyB.MouseButton1Click:Connect(function() _G.XenoIsFlying = not _G.XenoIsFlying end)
nclB.MouseButton1Click:Connect(function() _G.XenoIsNoclip = not _G.XenoIsNoclip end)
espB.MouseButton1Click:Connect(function() 
    _G.XenoESP = not _G.XenoESP
    for _, p in ipairs(Plrs:GetPlayers()) do 
        if p.Character and p.Character:FindFirstChild("XenoESP") then 
            p.Character.XenoESP.Enabled = _G.XenoESP 
        end 
    end 
end)

-- СКРИПТ КЛИЕНТСКОГО АПОКАЛИПСИСА С ПАДЕНИЕМ ИГРОКОВ
destB.MouseButton1Click:Connect(function()
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj ~= workspace.CurrentCamera and obj ~= lp.Character and obj.Name ~= "Terrain" then
            local isPlayer = false
            for _, p in ipairs(Plrs:GetPlayers()) do
                if p.Character == obj then isPlayer = true break end
            end
            if not isPlayer then
                obj:Destroy()
            end
        end
    end
    if workspace:FindFirstChildOfClass("Terrain") then
        workspace:FindFirstChildOfClass("Terrain"):Clear()
    end
    task.spawn(function()
        while task.wait() do
            for _, p in ipairs(Plrs:GetPlayers()) do
                if p ~= lp and p.Character then
                    for _, part in ipairs(p.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end
    end)
end)

Run.Heartbeat:Connect(function() 
    local r = chars[math.random(1, #chars)]
    if math.random(1, 100) <= 35 then 
        flyB.Text = _G.XenoIsFlying and "FL" .. r .. ": ON" or "FL" .. r .. ": OFF"
        nclB.Text = _G.XenoIsNoclip and "N" .. r .. "CLP: ON" or "N" .. r .. "CLP: OFF"
        espB.Text = _G.XenoESP and "C" .. r .. "BER: ON" or "C" .. r .. "BER: OFF"
        destB.Text = "AN" .. r .. "IHILATE MAP"
        local gC = (math.random(1, 100) <= 40) and Color3.fromRGB(255, 30, 30) or Color3.fromRGB(255, 255, 255)
        flyB.TextColor3 = gC; nclB.TextColor3 = gC; espB.TextColor3 = gC; destB.TextColor3 = gC
    else 
        flyB.Text = _G.XenoIsFlying and "FLY: ACTIVE" or "FLY: OFF"
        nclB.Text = _G.XenoIsNoclip and "NOCLIP: ACTIVE" or "NOCLIP: OFF"
        espB.Text = _G.XenoESP and "CYBER ESP: ACTIVE" or "CYBER ESP: OFF"
        destB.Text = "ANNIHILATE MAP"
        local dC = Color3.fromRGB(255, 255, 255)
        flyB.TextColor3 = dC; nclB.TextColor3 = dC; espB.TextColor3 = dC; destB.TextColor3 = dC
    end 
end)

local sLab = Instance.new("TextLabel", pan)
sLab.Size = UDim2.new(0, 280, 0, 20)
sLab.Position = UDim2.new(0.5, -140, 0, 285)
sLab.BackgroundTransparency = 1
sLab.Font = Enum.Font.GothamBold
sLab.TextSize = 14
sLab.Text = "SPEED: 60"
sLab.TextColor3 = Color3.fromRGB(0, 255, 255)

local sFrame = Instance.new("Frame", pan)
sFrame.Size = UDim2.new(0, 280, 0, 8)
sFrame.Position = UDim2.new(0.5, -140, 0, 320)
sFrame.BackgroundColor3 = Color3.fromRGB(30, 40, 55)
Instance.new("UICorner", sFrame)

local sBtn = Instance.new("TextButton", sFrame)
sBtn.Size = UDim2.new(0, 18, 0, 18)
sBtn.Position = UDim2.new(0.09, -9, 0.5, -9)
sBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sBtn.Text = ""
Instance.new("UICorner", sBtn).CornerRadius = UDim.new(0.5, 0)
Instance.new("UIStroke", sBtn).Color = Color3.fromRGB(0, 255, 255)

local sDrag = false
sBtn.InputBegan:Connect(function(i) 
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then sDrag = true end 
end)
UIS.InputEnded:Connect(function(i) 
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then sDrag = false end 
end)

Run.Heartbeat:Connect(function() 
    if sDrag then 
        local scale = math.clamp((UIS:GetMouseLocation().X - sFrame.AbsolutePosition.X) / sFrame.AbsoluteSize.X, 0, 1)
        sBtn.Position = UDim2.new(scale, -9, 0.5, -9)
        _G.XenoFlySpeed = math.floor(16 + (scale * 19984)) -- Шкала до 20к
        sLab.Text = "SPEED: " .. tostring(_G.XenoFlySpeed)
    end 
end)

local function applyESP(p)
    if p == lp then return end
    local function addHl(c)
        if not c or not c.Parent then return end
        if c:FindFirstChild("XenoESP") then c.XenoESP:Destroy() end
        local hl = Instance.new("Highlight", c)
        hl.Name = "XenoESP"
        hl.FillColor = Color3.fromRGB(0, 15, 255) -- Под цвет неона
        hl.FillTransparency = 0.5
        hl.OutlineColor = Color3.fromRGB(0, 15, 255)
        hl.OutlineTransparency = 0.1
        hl.Enabled = _G.XenoESP 
    end
    if p.Character then addHl(p.Character) end
    p.CharacterAdded:Connect(addHl)
end
for _, p in ipairs(Plrs:GetPlayers()) do applyESP(p) end
Plrs.PlayerAdded:Connect(applyESP)

UIS.InputBegan:Connect(function(i, p) 
    if p then return end
    if i.KeyCode == Enum.KeyCode.W then _G.XenoKeys.W = true 
    elseif i.KeyCode == Enum.KeyCode.S then _G.XenoKeys.S = true 
    elseif i.KeyCode == Enum.KeyCode.A then _G.XenoKeys.A = true 
    elseif i.KeyCode == Enum.KeyCode.D then _G.XenoKeys.D = true end 
end)

UIS.InputEnded:Connect(function(i, p) 
    if i.KeyCode == Enum.KeyCode.W then _G.XenoKeys.W = false 
    elseif i.KeyCode == Enum.KeyCode.S then _G.XenoKeys.S = false 
    elseif i.KeyCode == Enum.KeyCode.A then _G.XenoKeys.A = false 
    elseif i.KeyCode == Enum.KeyCode.D then _G.XenoKeys.D = false end 
end)

local camera = workspace.CurrentCamera
local bVel, bGyro

Run.Stepped:Connect(function()
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = lp.Character.HumanoidRootPart
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        
        if _G.XenoIsFlying then
            if hum then hum.PlatformStand = true end
            if not bVel or bVel.Parent ~= hrp then
                bVel = Instance.new("BodyVelocity")
                bVel.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                bVel.Velocity = Vector3.new(0, 0, 0)
                bVel.Parent = hrp
            end
            if not bGyro or bGyro.Parent ~= hrp then
                bGyro = Instance.new("BodyGyro")
                bGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
                bGyro.CFrame = hrp.CFrame
                bGyro.Parent = hrp
            end
            local moveDir = Vector3.new(0, 0, 0)
            if _G.XenoKeys.W then moveDir = moveDir + camera.CFrame.LookVector end
            if _G.XenoKeys.S then moveDir = moveDir - camera.CFrame.LookVector end
            if _G.XenoKeys.A then moveDir = moveDir - camera.CFrame.RightVector end
            if _G.XenoKeys.D then moveDir = moveDir + camera.CFrame.RightVector end
            bVel.Velocity = moveDir * _G.XenoFlySpeed
            bGyro.CFrame = camera.CFrame
        else
            if hum and hum.PlatformStand then hum.PlatformStand = false end
            if bVel then bVel:Destroy() bVel = nil end
            if bGyro then bGyro:Destroy() bGyro = nil end
        end
        
        if _G.XenoIsNoclip then
            for _, child in ipairs(lp.Character:GetDescendants()) do
                if child:IsA("BasePart") then child.CanCollide = false end
            end
        end
    end
end)

local r6Parts = {"Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}
Run.Heartbeat:Connect(function()
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        local strictNeonBlue = Color3.fromRGB(0, 15, 255) 
        for _, name in ipairs(r6Parts) do
            local part = lp.Character:FindFirstChild(name)
            if part and part:IsA("BasePart") then
                local cloneName = "XenoTightNeon_" .. name
                local tightClone = part:FindFirstChild(cloneName)
                if math.random(1, 100) <= 15 then
                    if not tightClone then
                        local neonBlock = Instance.new("Part")
                        neonBlock.Name = cloneName
                        neonBlock.Size = part.Size + Vector3.new(0.04, 0.04, 0.04)
                        neonBlock.Transparency = 0.15 
                        neonBlock.Material = Enum.Material.Neon
                        neonBlock.Color = strictNeonBlue
                        neonBlock.CanCollide = false
                        neonBlock.Massless = true
                        local weld = Instance.new("Weld", neonBlock)
                        weld.Part0 = part
                        weld.Part1 = neonBlock
                        weld.C0 = CFrame.new(0, 0, 0)
                        neonBlock.Parent = part
                    end
                else
                    if tightClone then tightClone:Destroy() end
                end
            end
        end
    end
end)
