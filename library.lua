local library = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:FindFirstChildOfClass("PlayerGui")

-- // Create Window
function library:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.Parent = screenGui

    -- Rounded Corners & Stroke
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = mainFrame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 2
    uiStroke.Color = Color3.fromRGB(50, 50, 50)
    uiStroke.Parent = mainFrame

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "🔥 Premium UI Library"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.Parent = mainFrame

    -- // Dragging
    local dragging, dragInput, dragStart, startPos
    mainFrame.InputBegan:Connect(function(input)
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

    mainFrame.InputChanged:Connect(function(input)
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

    -- // Tabs Frame (Scrollable)
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Size = UDim2.new(0, 120, 1, -30)
    tabFrame.Position = UDim2.new(0, 0, 0, 30)
    tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabFrame.ScrollBarThickness = 3
    tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabFrame.Parent = mainFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = tabFrame

    -- // Content Frame (Scrollable)
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, -120, 1, -30)
    contentFrame.Position = UDim2.new(0, 120, 0, 30)
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.ScrollBarThickness = 3
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.Parent = contentFrame

    -- Store Tabs
    local tabs = {}

    -- // Create Tab Function
    function library:CreateTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, 0, 0, 40)
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 14
        tabButton.Parent = tabFrame

        local uiCornerButton = Instance.new("UICorner")
        uiCornerButton.CornerRadius = UDim.new(0, 6)
        uiCornerButton.Parent = tabButton

        local page = Instance.new("Frame")
        page.Size = UDim2.new(1, 0, 0, 300)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.Parent = contentFrame

        local pageLayout = Instance.new("UIListLayout")
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Padding = UDim.new(0, 10)
        pageLayout.Parent = page

        tabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(contentFrame:GetChildren()) do
                if t:IsA("Frame") then
                    t.Visible = false
                end
            end
            page.Visible = true
        end)

        local tab = {}
        tab.page = page

        -- // Create Button
        function tab:CreateButton(buttonText, callback)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -20, 0, 40)
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            button.Text = buttonText
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.Gotham
            button.TextSize = 16
            button.Parent = page

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
        end

        -- // Create Toggle
        function tab:CreateToggle(toggleText, default, callback)
            local toggle = Instance.new("TextButton")
            toggle.Size = UDim2.new(1, -20, 0, 40)
            toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            toggle.Text = toggleText
            toggle.TextColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            toggle.Font = Enum.Font.Gotham
            toggle.TextSize = 16
            toggle.Parent = page

            local state = default
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.TextColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                callback(state)
            end)
        end

        return tab
    end

    return library
end

return library
