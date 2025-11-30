-- ZaporiumKeySystem.lua
-- Reusable key system library for Roblox
-- GitHub-ready, clean, customizable

local ZaporiumKeySystem = {}
ZaporiumKeySystem.__index = ZaporiumKeySystem

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local SAVE_FILE = "ZaporiumKey.txt"

--// Private: Save & Load
local function saveKey(key)
    local data = {key = key, savedAt = os.time()}
    pcall(function() writefile(SAVE_FILE, HttpService:JSONEncode(data)) end)
end

local function getSavedData()
    local success, content = pcall(readfile, SAVE_FILE)
    if not success then return nil end
    local ok, data = pcall(HttpService.JSONDecode, HttpService, content)
    if ok and data and data.key and data.savedAt then return data end
    return nil
end

--// Constructor
function ZaporiumKeySystem.new(config)
    local self = setmetatable({}, ZaporiumKeySystem)

    self.ValidKeys = config.Keys or {"Sub2ScriptZap"}  -- array of valid keys
    self.DurationHours = config.Duration or 24         -- customizable duration
    self.OnSuccess = config.OnSuccess or function() print("Key accepted!") end
    self.Title = config.Title or "ZAPORIUM"
    self.ShowCopyButton = config.ShowCopyButton ~= false -- true by default

    return self
end

