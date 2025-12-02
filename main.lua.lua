local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "PRiVATE SCRIPT",
    Icon = "door-open", -- lucide icon
    Author = "by FleTheCoder",
    Folder = "MySuperHub",
    
    -- ↓ This all is Optional. You can remove it.
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    
    -- ↓ Optional. You can remove it.
    --[[ You can set 'rbxassetid://' or video to Background.
        'rbxassetid://':
            Background = "rbxassetid://", -- rbxassetid
        Video:
            Background = "video:YOUR-RAW-LINK-TO-VIDEO.webm", -- video 
    --]]
    
    -- ↓ Optional. You can remove it.
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            print("clicked")
        end,
    },
    
    --       remove this all, 
    -- !  ↓  if you DON'T need the key system
    KeySystem = { 
        -- ↓ Optional. You can remove it.
        Key = { "admin123" },
        
        Note = "UJIAN SEMESTER",
        
        -- ↓ Optional. You can remove it.
        Thumbnail = {
            Image = "rbxassetid://",
            Title = "UJIAN SEMESTER",
        },
        
        -- ↓ Optional. You can remove it.
        URL = "YOUR LINK TO GET KEY (Discord, Linkvertise, Pastebin, etc.)",
        
        -- ↓ Optional. You can remove it.
        SaveKey = true, -- automatically save and load the key.
        
        -- ↓ Optional. You can remove it.
        -- API = {} ← Services. Read about it below ↓
    },
})

local Tab = Window:Tab({
    Title = "MAIN",
    Icon = "house", -- optional
    Locked = false,
})

local Tab = Window:Tab({
    Title = "EXPLOITS",
    Icon = "code", -- optional
    Locked = false,
})



local Tab = Window:Tab({
    Title = "PLAYERS",
    Icon = "user", -- optional
    Locked = false,
})

-- VARIABEL & FUNGSI INI HARUS DITULIS SEBELUM TOGGLE (di atas local Toggle = ...)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ESPObjects = {}
local ESPEnabled = false
local heartbeatConnection = nil
local playerAddedConnection = nil
local playerRemovingConnection = nil

