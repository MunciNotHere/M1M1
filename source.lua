-- M1M1 Library (Updated)

local M1M1 = {}  -- Main Library Table

-- Create ScreenGui
M1M1.ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
M1M1.ScreenGui.Name = "Library"
M1M1.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
M1M1.MainFrame = Instance.new("Frame", M1M1.ScreenGui)
M1M1.MainFrame.Size = UDim2.new(0, 399, 0, 287)
M1M1.MainFrame.Position = UDim2.new(0.304, 0, 0.30693, 0)
M1M1.MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
M1M1.MainFrame.BorderSizePixel = 0

-- UICorner for Main Frame
local UICornerMain = Instance.new("UICorner", M1M1.MainFrame)
UICornerMain.CornerRadius = UDim.new(0, 13)

-- Title Text
local titleLabel = Instance.new("TextLabel", M1M1.MainFrame)
titleLabel.Name = "Title"  -- Ensure we set the name so it can be accessed later
titleLabel.Size = UDim2.new(0, 375, 0, 50)
titleLabel.Position = UDim2.new(0.03567, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Title"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSans
titleLabel.TextSize = 24
titleLabel.TextScaled = true

-- Scrolling Frame for buttons and inputs
M1M1.ScrollingFrame = Instance.new("ScrollingFrame", M1M1.MainFrame)
M1M1.ScrollingFrame.Size = UDim2.new(0, 375, 0, 218)
M1M1.ScrollingFrame.Position = UDim2.new(0.03567, 0, 0.2, 0)
M1M1.ScrollingFrame.BackgroundTransparency = 1
M1M1.ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(61, 61, 61)
M1M1.ScrollingFrame.ScrollBarThickness = 0

-- Layout for buttons
local UIListLayout = Instance.new("UIListLayout", M1M1.ScrollingFrame)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- Function to Add Button
function M1M1:AddButton(title, callback)
    local button = Instance.new("TextButton", M1M1.ScrollingFrame)
    button.Text = title
    button.Size = UDim2.new(0, 361, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.TextScaled = true
    button.BackgroundTransparency = 0.5
    button.BorderSizePixel = 0

    -- Corner for the button
    local UICornerButton = Instance.new("UICorner", button)
    UICornerButton.CornerRadius = UDim.new(0, 13)

    -- Add button click functionality
    button.MouseButton1Click:Connect(function()
        callback()
    end)
end

-- Function to Add Text Input
function M1M1:AddTextInput(placeholder)
    local inputBox = Instance.new("TextBox", M1M1.ScrollingFrame)
    inputBox.Size = UDim2.new(0, 361, 0, 50)
    inputBox.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.Font = Enum.Font.SourceSans
    inputBox.TextSize = 18
    inputBox.Text = placeholder
    inputBox.TextScaled = true
    inputBox.BackgroundTransparency = 0.5
    inputBox.BorderSizePixel = 0

    -- Corner for the input box
    local UICornerInput = Instance.new("UICorner", inputBox)
    UICornerInput.CornerRadius = UDim.new(0, 13)

    return inputBox
end

-- Function to Add Toggle
function M1M1:AddToggle(title, callback)
    local toggle = Instance.new("TextButton", M1M1.ScrollingFrame)
    toggle.Text = title
    toggle.Size = UDim2.new(0, 361, 0, 50)
    toggle.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.SourceSans
    toggle.TextSize = 18
    toggle.TextScaled = true
    toggle.BackgroundTransparency = 0.5
    toggle.BorderSizePixel = 0

    -- Corner for the toggle button
    local UICornerToggle = Instance.new("UICorner", toggle)
    UICornerToggle.CornerRadius = UDim.new(0, 13)

    -- Add toggle click functionality
    local isOn = false
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        callback(isOn)
        toggle.BackgroundColor3 = isOn and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    end)
end

-- Return M1M1
return M1M1
