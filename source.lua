-- Azure Hub UI Library (Custom)
local Library = {}

-- Create the Main Window
function Library:CreateWindow(name)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = name

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 350, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0

    -- Adding UICorner and UIStroke to MainFrame
    local Corner = Instance.new("UICorner", MainFrame)
    Corner.CornerRadius = UDim.new(0, 15)
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Thickness = 2
    Stroke.Color = Color3.fromRGB(60, 60, 60)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

    -- Adding UICorner and UIStroke to Title
    local TitleCorner = Instance.new("UICorner", Title)
    TitleCorner.CornerRadius = UDim.new(0, 15)
    local TitleStroke = Instance.new("UIStroke", Title)
    TitleStroke.Thickness = 1
    TitleStroke.Color = Color3.fromRGB(60, 60, 60)

    local Container = Instance.new("Frame", MainFrame)
    Container.Size = UDim2.new(1, -120, 1, -50)
    Container.Position = UDim2.new(0, 115, 0, 45)
    Container.BackgroundTransparency = 1

    local UIListLayout = Instance.new("UIListLayout", Container)
    UIListLayout.Padding = UDim.new(0, 10)

    local TabsContainer = Instance.new("Frame", MainFrame)
    TabsContainer.Size = UDim2.new(0, 100, 1, -50)
    TabsContainer.Position = UDim2.new(0, 5, 0, 45)
    TabsContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabsContainer.BorderSizePixel = 0
    local TabsLayout = Instance.new("UIListLayout", TabsContainer)
    TabsLayout.Padding = UDim.new(0, 10)

    self.ScreenGui = ScreenGui
    self.MainFrame = MainFrame
    self.Container = Container
    self.TabsContainer = TabsContainer

    -- Draggable Functionality for the Window
    local dragging = false
    local dragInput, mousePos, framePos
    Title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = MainFrame.Position
        end
    end)

    Title.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging then
            local delta = input.Position - mousePos
            MainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

    return self
end

-- Add a Button
function Library:AddButton(text, callback)
    local Button = Instance.new("TextButton", self.Container)
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.BorderSizePixel = 0

    -- Adding UICorner and UIStroke to Button
    local Corner = Instance.new("UICorner", Button)
    Corner.CornerRadius = UDim.new(0, 10)
    local Stroke = Instance.new("UIStroke", Button)
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(60, 60, 60)

    Button.MouseButton1Click:Connect(callback)
end

-- Add a Toggle
function Library:AddToggle(text, callback)
    local Toggle = Instance.new("TextButton", self.Container)
    Toggle.Size = UDim2.new(1, 0, 0, 35)
    Toggle.Text = text
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextSize = 14
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Toggle.BorderSizePixel = 0

    -- Adding UICorner and UIStroke to Toggle
    local Corner = Instance.new("UICorner", Toggle)
    Corner.CornerRadius = UDim.new(0, 10)
    local Stroke = Instance.new("UIStroke", Toggle)
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(60, 60, 60)

    local Toggled = false
    local Indicator = Instance.new("Frame", Toggle)
    Indicator.Size = UDim2.new(0, 20, 0, 20)
    Indicator.Position = UDim2.new(1, -30, 0.5, -10)
    Indicator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Indicator.BorderSizePixel = 0

    Toggle.MouseButton1Click:Connect(function()
        Toggled = not Toggled
        Indicator.BackgroundColor3 = Toggled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(100, 100, 100)
        callback(Toggled)
    end)
end

-- Add a Tab
function Library:AddTab(tabName)
    local TabButton = Instance.new("TextButton", self.TabsContainer)
    TabButton.Size = UDim2.new(1, 0, 0, 40)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextSize = 14
    TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TabButton.BorderSizePixel = 0

    -- Adding UICorner and UIStroke to Tab Button
    local Corner = Instance.new("UICorner", TabButton)
    Corner.CornerRadius = UDim.new(0, 10)
    local Stroke = Instance.new("UIStroke", TabButton)
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(60, 60, 60)

    TabButton.MouseButton1Click:Connect(function()
        -- You can add logic to switch between tabs
    end)
end

return Library
