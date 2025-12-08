
local Version = "1.6.53"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. Version .. "/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "NebulaWare | FFAG",
    Icon = "webhook", -- lucide icon
    Author = "by FleTheCoder",
    Folder = "MySuperHub",
    
    -- ↓ This all is Optional. You can remove it.
    Size = UDim2.fromOffset(560, 350),
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
        Anonymous = false,
        Callback = function()
            print("clicked")
        end,
    },
    
    --       remove this all, 
    -- !  ↓  if you DON'T need the key system
    KeySystem = { 
        -- ↓ Optional. You can remove it.
        Key = { "admin123" },
        
        Note = "KeySystem",
        
        -- ↓ Optional. You can remove it.
        Thumbnail = {
            Image = "NIL",
            Title = "KeySystem",
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
    Title = "INFOMATION",
    Icon = "message-circle-warning", -- optional
    Locked = false,
})

Tab:Paragraph({
    Title = "Welcome To NebulawareX",
    Desc = "Made by FleTheCoder\nRequest fitur? Join Discord server sekarang!",
    Color = Color3.fromRGB(0, 200, 255),
    Image = "rbxassetid://6031075938",  -- icon discord biru
    ImageSize = 40,
    Buttons = {
        {
            Icon = "clipboard",
            Title = "Copy Discord Link",
            Callback = function()
                local link = "https://discord.gg/5G8nw3zd"
                
                -- Copy pake setclipboard (support luas)
                if setclipboard then
                    setclipboard(link)
                end
                
                -- Backup pake toclipboard (Delta/Fluxus dll)
                if toclipboard then
                    toclipboard(link)
                end
                
                -- Notif keren (work semua executor)
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "✅ Discord Link Copied!",
                    Text = link,
                    Icon = "rbxassetid://6031075938",
                    Duration = 5
                })
                
                print("Discord link copied: " .. link)  -- Debug console
            end
        }
    }
})

local Tab = Window:Tab({
    Title = "EXPLOITS",
    Icon = "code", -- optional
    Locked = false,
})

local Button = Tab:Button({
    Title = "FLY GUI V3",
    Desc = "MAKE YOU FLY",
    Icon = "rocket", -- atau "plane" / "bird" kalau mau
    Locked = false,
    Callback = function()
        -- Cek biar ga dobel execute
        if getgenv().FlyV3Loaded then
            print("Fly V3 udah jalan bro!")
            return
        end
        
        getgenv().FlyV3Loaded = true
        print("Loading XNEOFF Fly V3...")
        
        -- Execute scriptnya
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
        
        print("Fly V3 berhasil dijalankan!")
    end
})

-- PASTE INI DI BAWAH TAB YANG LU MAU (misal MainTab atau MiscTab)

Nebula.NoClipEnabled = false
Nebula.NoClipConn = nil

local Toggle = Tab:Toggle({
    Title = "NO CLIP",
    Desc = "TOGGLE NO CLIP ON/OFF",
    Icon = "brick-wall",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        Nebula.NoClipEnabled = state
        local player = game.Players.LocalPlayer

        -- MATIKAN NOCLIP
        if not state then
            print("NOCLIP OFF - COLLISION NORMAL")

            -- Putuskan koneksi
            if Nebula.NoClipConn then
                Nebula.NoClipConn:Disconnect()
                Nebula.NoClipConn = nil
            end

            -- Kembalikan CanCollide = true
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end

            return
        end

        -- HIDUPKAN NOCLIP
        print("NOCLIP ON - Menembus aktif!")

        Nebula.NoClipConn = game:GetService("RunService").Stepped:Connect(function()
            if player.Character and Nebula.NoClipEnabled then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
})


local Button = Tab:Button({
    Title = "Infinite Yield",
    Desc = "Admin Commands - Fly, Noclip, Kick, Ban, dll",
    Icon = "terminal",
    Locked = false,
    Callback = function()
        -- Anti dobel execute
        if getgenv().IYLoaded then
            WindUI:Notify({
                Title = "Infinite Yield",
                Content = "Sudah dijalankan! Ketik ;cmds di chat",
                Duration = 5
            })
            return
        end

        getgenv().IYLoaded = true

        -- Loading notification
        WindUI:Notify({
            Title = "Infinite Yield",
            Content = "Loading admin commands...",
            Duration = 6
        })

        -- Execute script
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()

        -- Sukses notification
        task.wait(2)
        WindUI:Notify({
            Title = "Infinite Yield Loaded!",
            Content = "Ketik ;cmds di chat untuk semua command!",
            Duration = 7,
            Icon = "crown"
        })
    end
})

-- Auto aktif lagi kalau respawn
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if Toggle.Value then
        task.wait(0.5)
        Toggle.Value = true  -- otomatis nyalain lagi
    end
end)

local SpeedSlider = Tab:Slider({
    Title = "Speed Hack",
    Desc = "WalkSpeed Multiplier (Aman bro)",
    Step = 1,
    Value = {
        Min = 16,
        Max = 300,
        Default = 16, -- default walkspeed biar ga keciduk pas join
    },
    Callback = function(value)
        if not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then return end
        
        local humanoid = game.Players.LocalPlayer.Character.Humanoid
        
        -- Anti-detect trick: jangan langsung set WalkSpeed mentah
        -- Pake Change + random kecil biar ga keliatan modify langsung
        humanoid.WalkSpeed = 16
        task.wait()
        humanoid.WalkSpeed = value + math.random(-2, 2)
        
        -- Spoof buat anti-cheat yang cek perubahan langsung
        task.spawn(function()
            while task.wait(1.5) and humanoid.WalkSpeed > 50 do
                humanoid.WalkSpeed = humanoid.WalkSpeed + math.random(-3, 3)
            end
        end)
    end
})


local JumpSlider = Tab:Slider({
    Title = "Jump Boost",
    Desc = "JumpPower / JumpHeight (Undetected)",
    Step = 1,
    Value = {
        Min = 50,
        Max = 250,
        Default = 50, -- default roblox jump power
    },
    Callback = function(value)
        if not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then return end
        
        local humanoid = game.Players.LocalPlayer.Character.Humanoid
        humanoid.UseJumpPower = true -- penting banget biar ga keciduk pake JumpHeight
        
        -- Smooth + anti-detect
        humanoid.JumpPower = 50
        task.wait()
        humanoid.JumpPower = value + math.random(-5, 5)
        
        -- Randomize sedikit tiap beberapa detik biar natural
        task.spawn(function()
            while task.wait(2) and humanoid.JumpPower > 80 do
                humanoid.JumpPower = humanoid.JumpPower + math.random(-8, 8)
            end
        end)
    end
})

local Button = Tab:Button({
    Title = "REMOTE SPY",
    Desc = "SPYING FUNC IN GAME",
    Icon = "discord",
    Locked = false,
    Callback = function()
        -- Anti double execute
        if getgenv().DiscordRPCLoaded then
            WindUI:Notify({
                Title = "REMOTE SPY",
                Content = "SPY RUN",
                Duration = 4
            })
            return
        end

        getgenv().DiscordRPCLoaded = true

        WindUI:Notify({
            Title = "STATUS",
            Content = "LOADING SPY",
            Duration = 6,
            Icon = "discord"
        })

        -- Execute script Rich Presence 24/7
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wfrefdewwss/Discord-Custom-Status-24-7/refs/heads/main/requirements.txt"))()

        task.wait(3)
        WindUI:Notify({
            Title = "Discord RPC Active!",
            Content = "Status lu sekarang: Playing NebulaWare",
            Duration = 7,
            Icon = "check"
        })
    end
})

