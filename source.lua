--[=[ 
    Custom UI Library (with AddButton, AddWindow, AddToggle)
    Simplified functions to add buttons, windows, and toggles.
]=]

local lib = {}

-- Function to create the main window
function lib:AddWindow(title, size, position)
    local window = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    window.Name = "Libary"
    window.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local mainFrame = Instance.new("Frame", window)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.Size = size
    mainFrame.Position = position
    mainFrame.BorderSizePixel = 0

    -- Round corners
    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 15)

    -- Top bar
    local topBar = Instance.new("Frame", mainFrame)
    topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    topBar.Size = UDim2.new(0, size.X.Offset, 0, 50)
    topBar.BorderSizePixel = 0

    local titleLabel = Instance.new("TextLabel", topBar)
    titleLabel.Text = title
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.TextAlign = Enum.TextXAlignment.Center
    titleLabel.BackgroundTransparency = 1

    -- ScrollFrame for buttons
    local scrollFrame = Instance.new("ScrollingFrame", mainFrame)
    scrollFrame.Size = UDim2.new(0, size.X.Offset - 25, 0, size.Y.Offset - 100)
    scrollFrame.Position = UDim2.new(0.025, 0, 0.2, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
    scrollFrame.ScrollBarThickness = 6

    local padding = Instance.new("UIPadding", scrollFrame)
    padding.PaddingTop = UDim.new(0, 10)

    return window, scrollFrame
end

-- Function to add buttons to a window
function lib:AddButton(scrollFrame, text, callback)
    local button = Instance.new("TextButton", scrollFrame)
    button.Text = text
    button.Size = UDim2.new(0, 361, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.TextAlign = Enum.TextXAlignment.Center
    button.BorderSizePixel = 0

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 12)

    button.MouseButton1Click:Connect(callback)

    return button
end

-- Function to add toggle buttons
function lib:AddToggle(scrollFrame, text, callback)
    local toggleButton = Instance.new("TextButton", scrollFrame)
    toggleButton.Text = text
    toggleButton.Size = UDim2.new(0, 361, 0, 50)
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 18
    toggleButton.TextAlign = Enum.TextXAlignment.Center
    toggleButton.BorderSizePixel = 0

    local corner = Instance.new("UICorner", toggleButton)
    corner.CornerRadius = UDim.new(0, 12)

    local isToggled = false
    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        toggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
        callback(isToggled)
    end)

    return toggleButton
end

-- Example usage
local window, scrollFrame = lib:AddWindow("Example UI", UDim2.new(0, 400, 0, 300), UDim2.new(0.3, 0, 0.3, 0))

-- Adding a Button
lib:AddButton(scrollFrame, "Example Button", function()
    print("Button clicked!")
end)

-- Adding a Toggle
lib:AddToggle(scrollFrame, "Example Toggle", function(state)
    print("Toggle state: " .. tostring(state))
end)

-- Draggable function
local function dragGui()
    local dragStart, startPos
    local userInputService = game:GetService("UserInputService")
    local runService = game:GetService("RunService")
    local dragging = false

    window.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
        end
    end)

    window.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    runService.RenderStepped:Connect(function()
        if dragging then
            local delta = userInputService:GetMouseLocation() - dragStart
            window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Initialize draggable feature
dragGui()

return lib