local function createESP(plr)
    if plr == LocalPlayer or ESPObjects[plr] or not ESPEnabled then return end
    
    local char = plr.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    -- Highlight (glow orange)
    local highlight = Instance.new("Highlight")
    highlight.Parent = char
    highlight.Adornee = char
    highlight.FillColor = Color3.fromRGB(255, 85, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.4
    highlight.OutlineTransparency = 0
    
    -- BillboardGui untuk nama + distance
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP"
    billboardGui.Parent = hrp
    billboardGui.Size = UDim2.new(0, 250, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.MaxDistance = math.huge
    billboardGui.LightInfluence = 0
    billboardGui.AlwaysOnTop = true
    
    -- Nama username
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = billboardGui
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Text = plr.Name
    nameLabel.TextColor3 = Color3.new(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.TextScaled = true
    
    -- Distance
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Parent = billboardGui
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distanceLabel.Font = Enum.Font.GothamSemibold
    distanceLabel.Text = "0 studs"
    distanceLabel.TextColor3 = Color3.new(0, 255, 0)
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distanceLabel.TextScaled = true
    
    ESPObjects[plr] = {
        Highlight = highlight,
        BillboardGui = billboardGui,
        NameLabel = nameLabel,
        DistanceLabel = distanceLabel
    }
end

local function removeESP(plr)
    local esp = ESPObjects[plr]
    if esp then
        esp.Highlight:Destroy()
        esp.BillboardGui:Destroy()
        ESPObjects[plr] = nil
    end
end

-- TOGGLE (copy-paste ini ganti yang lama)
local Toggle = Tab:Toggle({
    Title = "ESP",
    Desc = "Highlight Players + Username + Distance",
    Icon = "monitor",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        ESPEnabled = state
        
        if state then
            -- Connect events (sekali aja)
            if not playerAddedConnection then
                playerAddedConnection = Players.PlayerAdded:Connect(function(plr)
                    plr.CharacterAdded:Connect(function(char)
                        task.spawn(function()
                            local hrp = char:WaitForChild("HumanoidRootPart", 5)
                            if hrp and ESPEnabled then
                                createESP(plr)
                            end
                        end)
                    end)
                end)
            end
            
            if not playerRemovingConnection then
                playerRemovingConnection = Players.PlayerRemoving:Connect(removeESP)
            end
            
            -- Existing players
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    task.spawn(function()
                        createESP(plr)
                    end)
                end
            end
            
            -- Update distance real-time
            heartbeatConnection = RunService.Heartbeat:Connect(function()
                if not ESPEnabled then return end
                
                local localChar = LocalPlayer.Character
                local localHRP = localChar and localChar:FindFirstChild("HumanoidRootPart")
                if not localHRP then return end
                
                for plr, esp in pairs(ESPObjects) do
                    local char = plr.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local distance = math.floor((localHRP.Position - hrp.Position).Magnitude)
                        esp.DistanceLabel.Text = distance .. " studs"
                        
                        -- Fancy: semi-transparent kalau off-screen
                        local _, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                        local trans = onScreen and 0 or 0.7
                        esp.NameLabel.TextTransparency = trans
                        esp.DistanceLabel.TextTransparency = trans
                    else
                        removeESP(plr)
                    end
                end
            end)
            
            print("ESP AKTIF ✅ - Semua player keliatan!")
        else
            -- OFF & CLEANUP
            if heartbeatConnection then
                heartbeatConnection:Disconnect()
                heartbeatConnection = nil
            end
            
            for plr in pairs(ESPObjects) do
                removeESP(plr)
            end
            
            print("ESP MATI ❌")
        end
    end
})

local Lighting = game:GetService("Lighting")
local oldBrightness = Lighting.Brightness
local oldClockTime = Lighting.ClockTime
local oldFogEnd = Lighting.FogEnd
local oldGlobalShadows = Lighting.GlobalShadows
local oldAmbient = Lighting.Ambient

local Toggle = Tab:Toggle({
    Title = "Full Bright",
    Desc = "Membuat game terang benderang",
    Icon = "lightbulb",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        if state then
            -- FULL BRIGHT ON
            Lighting.Brightness = 10
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            
            print("Full Bright AKTIF")
        else
            -- KEMBALIKAN KE SETTINGAN AWAL (biar ga permanen)
            Lighting.Brightness = oldBrightness
            Lighting.ClockTime = oldClockTime
            Lighting.FogEnd = oldFogEnd
            Lighting.GlobalShadows = oldGlobalShadows
            Lighting.Ambient = oldAmbient
            Lighting.OutdoorAmbient = oldAmbient
            
            print("Full Bright MATI")
        end
    end
})




local Tab = Window:Tab({
    Title = "MISC AND SETTINGS",
    Icon = "settings", -- optional
    Locked = false,
})

-- VARIABEL INI HARUS DITULIS SEBELUM TOGGLE (DI LUAR FUNGSI)
local AntiAFKConnection = nil

local Toggle = Tab:Toggle({
    Title = "ANTI AFK ",
    Desc = "BYPASS ANTI AFK",
    Icon = "server",
    Type = "Checkbox",
    Value = false, -- default value
    Callback = function(state) 
        local Players = game:GetService("Players")
        local VirtualUser = game:GetService("VirtualUser")
        local player = Players.LocalPlayer
        
        if state then
            -- MATIIN YANG LAMA KALAU ADA
            if AntiAFKConnection then
                AntiAFKConnection:Disconnect()
            end
            
            -- AKTIFIN ANTI AFK BARU
            AntiAFKConnection = player.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
            
            print("ANTI AFK AKTIF ✅")
        else
            -- MATIIN ANTI AFK
            if AntiAFKConnection then
                AntiAFKConnection:Disconnect()
                AntiAFKConnection = nil
            end
            
            print("ANTI AFK MATI ❌")
        end
    end
})

WindUI:Notify({
    Title = "PRIVATE SCRIPT HAS LOADED!",
    Content = "GAK BOLEH ADA YANG PAKE KECUALI FLETHECODER",
    Duration = 3, -- 3 seconds
    Icon = "door-open",
})

local Keybind = Tab:Keybind({
    Title = "Keybind",
    Desc = "Keybind to open ui",
    Value = "K",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})