local Tab = Window:Tab({
    Title = "PLAYERS",
    Icon = "user", -- optional
    Locked = false,
})

local ESPToggle = Tab:Toggle({
    Title = "Full Box ESP",
    Desc = "3D Box + Tracer + Name + Distance + HP",
    Icon = "crosshair",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        getgenv().FullESP = state
        if state then
            StartFullESP()
        else
            ClearFullESP()
        end
    end
})

local ESP = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local cam = workspace.CurrentCamera

-- Buat Drawing object per player
local function AddPlayerESP(plr)
    if plr == Players.LocalPlayer then return end
    
    ESP[plr] = {
        Box = Drawing.new("Square"),
        Tracer = Drawing.new("Line"),
        Name = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        HealthBarOutline = Drawing.new("Square"),
        HealthBar = Drawing.new("Square"),
    }
    
    -- Setting box
    local box = ESP[plr].Box
    box.Thickness = 2
    box.Filled = false
    box.Color = Color3.fromRGB(255, 255, 255)
    box.Transparency = 1
    box.Visible = false
    
    -- Tracer dari bawah layar
    local tracer = ESP[plr].Tracer
    tracer.Thickness = 2
    tracer.Color = Color3.fromRGB(255, 0, 255)
    tracer.Transparency = 1
    tracer.Visible = false
    
    -- Text nama + jarak
    local name = ESP[plr].Name
    name.Size = 16
    name.Center = true
    name.Outline = true
    name.Font = 2
    name.Color = Color3.fromRGB(255, 255, 255)
    name.Visible = false
    
    local dist = ESP[plr].Distance
    dist.Size = 14
    dist.Center = true
    dist.Outline = true
    dist.Font = 2
    dist.Color = Color3.fromRGB(0, 255, 255)
    dist.Visible = false
    
    -- Health bar
    local hbOutline = ESP[plr].HealthBarOutline
    hbOutline.Thickness = 3
    hbOutline.Filled = false
    hbOutline.Color = Color3.new(0,0,0)
    hbOutline.Visible = false
    
    local hb = ESP[plr].HealthBar
    hb.Thickness = 1
    hb.Filled = true
    hb.Color = Color3.fromRGB(0, 255, 0)
    hb.Visible = false
end

