-- Loader.lua - Universal Zaporium Hub Loader
-- Paste this on GitHub, this is your main loadstring

local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Key-system-/refs/heads/main/KeyTesting.lua"))()

-- Your valid keys (add this!)
local VALID_KEYS = {"Sub2ScriptZap", "ScriptZapVIP", "KickABrainrot", "FreeKey2025"}

-- Game Detection + Scripts
local Games = {
    -- [PlaceId] = "raw github link to your script"
    [2788229376]  = "https://raw.githubusercontent.com/YourUsername/Arsenal/main.lua",     -- Arsenal
    [1962086868]  = "https://raw.githubusercontent.com/YourUsername/TowerOfHell/main.lua", -- Tower of Hell
    [286090429]   = "https://raw.githubusercontent.com/YourUsername/Arsenal/main.lua",     -- Arsenal (old ID)
    [12690025832] = "https://raw.githubusercontent.com/YourUsername/BladeBall/main.lua",    -- Blade Ball
    [13772394625] = "https://raw.githubusercontent.com/YourUsername/BladeBall/main.lua",    -- Blade Ball Alt
    [6403373529]  = "https://raw.githubusercontent.com/YourUsername/SlapBattles/main.lua",  -- Slap Battles
    [168556275]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Console",   -- Baseplate
    
    -- Add 100+ more games like this ↓
    -- [GamePlaceId] = "https://yourscriptlink.com/script.lua",
}

local PlaceId = game.PlaceId
local ScriptLink = Games[PlaceId]

-- Show key system
ZaporiumKeySystem.new({
    Keys = VALID_KEYS,
    Duration = 24,
    Title = "ZAPORIUM HUB",
    ShowCopyButton = true,
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
