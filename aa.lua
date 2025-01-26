local Players = game:GetService("Players")
local player = Players.LocalPlayer
local userInputService = game:GetService("UserInputService")

-- Variable for the activation key
local activationKey = "q"
local isHighlighted = false -- To track if highlighting is active
local keyLink = "https://pastebin.com/2DC1k5wg" -- Replace with your actual key link

-- Function to add a highlight to a player
local function highlightPlayer(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local existingHighlight = player.Character:FindFirstChild("Highlight")
        if not existingHighlight then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = player.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Red color
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- White outline
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Name = "Highlight"
            highlight.Parent = player.Character
        end
    end
end

-- Function to update highlights for all players
local function updateHighlights()
    while true do
        if isHighlighted then
            for _, p in pairs(Players:GetPlayers()) do
                highlightPlayer(p)
            end
        end
        wait(1) -- Wait for 1 second before repeating
    end
end

-- Create an InputBox for the key
local screenGui = Instance.new("ScreenGui")
local inputBox = Instance.new("TextBox")
local copyButton = Instance.new("TextButton")
local enterButton = Instance.new("TextButton")
local destroyButton = Instance.new("TextButton")

screenGui.Name = "HighlightInputGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Style the InputBox
inputBox.Size = UDim2.new(0, 250, 0, 50)
inputBox.Position = UDim2.new(0.5, -125, 0, 100)
inputBox.Parent = screenGui
inputBox.Text = ""
inputBox.PlaceholderText = "Enter key to highlight"
inputBox.TextColor3 = Color3.new(1, 1, 1) -- White text
inputBox.BackgroundColor3 = Color3.new(0, 0, 0) -- Black background
inputBox.BorderSizePixel = 2
inputBox.BorderColor3 = Color3.fromRGB(0, 170, 255) -- Blue border

-- Create a button to copy the key link
copyButton.Size = UDim2.new(0, 150, 0, 50)
copyButton.Position = UDim2.new(0.5, -75, 0, 160)
copyButton.Text = "Copy Key Link"
copyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0) -- Green background
copyButton.TextColor3 = Color3.new(1, 1, 1) -- White text
copyButton.Parent = screenGui

-- Create an Enter button
enterButton.Size = UDim2.new(0, 100, 0, 50)
enterButton.Position = UDim2.new(0.5, 50, 0, 100)
enterButton.Text = "Enter"
enterButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- Light blue background
enterButton.TextColor3 = Color3.new(1, 1, 1) -- White text
enterButton.Parent = screenGui

-- Create a Destroy button
destroyButton.Size = UDim2.new(0, 100, 0, 50)
destroyButton.Position = UDim2.new(0.5, 150, 0, 100)
destroyButton.Text = "Destroy"
destroyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red background
destroyButton.TextColor3 = Color3.new(1, 1, 1) -- White text
destroyButton.Parent = screenGui

-- Function to handle copying the key link
copyButton.MouseButton1Click:Connect(function()
    setclipboard(keyLink) -- Copy the key link to the clipboard
    copyButton.Text = "Link Copied!" -- Change button text to indicate success
    wait(2) -- Wait for 2 seconds
    copyButton.Text = "Copy Key Link" -- Reset button text
end)

-- Function to handle key input and activate highlighting
local function activateHighlighting()
    if inputBox.Text == activationKey then
        isHighlighted = true -- Activate highlighting
        screenGui:Destroy() -- Destroy the input box GUI
    else
        inputBox.Text = "" -- Clear if incorrect
    end
end

-- Connect Enter button to the activation function
enterButton.MouseButton1Click:Connect(activateHighlighting)

-- Connect Destroy button to remove the GUI
destroyButton.MouseButton1Click:Connect(function()
    isHighlighted = false -- Deactivate highlighting
    screenGui:Destroy() -- Destroy the GUI
end)

-- Connect input box to the activation function (in case users press Enter key)
inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        activateHighlighting()
    end
end)

-- Start the highlight update process
updateHighlights()

-- Listen for new players joining and highlight them
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(character)
        highlightPlayer(p)
    end)
end)