-- Update tiap frame
local function UpdateESP()
    if not getgenv().FullESP then return end
    
    for plr, drawings in pairs(ESP) do
        local char = plr.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        
        if char and hum and root and head and hum.Health > 0 then
            local pos, onScreen = cam:WorldToViewportPoint(root.Position)
            local headPos = cam:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))
            local legPos = cam:WorldToViewportPoint(root.Position - Vector3.new(0,3.5,0))
            local dist = (root.Position - Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            
            if onScreen then
                -- Box 3D
                local size = Vector2.new(1000 / pos.Z, 1600 / pos.Z) * 2
                drawings.Box.Size = size
                drawings.Box.Position = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
                drawings.Box.Visible = true
                
                -- Tracer
                drawings.Tracer.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                drawings.Tracer.To = Vector2.new(pos.X, pos.Y + size.Y/2)
                drawings.Tracer.Visible = true
                
                -- Nama
                drawings.Name.Text = plr.DisplayName
                drawings.Name.Position = Vector2.new(pos.X, headPos.Y - 25)
                drawings.Name.Visible = true
                
                -- Jarak
                drawings.Distance.Text = math.floor(dist) .. " studs"
                drawings.Distance.Position = Vector2.new(pos.X, headPos.Y - 5)
                drawings.Distance.Visible = true
                
                -- Health bar
                local healthPct = hum.Health / hum.MaxHealth
                drawings.HealthBarOutline.Size = Vector2.new(4, size.Y + 4)
                drawings.HealthBarOutline.Position = drawings.Box.Position - Vector2.new(6, -2)
                drawings.HealthBarOutline.Visible = true
                
                drawings.HealthBar.Size = Vector2.new(4, size.Y * healthPct + 4)
                drawings.HealthBar.Position = drawings.HealthBarOutline.Position + Vector2.new(0, size.Y*(1-healthPct))
                drawings.HealthBar.Color = Color3.fromHSV(healthPct/3, 1, 1)
                drawings.HealthBar.Visible = true
                
            else
                for _, v in pairs(drawings) do
                    v.Visible = false
                end
            end
        else
            for _, v in pairs(drawings) do
                v.Visible = false
            end
        end
    end
end

-- Player masuk
Players.PlayerAdded:Connect(function(plr)
    if getgenv().FullESP then
        plr.CharacterAdded:Wait()
        task.wait(1)
        AddPlayerESP(plr)
    end
end)

-- Player keluar
Players.PlayerRemoving:Connect(function(plr)
    if ESP[plr] then
        for _, drawing in pairs(ESP[plr]) do
            drawing:Remove()
        end
        ESP[plr] = nil
    end
end)

-- Start ESP
function StartFullESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer and plr.Character then
            AddPlayerESP(plr)
        end
    end
    
    RunService:BindToRenderStep("FullESPUpdate", Enum.RenderPriority.Camera.Value + 1, UpdateESP)
end

-- Clear semua
function ClearFullESP()
    RunService:UnbindFromRenderStep("FullESPUpdate")
    for _, drawings in pairs(ESP) do
        for _, drawing in pairs(drawings) do
            drawing:Remove()
        end
    end
    ESP = {}
end

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

--====================================================--
--============   TELEPORT TO PLAYER DROPDOWN  =========--
--====================================================--

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Ambil daftar player selain kita
local function GetPlayerList()
    local list = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(list, plr.Name)
        end
    end
    return list
end

-- Create Dropdown
local TpDropdown = Tab:Dropdown({
    Title = "Teleport To Player",
    Desc = "Select player to teleport|use this if game have low anti cheat",
    Values = GetPlayerList(),
    Default = nil, -- tidak pre-select
    Multi = false,
    AllowNone = false,
    Callback = function(selectedName)
        if not selectedName then
            WindUI:Notify({
                Title = "Error",
                Content = "No player selected!",
                Duration = 3,
                Icon = "alert-triangle"
            })
            return
        end

        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = Character:WaitForChild("HumanoidRootPart")

        local target = Players:FindFirstChild(selectedName)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local tHRP = target.Character.HumanoidRootPart

            -- anti stuck teleport
            HRP.CFrame = tHRP.CFrame * CFrame.new(0, 5, 0)

            WindUI:Notify({
                Title = "Teleported!",
                Content = "You teleported to: " .. target.Name,
                Duration = 4,
                Icon = "zap"
            })
        else
            WindUI:Notify({
                Title = "Failed",
                Content = "Target player invalid or no character.",
                Duration = 4,
                Icon = "x"
            })
        end
    end
})

--====================================================--
--============   AUTO REFRESH PLAYER LIST  ===========--
--====================================================--

-- Refresh dropdown saat ada player join
Players.PlayerAdded:Connect(function()
    TpDropdown:SetValues(GetPlayerList())
end)

-- Refresh dropdown saat ada player keluar
Players.PlayerRemoving:Connect(function()
    TpDropdown:SetValues(GetPlayerList())
end)

--====================================================--
--==============  TWEEN TO PLAYER DROPDOWN  ===========--
--====================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- Ambil daftar player kecuali kita
local function GetPlayerList()
    local list = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(list, plr.Name)
        end
    end
    return list
end

-- CREATE DROPDOWN
local TweenDropdown = Tab:Dropdown({
    Title = "Tween To Player",
    Desc = "Move smoothly to selected player | SAVE VERSION",
    Values = GetPlayerList(),
    Default = nil,
    Multi = false,
    AllowNone = false,
    Callback = function(selectedName)

        if not selectedName then
            WindUI:Notify({
                Title = "Error",
                Content = "No player selected!",
                Duration = 3,
                Icon = "x"
            })
            return
        end

        -- CARI TARGET PLAYER
        local targetPlayer = Players:FindFirstChild(selectedName)
        if not targetPlayer 
        or not targetPlayer.Character 
        or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then

            WindUI:Notify({
                Title = "Player Not Found",
                Content = "Player belum spawn atau invalid",
                Duration = 4,
                Icon = "x"
            })
            return
        end

        local myChar = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local myRoot = myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return end

        local targetHRP = targetPlayer.Character.HumanoidRootPart

        -- posisi aman 5 stud di atas
        local targetPos = targetHRP.Position + Vector3.new(0, 5, 0)
        local distance = (myRoot.Position - targetPos).Magnitude

        -- SEMAKIN JAUH → tween time otomatis naik
        local tweenTime = distance / 120

        local tweenInfo = TweenInfo.new(
            tweenTime,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )

        local tween = TweenService:Create(
            myRoot,
            tweenInfo,
            { CFrame = CFrame.new(targetPos) }
        )

        -- anti jatuh / anti glitch
        myRoot.Anchored = true
        tween:Play()

        tween.Completed:Connect(function()
            myRoot.Anchored = false
            myRoot.CFrame = CFrame.new(targetPos)

            WindUI:Notify({
                Title = "Arrived!",
                Content = "Smooth tween to: " .. targetPlayer.DisplayName,
                Duration = 4,
                Icon = "zap"
            })
        end)
    end
})

--====================================================--
--==============  AUTO REFRESH PLAYER LIST  ===========--
--====================================================--

Players.PlayerAdded:Connect(function()
    TweenDropdown:SetValues(GetPlayerList())
end)

Players.PlayerRemoving:Connect(function()
    TweenDropdown:SetValues(GetPlayerList())
end)


local Button = Tab:Button({
    Title = "PSHADE | SHADERS",
    Desc = "Apply high quality BSL-like shaders (PShade)",
    Locked = false,
    Callback = function()
        -- Cek dulu biar ga double load
        if getgenv().PShadeLoaded then
            WindUI:Notify({
                Title = "PShade Shaders",
                Content = "Shaders udah di-load sebelumnya!",
                Duration = 4
            })
            return
        end

        -- Nama shader yang mau dipake (ganti sesuka hati)
        getgenv().RTX_Name = "Midday lite"  -- ← ganti di sini aja kalo mau yang lain

        -- Load scriptnya
        loadstring(game:HttpGet('https://pastefy.app/xXkUxA0P/raw', true))()

        -- Tanda biar ga double load lagi
        getgenv().PShadeLoaded = true

        -- Notif sukses
        WindUI:Notify({
            Title = "PShade Shaders",
            Content = "Shaders "..getgenv().RTX_Name.." berhasil di-load! ✨",
            Duration = 6
        })
    end
})

local Button = Tab:Button({
    Title = "FPS BOOSTER",
    Desc = "Low Graphics + No Texture/Fog/Effects + FPS Unlock",
    Locked = false,
    Callback = function()
        print("FPS BOOST v3 STARTED!")  -- Debug: Cek F9 sekarang ada print!

        local Lighting = game:GetService("Lighting")
        local Workspace = game:GetService("Workspace")
        local RunService = game:GetService("RunService")
        local StarterGui = game:GetService("StarterGui")
        local UserSettings = settings()

        -- 1. LOWEST GRAPHICS (CORRECT API 2025)
        pcall(function()
            UserSettings.Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)
        print("QualityLevel set to Level01")

        -- 2. OPTIMIZE LIGHTING + NO FOG + COMPATIBILITY (BIG FPS BOOST)
        Lighting.GlobalShadows = false
        Lighting.FogEnd = math.huge
        Lighting.FogStart = math.huge
        Lighting.Brightness = 2
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.ReflectionQuality = Enum.ReflectionQuality.NoReflection
        Lighting.Technology = Enum.Technology.Compatibility  -- SUPER IMPORTANT!
        Lighting.ClockTime = 14
        if Lighting:FindFirstChild("Atmosphere") then
            Lighting.Atmosphere.Enabled = false
        end
        print("Lighting optimized + No Fog")

        -- 3. DISABLE POST EFFECTS
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then
                v.Enabled = false
            end
        end

        -- 4. CLEAR TEXTURES & SHADOWS (ASYNC NO LAG)
        local function clearTextures()
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.Plastic
                    v.CastShadow = false
                    v.Reflectance = 0
                    -- Hide all decals/textures on part
                    for _, child in pairs(v:GetChildren()) do
                        if child:IsA("Decal") or child:IsA("Texture") then
                            child.Transparency = 1
                        end
                    end
                end
                if v:IsA("MeshPart") then
                    v.TextureID = ""
                    v.CastShadow = false
                    v.Material = Enum.Material.Plastic
                end
            end
            print("Textures cleared!")
        end
        task.spawn(clearTextures)

        -- 5. DISABLE EFFECTS (PARTICLES, FIRE, ETC)
        local function disableEffects()
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") 
                or v:IsA("Sparkles") or v:IsA("Beam") or v:IsA("Light") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
                    v.Enabled = false
                end
            end
            print("Effects disabled!")
        end
        task.spawn(disableEffects)

        -- 6. FPS UNLOCK + FAST FLAGS (Kalo executor support)
        pcall(setfpscap, 999)
        pcall(function()
            setfflag("DFIntTaskSchedulerTargetFps", "999")
            setfflag("FFlagHandleAltEnterFullscreenManually", "True")
        end)
        print("FPS unlocked!")

        -- 7. CONTINUOUS OPTIMIZE (PERMANEN)
        task.spawn(function()
            while true do
                task.wait(0.5)
                pcall(function()
                    UserSettings.Rendering.QualityLevel = Enum.QualityLevel.Level01
                    Lighting.GlobalShadows = false
                    Lighting.FogEnd = math.huge
                    Lighting.Technology = Enum.Technology.Compatibility
                end)
            end
        end)

        -- 8. AUTO NEW OBJECTS
        Workspace.DescendantAdded:Connect(function(desc)
            task.wait(0.05)
            if desc:IsA("BasePart") or desc:IsA("MeshPart") then
                desc.Material = Enum.Material.Plastic
                desc.CastShadow = false
                desc.Reflectance = 0
                if desc:IsA("MeshPart") then desc.TextureID = "" end
                for _, child in pairs(desc:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") then
                        child.Transparency = 1
                    end
                end
            elseif desc:IsA("ParticleEmitter") or desc:IsA("Fire") or desc:IsA("Smoke") or desc:IsA("Light") then
                desc.Enabled = false
            end
        end)

        -- MEMORY CLEAN
        collectgarbage("collect")

        StarterGui:SetCore("SendNotification", {
            Title = "FPS BOOST v3 AKTIF 🔥";
            Text = "Texture/Fog/Shadows hilang! Graphics Level01 + Compatibility Lighting. Cek F9 ada print & FPS naik! (Kalo ga naik, install Bloxstrap)";
            Duration = 8;
        })
        print("FPS BOOST v3 LOADED FULLY!")
    end
})

local Tab = Window:Tab({
    Title = "GAMES|Scripts",
    Icon = "gamepad-2", -- optional
    Locked = false,
})

local Button = Tab:Button({
    Title = "Saber Simulator - Easy Scripts",
    Desc = "Auto Farm, Auto Sell, Auto Rebirth | discord.gg/nQ5pCft2Ve",
    Icon = "swords",
    Locked = false,
    Callback = function()
        -- Anti double execute (biar ga error kalau pencet berkali-kali)
        if getgenv().SaberEasyScriptLoaded then
            print("Saber Simulator script udah jalan bro!")
            return
        end
        
        getgenv().SaberEasyScriptLoaded = true
        
        -- Jalankan scriptnya
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JustKondzio0010/sybersimulator/refs/heads/main/EasyScripts"))()
        
        print("Saber Simulator - Easy Scripts berhasil dijalankan!")
    end
})

local Button = Tab:Button({
    Title = "Quantum Onyx |BLOX FRUITS SCRIPT",
    Desc = "BLOX FRUITS SCRIPT",
    Icon = "zap",           -- atau "diamond" / "crown" biar lebih keren
    Locked = false,
    Callback = function()
        -- Anti dobel execute (biar ga error / lag kalau pencet berkali-kali)
        if getgenv().QuantumOnyxLoaded then
            WindUI:Notify({
                Title = "Quantum Onyx",
                Content = "Script udah jalan bro! Jangan pencet lagi",
                Duration = 4
            })
            return
        end

        getgenv().QuantumOnyxLoaded = true

        -- Notify loading (keliatan pro)
        WindUI:Notify({
            Title = "Quantum Onyx",
            Content = "Loading the beast...",
            Duration = 6,
            Icon = "zap"
        })

        -- Execute scriptnya
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Trustmenotcondom/QTONYX/refs/heads/main/QuantumOnyx.lua"))()

        -- Notify sukses
        task.wait(2)
        WindUI:Notify({
            Title = "Quantum Onyx",
            Content = "Successfully injected! Have fun god mode",
            Duration = 5,
            Icon = "crown"
        })
    end
})

local Button = Tab:Button({
    Title = "Chloe-X Hub|FISH IT",
    Desc = "FISH IT",
    Icon = "fish",
    Locked = false,
    Callback = function()
        -- Anti dobel execute
        if getgenv().ChloeXLoaded then
            WindUI:Notify({
                Title = "Chloe-X",
                Content = "Script udah jalan bro! Jangan pencet lagi",
                Duration = 4
            })
            return
        end

        getgenv().ChloeXLoaded = true

        -- Loading notify
        WindUI:Notify({
            Title = "Chloe-X",
            Content = "Loading script",
            Duration = 6,
            Icon = "fish"
        })

        -- Execute Chloe-X
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MajestySkie/Chloe-X/main/Main/ChloeX"))()

        -- Sukses notify
        task.wait(2)
        WindUI:Notify({
            Title = "Chloe-X Loaded!",
            Content = "Hub siap digunakan! God mode activated",
            Duration = 5,
            Icon = "crown"
        })
    end
})

local Button = Tab:Button({
    Title = "🚀 MM2 Vehub Auto Farm",
    Desc = "Best MM2 2025 - Auto Farm",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/udyrpizza4-lgtm/Vehub/refs/heads/main/MurderMystery2"))()
    end
})

-- Blade ball ArgonHub Loader
local Button = Tab:Button({
    Title = "ArgonX|blade ball",
    Desc = "Blade Ball",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MM2Devs/MM2Script/main/loader.lua"))()
    end
})

-- Fisch RaitoHub
local Button = Tab:Button({
    Title = "🎣 Fisch RaitoHub",
    Desc = "Auto Fish, Infinite, Event Farm ",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Efe0626/RaitoHub/main/Script"))()
    end
})

-- Blox Fruits BlueX Hub
local Button = Tab:Button({
    Title = "Blox Fruits BlueX Hub",
    Desc = "Auto Farm, Full Hub",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"))()
    end
})

-- Blox Fruits Gravity Hub
local Button = Tab:Button({
    Title = "🌟 Blox Fruits Gravity Hub",
    Desc = "AUTO FARM",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua"))()
    end
})

local Button = Tab:Button({
    Title = "Chiyo Hub | The Forge",
    Desc = "Auto Farm • Auto Forge • Teleport • No Key (Stress Test)",
    Icon = "hammer",        -- optional icon
    Locked = false,
    Callback = function()
        -- Anti doble execute
        if getgenv().ChiyoLoaded then
            WindUI:Notify({
                Title = "Already Loaded!",
                Content = "Chiyo Hub udah jalan bro, jangan spam!",
                Duration = 4,
                Icon = "alert-triangle"
            })
            return
        end
        getgenv().ChiyoLoaded = true

        -- Loading notif
        WindUI:Notify({
            Title = "Loading Chiyo Hub",
            Content = "Sedang fetch script The Forge...",
            Duration = 4,
            Icon = "zap"
        })

        -- Execute script
        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Forge-STRESS-TEST-Chiyo-60832"))()

        -- Success notif (jeda biar load dulu)
        task.wait(2)
        WindUI:Notify({
            Title = "✅ Chiyo Hub Loaded!",
            Content = "Auto Farm & Forge aktif! Use ALT ACC only ⚠️",
            Duration = 6,
            Icon = "hammer"
        })
        
        print("Chiyo Hub executed - The Forge Stress Test by Chiyo")
    end
})

local Button = Tab:Button({
    Title = "Voidware | 99 Nights in the Forest",
    Desc = "Auto Farm • Kill Aura • ESP • Teleport • No Key",
    Icon = "tree",          -- optional icon hutan
    Locked = false,
    Callback = function()
        -- Anti doble execute
        if getgenv().VoidwareNITF then
            WindUI:Notify({
                Title = "Already Loaded!",
                Content = "Voidware Nights udah jalan, jangan spam!",
                Duration = 4,
                Icon = "alert-triangle"
            })
            return
        end
        getgenv().VoidwareNITF = true

        -- Loading notif
        WindUI:Notify({
            Title = "Loading Voidware Nights",
            Content = "Sedang fetch script survival horror...",
            Duration = 4,
            Icon = "zap"
        })

        -- Execute loader script
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()

        -- Success notif (jeda biar load dulu)
        task.wait(2)
        WindUI:Notify({
            Title = "✅ Voidware Loaded!",
            Content = "Auto Farm & ESP aktif! Dominate hutan malam ini ⚠️ ALT ACC ONLY",
            Duration = 6,
            Icon = "tree"
        })
        
        print("Voidware Nights in the Forest executed - Auto Survive by VapeVoidware")
    end
})

local Button = Tab:Button({
    Title = "Guesting HUB | Forsaken",
    Desc = "AutoBlock • AutoParry • ESP • Aimbot • No Key (Guesting)",
    Icon = "shield",        -- icon block/parry
    Locked = false,
    Callback = function()
        -- Anti doble execute
        if getgenv().G666Loaded then
            WindUI:Notify({
                Title = "Already Loaded!",
                Content = "G666 Forsaken udah jalan, jangan spam!",
                Duration = 4,
                Icon = "alert-triangle"
            })
            return
        end
        getgenv().G666Loaded = true

        -- Loading notif
        WindUI:Notify({
            Title = "Loading G666 Hub",
            Content = "Sedang fetch AutoBlock & Aimbot Forsaken...",
            Duration = 4,
            Icon = "zap"
        })

        -- Execute script
        loadstring(game:HttpGet("https://rawscripts.net/raw/G666-Forsaken-Guesting-Hub-AutoBlock-Esp-aimbot-and-more-63558"))()

        -- Success notif (jeda biar load dulu)
        task.wait(2)
        WindUI:Notify({
            Title = "✅ G666 Hub Loaded!",
            Content = "AutoBlock + ESP aktif! Dominate sebagai Guest/Killer ⚠️ ALT ACC ONLY",
            Duration = 6,
            Icon = "shield"
        })
        
        print("G666 Forsaken Guesting Hub executed - AutoBlock/ESP/Aimbot")
    end
})

local Button = Tab:Button({
    Title = "Lunor Hub | Multi-Game",
    Desc = "Auto Farm • Dupe • ESP • Fisch/Forge/Garden/Dead Rails • No Key",
    Icon = "compass",       -- icon multi-game
    Locked = false,
    Callback = function()
        -- Anti doble execute
        if getgenv().LunorLoaded then
            WindUI:Notify({
                Title = "Already Loaded!",
                Content = "Lunor Hub udah jalan, jangan spam!",
                Duration = 4,
                Icon = "alert-triangle"
            })
            return
        end
        getgenv().LunorLoaded = true

        -- Loading notif
        WindUI:Notify({
            Title = "Loading Lunor Hub",
            Content = "Sedang fetch multi-game loader...",
            Duration = 4,
            Icon = "zap"
        })

        -- Execute loader
        loadstring(game:HttpGet("https://lunor.dev/loader"))()

        -- Success notif (jeda biar load & detect game)
        task.wait(3)
        WindUI:Notify({
            Title = "✅ Lunor Hub Loaded!",
            Content = "Auto features aktif otomatis! Support Fisch/Forge/Garden dll ⚠️ ALT ACC ONLY",
            Duration = 6,
            Icon = "compass"
        })
        
        print("Lunor Hub Loader executed - Multi-game auto farm by Lunor")
    end
})

local Button = Tab:Button({
    Title = "Chilli Hub | Steal a Brainrot",
    Desc = "Instant Steal • Auto Farm/Lock • ESP/Aimbot • Fly • No Key",
    Icon = "zap",           -- icon steal cepet
    Locked = false,
    Callback = function()
        -- Anti doble execute
        if getgenv().ChilliLoaded then
            WindUI:Notify({
                Title = "Already Loaded!",
                Content = "Chilli Hub udah jalan, jangan spam!",
                Duration = 4,
                Icon = "alert-triangle"
            })
            return
        end
        getgenv().ChilliLoaded = true

        -- Loading notif
        WindUI:Notify({
            Title = "Loading Chilli Hub",
            Content = "Sedang fetch stealer Brainrot OP...",
            Duration = 4,
            Icon = "zap"
        })

        -- Execute obfuscated script
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()

        -- Success notif (jeda biar load GUI)
        task.wait(2)
        WindUI:Notify({
            Title = "✅ Chilli Hub Loaded!",
            Content = "Steal semua brainrot instan! Auto lock base aktif ⚠️ ALT ACC ONLY",
            Duration = 6,
            Icon = "package"
        })
        
        print("Chilli Hub Steal a Brainrot executed - Instant Steal by tienkhanh1")
    end
})

local Button = Tab:Button({
    Title = "V0ID Hub | Evade (Beta)",
    Desc = "Auto Farm • ESP • Fly • Obfuscated No Key",
    Icon = "zap",           -- icon cepet dodge
    Locked = false,
    Callback = function()
        -- Anti doble execute
        if getgenv().V0IDLoaded then
            WindUI:Notify({
                Title = "Already Loaded!",
                Content = "V0ID Evade udah jalan, jangan spam!",
                Duration = 4,
                Icon = "alert-triangle"
            })
            return
        end
        getgenv().V0IDLoaded = true

        -- Loading notif
        WindUI:Notify({
            Title = "Loading V0ID Hub",
            Content = "Sedang fetch beta obfuscated Evade...",
            Duration = 4,
            Icon = "zap"
        })

        -- Execute obfuscated script
        loadstring(game:HttpGet('https://raw.githubusercontent.com/RequideSync/V0ID/refs/heads/main/L0L/Evade.lua'))()

        -- Success notif (jeda biar load)
        task.wait(2)
        WindUI:Notify({
            Title = "✅ V0ID Hub Loaded!",
            Content = "Cheats aktif! Dodge endless waves ⚠️ ALT ACC ONLY",
            Duration = 6,
            Icon = "running"
        })
        
        print("V0ID Evade Hub executed - Beta by RequideSync")
    end
})

local Button = Tab:Button({
    Title = "OMG HUB | Bluelock & Blox Fruits",
    Desc = "Universal OP Script • KEYS",
    Icon = "flame", -- ikon api biar gokil
    Locked = false,
    Callback = function()
        -- Anti double execute
        if getgenv().OmgHubLoaded then
            WindUI:Notify({
                Title = "OMG Hub",
                Content = "Script udah jalan bro! Jangan spam klik",
                Duration = 5,
                Icon = "alert-triangle"
            })
            return
        end

        getgenv().OmgHubLoaded = true

        -- Notif loading aesthetic
        WindUI:Notify({
            Title = "OMG HUB",
            Content = "Sedang inject script gila ini... sabar ya king",
            Duration = 6,
            Icon = "zap"
        })

        -- Execute dengan pcall biar aman
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
        end)

        task.wait(2)

        if success then
            WindUI:Notify({
                Title = "OMG HUB SUCCESSFULLY LOADED",
                Content = "Buka menu pake INSERT • Selamat mendominasi server!",
                Duration = 8,
                Icon = "crown"
            })
        else
            WindUI:Notify({
                Title = "Gagal Inject OMG Hub",
                Content = "Script mati / link berubah / executor blokir\nCoba lagi nanti ya bro",
                Duration = 10,
                Icon = "x"
            })
            getgenv().OmgHubLoaded = false -- reset biar bisa coba lagi
        end
    end
})

local Button = Tab:Button({
    Title = "Inject Speed Hub X|GROW A GARDEN",
    Desc = "Load Speed Hub X (Universal + Undetected 2025)",
    Locked = false,
    Callback = function()
        -- Notif mulai loading
        WindUI:Notify({
            Title = "Speed Hub X",
            Content = "Sedang inject script... sabar ya bro",
            Duration = 5,
            Icon = "zap"
        })

        -- Execute dengan pcall biar ga error crash
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
        end)

        task.wait(1.5)

        if success then
            WindUI:Notify({
                Title = "Speed Hub X Injected!",
                Content = "Script berhasil di-load! Buka menu pake Insert",
                Duration = 8,
                Icon = "rocket"
            })
        else
            WindUI:Notify({
                Title = "Gagal Inject Speed Hub X",
                Content = "Error: Script mati / diblokir / link berubah\nCoba lagi nanti ya bro",
                Duration = 10,
                Icon = "alert-triangle"
            })
        end
    end
})

