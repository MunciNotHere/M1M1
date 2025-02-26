local library = {}

-- // Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- // Create Main UI
function library:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game:GetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.Parent = screenGui

    -- // UICorner & UIStroke (Premium Look)
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = mainFrame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 2
    uiStroke.Color = Color3.fromRGB(50, 50, 50)
    uiStroke.Parent = mainFrame

    -- // Title Bar
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "🔥 Premium UI Library"
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

    -- // Left Tabs Frame
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(0, 120, 1, -30)
    tabFrame.Position = UDim2.new(0, 0, 0, 30)
    tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabFrame.Parent = mainFrame

    local uiCornerTabs = Instance.new("UICorner")
    uiCornerTabs.CornerRadius = UDim.new(0, 8)
    uiCornerTabs.Parent = tabFrame

    -- // Tabs ScrollingFrame
    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Size = UDim2.new(1, 0, 1, 0)
    tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabScroll.ScrollBarThickness = 2
    tabScroll.BackgroundTransparency = 1
    tabScroll.Parent = tabFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = tabScroll

    -- // Content ScrollingFrame
    local contentScroll = Instance.new("ScrollingFrame")
    contentScroll.Size = UDim2.new(1, -120, 1, -30)
    contentScroll.Position = UDim2.new(0, 120, 0, 30)
    contentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentScroll.ScrollBarThickness = 2
    contentScroll.BackgroundTransparency = 1
    contentScroll.Parent = mainFrame

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.Parent = contentScroll

    -- // Auto-Update Scrolling
    local function updateScrolling(frame, layout)
        frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end
    tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        updateScrolling(tabScroll, tabLayout)
    end)
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        updateScrolling(contentScroll, contentLayout)
    end)

    -- // Create a Tab
    function library:CreateTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, 0, 0, 40)
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 14
        tabButton.Parent = tabScroll

        local tabContent = Instance.new("Frame")
        tabContent.Size = UDim2.new(1, 0, 0, 300)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.Parent = contentScroll

        -- Click to Switch
        tabButton.MouseButton1Click:Connect(function()
            for _, child in pairs(contentScroll:GetChildren()) do
                if child:IsA("Frame") then
                    child.Visible = false
                end
            end
            tabContent.Visible = true
        end)

        return tabContent
    end

    -- // Create a Smooth Button
    function library:CreateButton(parent, text, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 40)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 16
        button.Parent = parent

        local uiCornerButton = Instance.new("UICorner")
        uiCornerButton.CornerRadius = UDim.new(0, 6)
        uiCornerButton.Parent = button

        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        end)

        button.MouseButton1Click:Connect(callback)

        return button
    end

    return library
end

return library
