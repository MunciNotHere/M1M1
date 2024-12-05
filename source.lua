-- M1M1 Library

local M1M1 = {}  -- Main Library Table

-- Create ScreenGui
M1M1.ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
M1M1.ScreenGui.Name = "Library"

-- Function to add a Button
function M1M1:AddButton(title, callback)
    local button = Instance.new("TextButton", self.ScreenGui)
    button.Text = title
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, 0.5, -25)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
    
    button.MouseButton1Click:Connect(callback)
end

-- Function to add a Toggle Button
function M1M1:AddToggle(title, callback)
    local toggle = Instance.new("TextButton", self.ScreenGui)
    toggle.Text = title
    toggle.Size = UDim2.new(0, 200, 0, 50)
    toggle.Position = UDim2.new(0.5, -100, 0.5, 50)
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
    
    local isOn = false
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        callback(isOn)
        toggle.BackgroundColor3 = isOn and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    end)
end

-- Return M1M1
return M1M1