local Button = Tab:Button({
    Title = "ZE3S HUB",
    Desc = "Best Universal Script (top)",
    Locked = false,
    Callback = function()
        WindUI:Notify({
            Title = "ZYPHERION",
            Content = "Sedang inject script gila ini... tunggu bentar bro",
            Duration = 6,
            Icon = "zap"
        })

        local success, err = pcall(function()
            loadstring(game:HttpGet(('https://raw.githubusercontent.com/blackowl1231/ZYPHERION/refs/heads/main/main.lua')))()
        end)

        task.wait(2)

        if success then
            WindUI:Notify({
                Title = "ZE3S LOADED",
                Content = "Script berhasil masuk! Buka menu pake RightShift",
                Duration = 8,
                Icon = "crown"
            })
        else
            WindUI:Notify({
                Title = "FAILED INJECT",
                Content = "Error: "..tostring(err).."\nLink mati / script di-update / executor blokir",
                Duration = 10,
                Icon = "x"
            })
        end
    end
})

local Tab = Window:Tab({
    Title = "COMBAT",
    Icon = "crosshair", -- optional
    Locked = false,
})

local Toggle = Tab:Toggle({
    Title = "Head Lock Aimbot",
    Desc = "Smooth + Max 120 studs + Visible Check + Prediction",
    Icon = "crosshair",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        getgenv().HeadLock = state

        if state then
            print("HEADLOCK ON - Max 120 studs only bro")

            spawn(function()
                while task.wait() and getgenv().HeadLock do
                    local closest = nil
                    local shortest = math.huge
                    local cam = workspace.CurrentCamera
                    local myRoot = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not myRoot then continue end

                    for _, plr in ipairs(game.Players:GetPlayers()) do
                        if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                            if not plr.Team or plr.Team ~= game.Players.LocalPlayer.Team then
                                local head = plr.Character.Head
                                local distance3D = (head.Position - myRoot.Position).Magnitude

                                -- BATAS MAKSIMAL 120 STUDS (bisa lu ubah)
                                if distance3D <= 120 then
                                    -- Visible check biar ga nembak lewat tembok
                                    local ray = workspace:Raycast(myRoot.Position + Vector3.new(0, 3, 0), head.Position - myRoot.Position + Vector3.new(0, 3, 0))
                                    if not ray or ray.Instance and ray.Instance:FindFirstAncestor(plr.Name) then
                                        local predictPos = head.Position + head.Velocity * 0.135
                                        local screenPos, onScreen = cam:WorldToViewportPoint(predictPos)

                                        if onScreen then
                                            local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - cam.ViewportSize/2).Magnitude
                                            if screenDist < shortest and screenDist < 380 then  -- FOV visual
                                                shortest = screenDist
                                                closest = predictPos
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    if closest then
                        cam.CFrame = cam.CFrame:Lerp(CFrame.lookAt(cam.CFrame.Position, closest), 0.24)
                    end
                end
            end)

        else
            print("Headlock OFF")
        end
    end
})

