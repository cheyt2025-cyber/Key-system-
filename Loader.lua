-- Loader.lua - Universal Zaporium Hub Loader (Dynamic Keys Edition)

local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/ZaporiumKeySystem.lua"))()

-- Dynamic Key Fetch (gets ONE random key from your GitHub JSON)
local function getDynamicKey()
    local success, response = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/keys.json")
    if not success then
        warn("Failed to fetch keys — using fallback")
        return {"FallbackKey-TEST"}  -- Emergency backup if GitHub down
    end
    
    local ok, data = pcall(HttpService.JSONDecode, game:GetService("HttpService"), response)
    if ok and data and data.keys and #data.keys > 0 then
        -- Pick a random key (or you can make it sequential/user-specific later)
        local randomIndex = math.random(1, #data.keys)
        local singleKey = {data.keys[randomIndex]}  -- Return as array with ONE key
        print("Fetched dynamic key: " .. data.keys[randomIndex])  -- For your logs
        return singleKey
    else
        warn("Invalid keys data — using fallback")
        return {"FallbackKey-TEST"}
    end
end

local VALID_KEYS = getDynamicKey()  -- Now it's dynamic!

-- Rest of your code stays EXACTLY the same...
local Games = {
    -- Your games table here (unchanged)
}

local PlaceId = game.PlaceId
local ScriptLink = Games[PlaceId]

-- Show key system (passes the single dynamic key)
ZaporiumKeySystem.new({
    Keys = VALID_KEYS,  -- Now just 1 key!
    Duration = 24,
    Title = "ZAPORIUM HUB",
    ShowCopyButton = false,  -- Hide copy button since key is dynamic/personal
    OnSuccess = function()
        if ScriptLink then
            print("Game detected! Loading script...")
            loadstring(game:HttpGet(ScriptLink))()
        else
            warn("This game is not supported yet!")
            game.StarterGui:SetCore("SendNotification", {
                Title = "Zaporium Hub";
                Text = "Game not supported yet! Join our Discord for updates.";
                Duration = 8;
            })
        end
    end
}):Show()
