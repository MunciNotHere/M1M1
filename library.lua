local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create UI Library Window
function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game:GetService("CoreGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(80, 80, 80)
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Title.Text = title or "🔥 Premium UI Library"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = MainFrame

    -- Dragging Function
    local dragging, dragInput, startPos
    Title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = input.Position
        end
    end)
    Title.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - startPos
            MainFrame.Position = UDim2.new(0, MainFrame.Position.X.Offset + delta.X, 0, MainFrame.Position.Y.Offset + delta.Y)
            startPos = input.Position
        end
    end)
    Title.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    local Tabs = Instance.new("Frame")
    Tabs.Size = UDim2.new(0, 120, 1, -40)
    Tabs.Position = UDim2.new(0, 0, 0, 40)
    Tabs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Tabs.Parent = MainFrame

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -120, 1, -40)
    ContentFrame.Position = UDim2.new(0, 120, 0, 40)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ContentFrame.Parent = MainFrame

    local TabButtons = {}

    function Library:CreateTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Parent = Tabs

        local TabFrame = Instance.new("Frame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.Visible = false
        TabFrame.Parent = ContentFrame

        table.insert(TabButtons, {Button = TabButton, Frame = TabFrame})

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(TabButtons) do
                v.Frame.Visible = false
                v.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
        end)

        local Tab = {}

        function Tab:CreateButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -10, 0, 40)
            Button.Position = UDim2.new(0, 5, 0, 5)
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Font = Enum.Font.Gotham
            Button.Parent = TabFrame

            Button.MouseButton1Click:Connect(callback)
        end

        function Tab:CreateToggle(text, default, callback)
            local Toggle = Instance.new("TextButton")
            Toggle.Size = UDim2.new(1, -10, 0, 40)
            Toggle.Position = UDim2.new(0, 5, 0, 50)
            Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Toggle.Text = text
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.Font = Enum.Font.Gotham
            Toggle.Parent = TabFrame

            local ToggleImage = Instance.new("ImageLabel")
            ToggleImage.Size = UDim2.new(0, 25, 0, 25)
            ToggleImage.Position = UDim2.new(1, -35, 0.5, -12)
            ToggleImage.BackgroundTransparency = 1
            ToggleImage.Image = "rbxassetid://" .. (default and "105620223191972" or "98219838597023")
            ToggleImage.Parent = Toggle

            local state = default
            Toggle.MouseButton1Click:Connect(function()
                state = not state
                ToggleImage.Image = "rbxassetid://" .. (state and "105620223191972" or "98219838597023")
                callback(state)
            end)
        end

        return Tab
    end

    return Library
end

return Library