local Toggle = Tab:Toggle({
    Title = "Silent Aim",
    Desc = "Peluru otomatis ke kepala (gak keliatan gerak)",
    Icon = "target",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        getgenv().SilentAim = state
        if state then
            print("Silent Aim NYALA 🔥")
            local mt = getrawmetatable(game)
            local oldNamecall = mt.__namecall
            setreadonly(mt, false)

            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}

                if method == "FindPartOnRayWithIgnoreList" or method == "Raycast" then
                    if getgenv().SilentAim and game.Players.LocalPlayer.Character then
                        local closest = nil
                        local dist = math.huge
                        for _, plr in ipairs(game.Players:GetPlayers()) do
                            if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character.Humanoid.Health > 0 then
                                if not plr.Team or plr.Team ~= game.Players.LocalPlayer.Team then
                                    local head = plr.Character.Head
                                    local d = (head.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                    if d < dist and d < 300 then
                                        dist = d
                                        closest = head
                                    end
                                end
                            end
                        end
                        if closest then
                            args[2] = Ray.new(args[2].Origin, (closest.Position - args[2].Origin).Unit * 1000)
                            return oldNamecall(self, unpack(args))
                        end
                    end
                end
                return oldNamecall(self, ...)
            end)
            setreadonly(mt, true)
        end
    end
})


