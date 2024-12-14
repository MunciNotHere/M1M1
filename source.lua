-- Custom iOS-style UI Library
local Library = {}

-- Create the Main Window
function Library:CreateWindow(name)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = name

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 350, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(242, 242, 242)
    MainFrame.BorderSizePixel = 0
    local Corner = Instance.new("UICorner", MainFrame)
    Corner.CornerRadius = UDim.new(0, 20)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = name
    Title.TextColor3 = Color3.fromRGB(0, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    Title.BorderSizePixel = 0
    Title.TextXAlignment = Enum.TextXAlignment.Left
    local Stroke = Instance.new("UIStroke", Title)
    Stroke.Thickness = 2
    Stroke.Color = Color3.fromRGB(200, 200, 200)

    local CloseButton = Instance.new("TextButton", MainFrame)
    CloseButton.Text = "✕"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 10)
    CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 20
    CloseButton.BackgroundTransparency = 1
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Container = Instance.new("Frame", MainFrame)
    Container.Size = UDim2.new(1, -10, 1, -50)
    Container.Position = UDim2.new(0, 5, 0, 45)
    Container.BackgroundTransparency = 1
    local UIListLayout = Instance.new("UIListLayout", Container)
    UIListLayout.Padding = UDim.new(0, 15)

    local UICornerContainer = Instance.new("UICorner", Container)
    UICornerContainer.CornerRadius = UDim.new(0, 15)

    self.ScreenGui = ScreenGui
    self.Container = Container
    return self
end

-- Add a Button with Smooth Animation
function Library:AddButton(text, callback)
    local Button = Instance.new("TextButton", self.Container)
    Button.Size = UDim2.new(1, 0, 0, 50)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(0, 0, 0)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    Button.BorderSizePixel = 0
    local Corner = Instance.new("UICorner", Button)
    Corner.CornerRadius = UDim.new(0, 15)

    local Stroke = Instance.new("UIStroke", Button)
    Stroke.Thickness = 2
    Stroke.Color = Color3.fromRGB(200, 200, 200)

    Button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 220, 220)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        callback()
    end)
end

-- Add a Toggle with Smooth Animation
function Library:AddToggle(text, callback)
    local Toggle = Instance.new("Frame", self.Container)
    Toggle.Size = UDim2.new(1, 0, 0, 50)
    Toggle.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    Toggle.BorderSizePixel = 0
    local Corner = Instance.new("UICorner", Toggle)
    Corner.CornerRadius = UDim.new(0, 15)

    local Label = Instance.new("TextLabel", Toggle)
    Label.Text = text
    Label.Size = UDim2.new(0.8, 0, 1, 0)
    Label.TextColor3 = Color3.fromRGB(0, 0, 0)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Indicator = Instance.new("Frame", Toggle)
    Indicator.Size = UDim2.new(0, 30, 0, 20)
    Indicator.Position = UDim2.new(1, -40, 0.5, -10)
    Indicator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    local CornerIndicator = Instance.new("UICorner", Indicator)
    CornerIndicator.CornerRadius = UDim.new(0, 10)

    local Toggled = false

    Toggle.MouseButton1Click:Connect(function()
        Toggled = not Toggled
        game:GetService("TweenService"):Create(Indicator, TweenInfo.new(0.2), {BackgroundColor3 = Toggled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(100, 100, 100)}):Play()
        callback(Toggled)
    end)
end

return Library
