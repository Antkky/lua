local prefix = "."
local CommandingPlayer = game.Players:FindFirstChild("notbigboyman")

if not CommandingPlayer then
    error("Player not found: " .. "notbigboyman")
end

local LocalPlayer = game.Players.LocalPlayer

Local function Execute(command, args)
    local character = workspace:FindFirstChild(LocalPlayer.Name)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if command == "float" then
        local amount = 10
        if args then
            amount = args
        end 
        humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position + Vector3.new(0, amount, 0))
        wait(0.2)
        
        local head = character:FindFirstChild("Head")
        if head then
            head.Anchored = true
        end
    end
end

CommandingPlayer.Chatted:Connect(function(msg)
    msg = msg:lower()

    if string.sub(msg, 1, 1) == prefix then
        local msgWithoutPrefix = string.sub(msg, 2)

        local firstSpace = string.find(msgWithoutPrefix, " ")
        if not firstSpace then
            return -- malformed command
        end

        -- Extract the command from the message
        local command = string.sub(msgWithoutPrefix, 1, firstSpace - 1)

        -- Remove the command part and trim the rest of the message
        local remainingMsg = string.sub(msgWithoutPrefix, firstSpace + 1)

        -- Find the second space (separating player from arguments)
        local secondSpace = string.find(remainingMsg, " ")

        local playerName, args

        if secondSpace then
            playerName = string.sub(remainingMsg, 1, secondSpace - 1)
            args = string.sub(remainingMsg, secondSpace + 1)
        else
            playerName = remainingMsg
            args = ""
        end

        local targetPlayer
        if playerName ~= "" then
            targetPlayer = game.Players:FindFirstChild(playerName)
        end

        if targetPlayer and targetPlayer == LocalPlayer then
            Execute(command, args)
    
        elseif not targetPlayer then
            Execute(command, args)
        end
    end
end)

game:GetService("StarterGui"):SetCore(
    "SendNotification",
    {
        Title = "Notification",
        Text = "@Antkky",
        Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
        Duration = 16
    }
)