Window:EditOpenButton({
    Title = "Open Example UI",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

--   FPS Tag (auto-updating)
local FPSTag = Window:Tag({
    Title = "FPS: 0",
    Icon = "gauge",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 5,
})

--  FPS Counter System
task.spawn(function()
    local RunService = game:GetService("RunService")
    local LastTick = tick()
    local Frames = 0

    RunService.RenderStepped:Connect(function()
        Frames += 1

        if tick() - LastTick >= 1 then
            local FPS = Frames
            Frames = 0
            LastTick = tick()

            FPSTag:SetTitle("FPS: " .. FPS)
        end
    end)
end)

WindUI:AddTheme({
    Name = "Dark Void Purple", -- nama theme

    Accent = Color3.fromHex("#8b5cf6"),        -- ungu tua cantik (violet/purple accent)
    Background = Color3.fromHex("#0c0a1a"),     -- hampir hitam dengan hint biru-ungu
    BackgroundTransparency = 0,
    Outline = Color3.fromHex("#2d1b69"),        -- outline ungu gelap biar lebih nyatu
    Text = Color3.fromHex("#e2e8f0"),           -- putih soft (bukan putih mentah biar ga silau)
    Placeholder = Color3.fromHex("#64748b"),
    Button = Color3.fromHex("#1e1a3d"),         -- tombol gelap dengan hint ungu
    Icon = Color3.fromHex("#a78bfa"),

    Hover = Color3.fromHex("#c4b5fd"),          -- hover jadi ungu muda soft
    HoverTransparency = 0.9,                   -- optional: sedikit transparan saat hover

    -- Window
    WindowBackground = Color3.fromHex("#0f0b1f"),
    WindowShadow = Color3.fromHex("#000000"),

    -- Dialog & Popup
    DialogBackground = Color3.fromHex("#0f0b1f"),
    DialogBackgroundTransparency = 0,
    DialogTitle = Color3.fromHex("#e2e8f0"),
    DialogContent = Color3.fromHex("#cbd5e1"),
    DialogIcon = Color3.fromHex("#a78bfa"),

    -- Topbar
    WindowTopbarButtonIcon = Color3.fromHex("#a78bfa"),
    WindowTopbarTitle = Color3.fromHex("#e2e8f0"),
    WindowTopbarAuthor = Color3.fromHex("#94a3b8"),
    WindowTopbarIcon = Color3.fromHex("#c4b5fd"),

    -- Tabs
    TabBackground = Color3.fromHex("#1e1a3d"),
    TabTitle = Color3.fromHex("#e2e8f0"),
    TabIcon = Color3.fromHex("#a78bfa"),

    -- Elements
    ElementBackground = Color3.fromHex("#1e1a3d"),
    ElementTitle = Color3.fromHex("#e2e8f0"),
    ElementDesc = Color3.fromHex("#94a3b8"),
    ElementIcon = Color3.fromHex("#a78bfa"),

    -- Popup
    PopupBackground = Color3.fromHex("#0f0b1f"),
    PopupBackgroundTransparency = 0,
    PopupTitle = Color3.fromHex("#e2e8f0"),
    PopupContent = Color3.fromHex("#cbd5e1"),
    PopupIcon = Color3.fromHex("#a78bfa"),
})
WindUI:SetTheme("Dark Void Purple")  -- set theme ke yang baru dibuat

local Tab = Window:Tab({
    Title = "FUN STUFF",
    Icon = "laugh", -- optional
    Locked = false,
})

local Button = Tab:Button({
    Title = "GHOST HUB | Universal",
    Desc = "Best Troll Hub",
    Locked = false,
    Callback = function()
        -- Notif biar keren sebelum load
        WindUI:Notify({
            Title = "Loading Ghost Hub",
            Content = "Tunggu bentar, lagi nyedot script troll...",
            Duration = 4,
            Icon = "zap"
        })

        -- Execute script Ghost Hub
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub'))()

        -- Notif setelah berhasil load
        task.wait(2)  -- kasih jeda biar pasti ke-load dulu
        WindUI:Notify({
            Title = "Ghost Hub Loaded!",
            Content = "Selamat nge-troll semua server! Use with alt!",
            Duration = 6,
            Icon = "skull"
        })
    end
})

-- 1. BTOOLS (F3 = DELETE APA AJA)
Tab:Button({
    Title = "Btools Destroyer",
    Desc = "F3 = Hapus apa aja yang diklik | Tool di backpack",
    Locked = false,
    Callback = function()
        local backpack = game.Players.LocalPlayer.Backpack

        -- Kasih 4 tool klasik
        local tools = {
            ["Hammer"]   = "rbxassetid://18474461",  -- Delete
            ["Clone"]    = "rbxassetid://18474460",  -- Duplicate
            ["Grab"]     = "rbxassetid://18474459",  -- Move
            ["Resize"]   = "rbxassetid://18474462",  -- Resize
        }

        for name, id in pairs(tools) do
            local tool = Instance.new("Tool")
            tool.Name = name .. " Tool"
            tool.RequiresHandle = false
            tool.CanBeDropped = true
            tool.Parent = backpack
            
            tool.Activated:Connect(function()
                local mouse = game.Players.LocalPlayer:GetMouse()
                if mouse.Target and mouse.Target:IsA("BasePart") then
                    if name == "Hammer" then
                        mouse.Target:Destroy()
                    end
                end
            end)
        end

        -- F3 = Instant Delete (paling sering dipake)
        local UIS = game:GetService("UserInputService")
        UIS.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.F3 then
                local mouse = game.Players.LocalPlayer:GetMouse()
                if mouse.Target then
                    firetouchinterest(mouse.Target, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
                    mouse.Target:Destroy()
                end
            end
        end)

        WindUI:Notify({Title = "Btools ON", Content = "F3 = Delete | Tool di backpack", Duration = 6})
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

local Button = Tab:Button({
    Title = "REJOIN SERVER",
    Desc = "Otomatis masuk ulang ke server yang sama",
    Icon = "refresh-cw",
    Locked = false,
    Callback = function()
        -- Notify biar keren
        WindUI:Notify({
            Title = "Rejoin Server",
            Content = "Sedang masuk ulang ke server...",
            Duration = 4
        })
        
        -- Rejoin server yang sama (work 100% di semua executor)
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
        
        print("Rejoin server berhasil dijalankan!")
    end
})

local Button = Tab:Button({
    Title = "Copy JobId",
    Desc = "Copy server JobId ke clipboard (buat rejoin/server hop)",
    Icon = "copy",
    Locked = false,
    Callback = function()
        -- Copy JobId ke clipboard
        setclipboard(game.JobId)
        
        -- Notify biar keren
        WindUI:Notify({
            Title = "JobId Copied!",
            Content = "JobId: " .. game.JobId .. "\nSudah di-copy ke clipboard!",
            Duration = 6,
            Icon = "copy"
        })
        
        print("JobId berhasil di-copy: " .. game.JobId)
    end
})

local Input = Tab:Input({
    Title = "Join Server by JobId",
    Desc = "JOINING SERVER BY JOB ID",
    Value = "",
    InputIcon = "server",
    Placeholder = "Contoh: 4b8f9c2d1e5a7b9d0f1e3c5a7b9d0f1e",
    Type = "Input",
    Callback = function(jobid)
        -- Bersihin spasi / enter
        jobid = jobid:gsub("%s", "")
        
        if jobid == "" then
            WindUI:Notify({
                Title = "Error",
                Content = "job id is not detected",
                Duration = 4
            })
            return
        end

        -- Validasi JobId (harus 32 karakter hex)
        if not jobid:match("^[a-f0-9A-F]+$") or #jobid ~= 32 then
            WindUI:Notify({
                Title = "Invalid JobId",
                Content = "nil",
                Duration = 6
            })
            return
        end

        WindUI:Notify({
            Title = "Joining Server...",
            Content = "JobId: " .. jobid:sub(1,16) .. "...\nTunggu 5-10 detik",
            Duration = 8,
            Icon = "server"
        })

        -- JOIN SERVER PAKE JOBID (bypass + paling stabil)
        game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId,
            jobid,
            game.Players.LocalPlayer
        )
    end
})

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Button = Tab:Button({
    Title = "Serverhop | Low Player",
    Desc = "JOINING SERVER WITH LOW PLAYER COUNT",
    Locked = false,
    Callback = function()

        WindUI:Notify({
            Title = "Serverhop",
            Content = "Mengambil daftar server...",
            Duration = 3,
            Icon = "loader"
        })

        local placeId = game.PlaceId
        local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"

        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url))
        end)

        if not success then
            WindUI:Notify({
                Title = "Serverhop Error",
                Content = "Gagal mengambil data server!",
                Duration = 3,
                Icon = "alert-triangle"
            })
            return
        end

        local lowestServer = nil
        local lowestPlayers = math.huge

        for _, server in ipairs(result.data) do
            if server.playing < lowestPlayers and server.id ~= game.JobId then
                lowestPlayers = server.playing
                lowestServer = server.id
            end
        end

        if lowestServer then
            WindUI:Notify({
                Title = "Serverhop",
                Content = "Server ditemukan! Player: "..lowestPlayers.." — Joining...",
                Duration = 3,
                Icon = "check"
            })

            TeleportService:TeleportToPlaceInstance(placeId, lowestServer, LocalPlayer)
        else
            WindUI:Notify({
                Title = "Serverhop",
                Content = "Tidak menemukan server lain!",
                Duration = 3,
                Icon = "x"
            })
        end
    end
})


