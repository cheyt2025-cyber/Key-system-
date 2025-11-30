-- Loader.lua - Zaporium Hub (LootLabs + Unlimited Keys Edition)
local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Key-system-/refs/heads/main/KeyTesting.lua"))()

-- Fetch ALL keys from allkeys.txt (accepts ANY key from the file)
local function getAllValidKeys()
    local success, content = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/allkeys.txt")
    end)
    
    if success and content and content ~= "" then
        local keys = {}
        for line in content:gmatch("[^\r\n]+") do
            local key = line:gsub("^%s*(.-)%s*$", "")  -- trim
            if key ~= "" then
                table.insert(keys, key)
            end
        end
        print("Loaded " .. #keys .. " keys from allkeys.txt")
        return keys
    else
        warn("Failed to load keys → using emergency key")
        return {"ZAP-USER-0001"}  -- emergency fallback
    end
end

local VALID_KEYS = getAllValidKeys()

-- Your games (add real scripts later)
local Games = {
    [2788229376] = "https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/scripts/Arsenal.lua",
    [6403373529] = "https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/scripts/SlapBattles.lua",
    -- add more when ready
}

local PlaceId = game.PlaceId
local ScriptLink = Games[PlaceId]

ZaporiumKeySystem.new({
    Keys = VALID_KEYS,        -- now 100–10000+ keys
    Duration = 24,
    Title = "ZAPORIUM HUB",
    ShowCopyButton = false,   -- hide copy button (keys are from LootLabs)
    OnSuccess = function()
        if ScriptLink then
            loadstring(game:HttpGet(ScriptLink))()
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Zaporium Hub";
                Text = "Game not supported yet!";
                Duration = 8;
            })
        end
    end
}):Show()