--// Main function: Show the GUI and handle everything
function ZaporiumKeySystem:Show()
    if not isfile or not writefile then
        warn("[Zaporium] File functions not available (probably not in executor with FS)")
        self.OnSuccess()
        return
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ZaporiumTiny"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 260)
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
    Frame.BorderSizePixel = 0
    Frame.Active = true
    Frame.Draggable = true
    Frame.Parent = ScreenGui

    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)
    local Glow = Instance.new("UIStroke", Frame)
    Glow.Thickness = 2.5
    Glow.Color = Color3.fromRGB(0, 180, 255)
    Glow.Transparency = 0.5

    -- Close Button
    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 26, 0, 26)
    Close.Position = UDim2.new(1, -34, 0, 8)
    Close.BackgroundColor3 = Color3.fromRGB(255, 60, 80)
    Close.Text = "X"
    Close.TextColor3 = Color3.new(1,1,1)
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 18
    Close.Parent = Frame
    Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 8)
    Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -50, 0, 30)
    Title.Position = UDim2.new(0, 15, 0, 8)
    Title.BackgroundTransparency = 1
    Title.Text = self.Title
    Title.TextColor3 = Color3.fromRGB(0, 190, 255)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 22
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Frame

    -- Duration Label
    local DurationLabel = Instance.new("TextLabel")
    DurationLabel.Size = UDim2.new(1, -40, 0, 26)
    DurationLabel.Position = UDim2.new(0, 20, 0, 42)
    DurationLabel.BackgroundTransparency = 1
    DurationLabel.Text = "No key active"
    DurationLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    DurationLabel.Font = Enum.Font.GothamSemibold
    DurationLabel.TextSize = 15
    DurationLabel.TextXAlignment = Enum.TextXAlignment.Left
    DurationLabel.Parent = Frame

    -- Key Input
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(1, -40, 0, 36)
    KeyBox.Position = UDim2.new(0, 20, 0, 74)
    KeyBox.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
    KeyBox.PlaceholderText = "Enter key"
    KeyBox.Text = ""
    KeyBox.TextColor3 = Color3.new(1,1,1)
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.TextSize = 16
    KeyBox.Parent = Frame
    Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 8)

    -- Status
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, -40, 0, 20)
    Status.Position = UDim2.new(0, 20, 0, 118)
    Status.BackgroundTransparency = 1
    Status.Text = "Waiting..."
    Status.TextColor3 = Color3.fromRGB(180, 180, 180)
    Status.Font = Enum.Font.Gotham
    Status.TextSize = 14
    Status.Parent = Frame

    -- Buttons
    local Verify = Instance.new("TextButton")
    Verify.Size = UDim2.new(1, -40, 0, 38)
    Verify.Position = UDim2.new(0, 20, 0, 146)
    Verify.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    Verify.Text = "VERIFY"
    Verify.TextColor3 = Color3.new(1,1,1)
    Verify.Font = Enum.Font.GothamBold
    Verify.TextSize = 16
    Verify.Parent = Frame
    Instance.new("UICorner", Verify).CornerRadius = UDim.new(0, 8)

    local CopyKey = nil
    if self.ShowCopyButton then
        CopyKey = Instance.new("TextButton")
        CopyKey.Size = UDim2.new(1, -40, 0, 38)
        CopyKey.Position = UDim2.new(0, 20, 0, 192)
        CopyKey.BackgroundColor3 = Color3.fromRGB(0, 130, 220)
        CopyKey.Text = "COPY KEY"
        CopyKey.TextColor3 = Color3.new(1,1,1)
        CopyKey.Font = Enum.Font.GothamBold
        CopyKey.TextSize = 15
        CopyKey.Parent = Frame
        Instance.new("UICorner", CopyKey).CornerRadius = UDim.new(0, 8)
    end

    -- Hover Effects
    local function hover(btn, normal, light)
        btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = light}):Play() end)
        btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = normal}):Play() end)
    end
    hover(Verify, Color3.fromRGB(0,170,255), Color3.fromRGB(0,200,255))
    if CopyKey then hover(CopyKey, Color3.fromRGB(0,130,220), Color3.fromRGB(0,160,255)) end

    -- Real-time timer
    task.spawn(function()
        while ScreenGui.Parent and task.wait(1) do
            local data = getSavedData()
            if not data or not table.find(self.ValidKeys, data.key) then
                DurationLabel.Text = "No key active"
                DurationLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                continue
            end

            local remaining = (self.DurationHours * 3600) - (os.time() - data.savedAt)
            if remaining <= 0 then
                DurationLabel.Text = "Key Expired — Get a new one"
                DurationLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            else
                local h = math.floor(remaining / 3600)
                local m = math.floor((remaining % 3600) / 60)
                local s = remaining % 60
                DurationLabel.Text = string.format("Time left: %02dh %02dm %02ds", h, m, s)
                DurationLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
            end
        end
    end)

    -- Auto-login check
    local function isValidSavedKey()
        local data = getSavedData()
        if not data or not table.find(self.ValidKeys, data.key) then return false end
        return (os.time() - data.savedAt) < (self.DurationHours * 3600)
    end

    if isValidSavedKey() then
        Status.Text = "Welcome back! Auto-login"
        Status.TextColor3 = Color3.fromRGB(100, 255, 150)
        task.wait(1.2)
        ScreenGui:Destroy()
        self.OnSuccess()
        return
    end

    -- Verify Button
    Verify.MouseButton1Click:Connect(function()
        local input = KeyBox.Text:gsub("%s", "") -- trim
        if table.find(self.ValidKeys, input) then
            saveKey(input)
            Status.Text = "Accepted! (Valid for "..self.DurationHours.."h)"
            Status.TextColor3 = Color3.fromRGB(100, 255, 150)
            task.wait(0.9)
            ScreenGui:Destroy()
            self.OnSuccess()
        else
            Status.Text = "Wrong key"
            Status.TextColor3 = Color3.fromRGB(255, 100, 100)
            task.wait(1)
            Player:Kick("\nDon't enter a wrong key!")
        end
    end)

    -- Copy Key Button
    if CopyKey then
        CopyKey.MouseButton1Click:Connect(function()
            if setclipboard then setclipboard(self.ValidKeys[1]) end
            Status.Text = "First key copied!"
            Status.TextColor3 = Color3.fromRGB(100, 255, 150)
        end)
    end
end

return ZaporiumKeySystem