WindUI:Notify({
    Title = "nebulawarex SCRIPT HAS LOADED!",
    Content = "beta version do not share",
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

WindUI:Notify({
    Title = "NEBULAWARE X SCRIPT HAS LOADED!",
    Content = "JOIN DISCORD SERVER",
    Duration = 3, -- 3 seconds
    Icon = "door-open",
})

local Button = Tab:Button({
    Title = "EXECUTOR DETECTOR",
    Desc = "Detect PC & Mobile executor kamu pakai(gak terlalu akurat)",
    Icon = "search",
    Locked = false,
    Callback = function()
        local executor = "Unknown Executor"

        -- PC Executors
        if syn then executor = "Synapse X"
        elseif Krnl then executor = "Krnl"
        elseif Fluxus then executor = "Fluxus"
        elseif getexecutorname then executor = getexecutorname()
        elseif identifyexecutor then
            local name, ver = identifyexecutor()
            executor = name .. " v" .. ver
        elseif secure_load then executor = "Script-Ware"
        elseif is_sirhurt_injected then executor = "Sirhurt"
        elseif Solara then executor = "Solara Executor"
        elseif Xeno then executor = "Xeno Executor"
        elseif Velocity then executor = "Velocity Executor"
        elseif Bunni then executor = "Bunni Executor"
        elseif Codex then executor = "Codex"
        elseif JJsploit then executor = "JJSploit"
        elseif Valex then executor = "Valex Executor"
        elseif Volcano then executor = "Volcano Executor"

        -- Mobile Executors (Android/iOS)
        elseif Delta then executor = "Delta Executor Mobile"
        elseif Arceus then executor = "Arceus X"
        elseif Hydrogen then executor = "Hydrogen"
        elseif CodexMobile then executor = "Codex Mobile"
        elseif FluxusMobile then executor = "Fluxus Mobile"
        elseif KrnlMobile then executor = "Krnl Mobile"
        elseif getgc then executor = "Probably Mobile Executor (Arceus/Hydrogen)"

        else
            executor = "Executor Tidak Terdaftar / Custom"
        end

        -- Notif WindUI
        WindUI:Notify({
            Title = "Executor Detected!",
            Content = "Kamu lagi pake:\n" .. executor,
            Duration = 7,
            Icon = "cpu"
        })

        print("[Executor Detector] → " .. executor)
    end
})

if getgenv().NebulaWareX_Loaded then
    WindUI:Notify({
        Title = "Double Execute Detected!",
        Content = "NebulaWareX udah jalan bro!\nJangan execute 2x, bakal error semua!\n\nRejoin kalau mau reset",
        Duration = 8,
        Icon = "alert-triangle"
    })
    return
else
    getgenv().NebulaWareX_Loaded = true
end




--====================================================--
--===============     THEME DEFINITIONS    ===========--
--====================================================--

-- 1. Frutiger Aero
WindUI:AddTheme({
    Name = "FrutigerAero",
    Accent      = Color3.fromHex("#22e3ff"), 
    Background  = Color3.fromHex("#d9faff"),
    Outline     = Color3.fromHex("#0ba5c9"),
    Text        = Color3.fromHex("#003344"),
    Placeholder = Color3.fromHex("#7dd8e6"),
    Button      = Color3.fromHex("#57e3ff"),
    Icon        = Color3.fromHex("#0ea5c6"),
})

-- 2. Matrix Green
WindUI:AddTheme({
    Name = "MatrixGreen",
    Accent      = Color3.fromHex("#00ff41"),
    Background  = Color3.fromHex("#000000"),
    Outline     = Color3.fromHex("#005f22"),
    Text        = Color3.fromHex("#00ff41"),
    Placeholder = Color3.fromHex("#39ff88"),
    Button      = Color3.fromHex("#007f2a"),
    Icon        = Color3.fromHex("#00ff41"),
})

-- 3. Cyberpunk Neon
WindUI:AddTheme({
    Name = "CyberpunkNeon",
    Accent      = Color3.fromHex("#f72585"),
    Background  = Color3.fromHex("#1a0033"),
    Outline     = Color3.fromHex("#ffbe0b"),
    Text        = Color3.fromHex("#ffd6fe"),
    Placeholder = Color3.fromHex("#ff8fab"),
    Button      = Color3.fromHex("#ffbe0b"),
    Icon        = Color3.fromHex("#f72585"),
})

-- 4. Ice Blue
WindUI:AddTheme({
    Name = "IceBlue",
    Accent      = Color3.fromHex("#8ecaff"),
    Background  = Color3.fromHex("#e8f7ff"),
    Outline     = Color3.fromHex("#7bb7dd"),
    Text        = Color3.fromHex("#00344e"),
    Placeholder = Color3.fromHex("#a7d4f7"),
    Button      = Color3.fromHex("#bde6ff"),
    Icon        = Color3.fromHex("#61b8ff"),
})

-- 5. Midnight Purple
WindUI:AddTheme({
    Name = "MidnightPurple",
    Accent      = Color3.fromHex("#a855f7"),
    Background  = Color3.fromHex("#1a1029"),
    Outline     = Color3.fromHex("#6b21a8"),
    Text        = Color3.fromHex("#e9d5ff"),
    Placeholder = Color3.fromHex("#c084fc"),
    Button      = Color3.fromHex("#7c3aed"),
    Icon        = Color3.fromHex("#c084fc"),
})

-- 6. Pastel Soft Pink
WindUI:AddTheme({
    Name = "SoftPink",
    Accent      = Color3.fromHex("#ffafcc"),
    Background  = Color3.fromHex("#ffe5f0"),
    Outline     = Color3.fromHex("#f4b6d6"),
    Text        = Color3.fromHex("#5c2b3b"),
    Placeholder = Color3.fromHex("#f7cfe3"),
    Button      = Color3.fromHex("#ffcade"),
    Icon        = Color3.fromHex("#ff8fbf"),
})

--====================================================--
--===============      DEFAULT THEME      ============--
--====================================================--

-- UBAH DI SINI JIKA MAU DEFAULT THEME LAIN


--====================================================--
--===============      WINDOW SETUP       ============--
--====================================================--



--====================================================--
--================   THEME DROPDOWN     ==============--
--====================================================--

local themeList = {
    "FrutigerAero",
    "MatrixGreen",
    "CyberpunkNeon",
    "IceBlue",
    "MidnightPurple",
    "SoftPink"
}

Tab:Dropdown({
    Title = "Select Theme",
    Desc = "Choose UI Theme",
    Values = themeList,
    Default = "FrutigerAero",
    Multi = false,
    Callback = function(theme)
        WindUI:SetTheme(theme)
        WindUI:Notify({
            Title = "Theme Applied",
            Content = "Theme changed to: " .. theme,
            Duration = 3,
            Icon = "palette",
        })
    end
})

