local allowedPlaceIds = {
    [15376909601] = true -- Arise Crossover
}

if not allowedPlaceIds[game.PlaceId] then
    game.Players.LocalPlayer:Kick("Unauthorized game.")
    return
end

-- Thank you notification
game.StarterGui:SetCore("SendNotification", {
    Title = "NebulaStrike";
    Text = "Thank you for using NebulaStrike!";
    Duration = 5;
})

-- Safe load from GitHub
local success, response = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/Legitxwx/Arise/refs/heads/main/Nebula")
end)

if success then
    loadstring(response)()
else
    warn("Failed to load Nebula script:", response)
end
