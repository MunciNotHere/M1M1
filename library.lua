-- // Library Table
local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- // Create Window
function Library:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game:GetService("CoreGui")

    -- // Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    -- // UI Corner & Stroke
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = mainFrame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 2
    uiStroke.Color = Color3.fromRGB(50, 50, 50)
    uiStroke.Parent = mainFrame

    -- // Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "🔥 " .. title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.Parent = mainFrame

    -- // Dragging Function
    local dragging, dragInput, dragStart, startPos
    titleLabel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleLabel.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- // Tabs Frame
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(0, 120, 1, -30)
    tabFrame.Position = UDim2.new(0, 0, 0, 30)
    tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabFrame.Parent = mainFrame

    -- // Tab Highlight Animation
    local highlight = Instance.new("Frame")
    highlight.Size = UDim2.new(1, 0, 0, 40)
    highlight.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
    highlight.BackgroundTransparency = 0.7
    highlight.Parent = tabFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = tabFrame

    -- // Content Frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -120, 1, -30)
    contentFrame.Position = UDim2.new(0, 120, 0, 30)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local pages = {}

    function Library:CreateTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, 0, 0, 40)
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.Gotham
        tabButton.Parent = tabFrame

        local page = Instance.new("Frame")
        page.Size = UDim2.new(1, 0, 1, 0)
        page.Visible = false
        page.Parent = contentFrame
        pages[tabName] = page

        tabButton.MouseButton1Click:Connect(function()
            for _, p in pairs(pages) do p.Visible = false end
            page.Visible = true
            TweenService:Create(highlight, TweenInfo.new(0.2), {Position = tabButton.Position}):Play()
        end)

        return {
            CreateButton = function(_, text, callback)
                local button = Instance.new("TextButton")
                button.Size = UDim2.new(1, -20, 0, 40)
                button.Position = UDim2.new(0, 10, 0, 10)
                button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                button.Text = text
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.Font = Enum.Font.Gotham
                button.Parent = page

                button.MouseButton1Click:Connect(callback)
            end,

            CreateToggle = function(_, text, callback)
                local toggleFrame = Instance.new("Frame")
                toggleFrame.Size = UDim2.new(1, -20, 0, 40)
                toggleFrame.Position = UDim2.new(0, 10, 0, 10)
                toggleFrame.BackgroundTransparency = 1
                toggleFrame.Parent = page

                local toggleBG = Instance.new("Frame")
                toggleBG.Size = UDim2.new(0, 50, 0, 25)
                toggleBG.Position = UDim2.new(1, -60, 0, 8)
                toggleBG.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                toggleBG.Parent = toggleFrame

                local toggleCircle = Instance.new("Frame")
                toggleCircle.Size = UDim2.new(0, 20, 0, 20)
                toggleCircle.Position = UDim2.new(0, 2, 0.5, -10)
                toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleCircle.Parent = toggleBG

                local toggled = false
                toggleFrame.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    TweenService:Create(toggleBG, TweenInfo.new(0.2), {BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)}):Play()
                    TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(toggled and 1 or 0, toggled and -22 or 2, 0.5, -10)}):Play()
                    callback(toggled)
                end)
            end
        }
    end

    return Library
end

return Library
