local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- A simple blur in Lighting for a slight background effect:
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 6
blurEffect.Parent = Lighting

local DarkUI = {}

-- Create Window
function DarkUI:CreateWindow(windowTitle, themeColor, toggleKey)
    themeColor = themeColor or Color3.fromRGB(80,80,80)

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DarkUI_Library"
    screenGui.Parent = game.CoreGui

    -- Main container
    local MainContainer = Instance.new("Frame", screenGui)
    MainContainer.Name = "MainContainer"
    MainContainer.Size = UDim2.new(0, 500, 0, 300)
    MainContainer.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainContainer.BackgroundColor3 = Color3.fromRGB(25,25,25)
    MainContainer.BackgroundTransparency = 0.2

    local corner = Instance.new("UICorner", MainContainer)
    corner.CornerRadius = UDim.new(0, 10)

    -- Title Bar
    local TitleBar = Instance.new("Frame", MainContainer)
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = themeColor
    TitleBar.BackgroundTransparency = 0.2

    local TitleText = Instance.new("TextLabel", TitleBar)
    TitleText.Size = UDim2.new(1, -10, 1, 0)
    TitleText.Position = UDim2.new(0, 5, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = windowTitle or "Dark UI"
    TitleText.TextColor3 = Color3.new(1,1,1)
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextScaled = true

    -- Tab Holder
    local TabHolder = Instance.new("ScrollingFrame", MainContainer)
    TabHolder.Name = "TabHolder"
    TabHolder.Size = UDim2.new(0, 120, 1, -30)
    TabHolder.Position = UDim2.new(0, 0, 0, 30)
    TabHolder.BackgroundTransparency = 1
    TabHolder.CanvasSize = UDim2.new(0,0,0,0)
    TabHolder.ScrollBarThickness = 4

    local tabLayout = Instance.new("UIListLayout", TabHolder)
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Content Holder
    local ContentHolder = Instance.new("Frame", MainContainer)
    ContentHolder.Name = "ContentHolder"
    ContentHolder.Size = UDim2.new(1, -120, 1, -30)
    ContentHolder.Position = UDim2.new(0, 120, 0, 30)
    ContentHolder.BackgroundTransparency = 1

    -- Dragging
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainContainer.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            MainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Toggle Key
    if toggleKey then
        UserInputService.InputBegan:Connect(function(input, proc)
            if not proc and input.KeyCode == toggleKey then
                MainContainer.Visible = not MainContainer.Visible
            end
        end)
    end

    -- Window Object
    local windowObj = {}
    windowObj.ScreenGui = screenGui
    windowObj.MainContainer = MainContainer
    windowObj.TabHolder = TabHolder
    windowObj.ContentHolder = ContentHolder
    windowObj.Tabs = {}
    windowObj.ActiveTab = nil

    -- Create Tab
    function windowObj:CreateTab(tabName)
        local tabButton = Instance.new("TextButton", TabHolder)
        tabButton.Size = UDim2.new(1, 0, 0, 30)
        tabButton.BackgroundColor3 = Color3.fromRGB(35,35,35)
        tabButton.BackgroundTransparency = 0.2
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.new(1,1,1)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextScaled = true

        local bCorner = Instance.new("UICorner", tabButton)
        bCorner.CornerRadius = UDim.new(0,5)

        local contentFrame = Instance.new("ScrollingFrame", ContentHolder)
        contentFrame.Size = UDim2.new(1,0,1,0)
        contentFrame.Visible = false
        contentFrame.ScrollBarThickness = 4
        contentFrame.BackgroundTransparency = 1
        contentFrame.CanvasSize = UDim2.new(0,0,0,0)

        local cLayout = Instance.new("UIListLayout", contentFrame)
        cLayout.Padding = UDim.new(0,5)
        cLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local tabObj = {}
        tabObj.Button = tabButton
        tabObj.Content = contentFrame

        tabButton.MouseButton1Click:Connect(function()
            if windowObj.ActiveTab then
                windowObj.ActiveTab.Content.Visible = false
            end
            contentFrame.Visible = true
            windowObj.ActiveTab = tabObj
        end)

        function tabObj:CreateButton(btnText, callback)
            local btn = Instance.new("TextButton", contentFrame)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
            btn.BackgroundTransparency = 0.2
            btn.Text = btnText
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.Gotham
            btn.TextScaled = true

            local cornerBtn = Instance.new("UICorner", btn)
            cornerBtn.CornerRadius = UDim.new(0,5)

            btn.MouseButton1Click:Connect(function()
                if callback then
                    pcall(callback)
                end
            end)
        end

        function tabObj:CreateToggle(toggleText, defaultVal, callback)
            local togFrame = Instance.new("Frame", contentFrame)
            togFrame.Size = UDim2.new(1, -10, 0, 30)
            togFrame.BackgroundTransparency = 1

            local lbl = Instance.new("TextLabel", togFrame)
            lbl.Size = UDim2.new(0.7,0,1,0)
            lbl.BackgroundTransparency = 1
            lbl.Text = toggleText
            lbl.TextColor3 = Color3.new(1,1,1)
            lbl.Font = Enum.Font.Gotham
            lbl.TextScaled = true

            local togBtn = Instance.new("TextButton", togFrame)
            togBtn.Size = UDim2.new(0.3, 0, 1, 0)
            togBtn.Position = UDim2.new(0.7,0,0,0)
            togBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
            togBtn.BackgroundTransparency = 0.2
            togBtn.TextColor3 = Color3.new(1,1,1)
            togBtn.Font = Enum.Font.Gotham
            togBtn.TextScaled = true

            local cornerTog = Instance.new("UICorner", togBtn)
            cornerTog.CornerRadius = UDim.new(0,5)

            local val = defaultVal
            togBtn.Text = val and "ON" or "OFF"

            togBtn.MouseButton1Click:Connect(function()
                val = not val
                togBtn.Text = val and "ON" or "OFF"
                if callback then
                    pcall(callback, val)
                end
            end)
        end

        function tabObj:CreateLabel(text)
            local lbl = Instance.new("TextLabel", contentFrame)
            lbl.Size = UDim2.new(1, -10, 0, 30)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.TextColor3 = Color3.new(1,1,1)
            lbl.Font = Enum.Font.Gotham
            lbl.TextScaled = true
        end

        table.insert(windowObj.Tabs, tabObj)
        if not windowObj.ActiveTab then
            contentFrame.Visible = true
            windowObj.ActiveTab = tabObj
        end
        return tabObj
    end

    -- Slide-in Notification
    function windowObj:Notify(notifTitle, notifText)
        local notifyGui = Instance.new("ScreenGui", game.CoreGui)
        notifyGui.Name = "DarkUI_Notification"

        local notifyFrame = Instance.new("Frame", notifyGui)
        notifyFrame.Size = UDim2.new(0, 300, 0, 80)
        notifyFrame.Position = UDim2.new(1, 300, 0.8, 0) -- start off-screen to the right
        notifyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
        notifyFrame.BackgroundTransparency = 0.2

        local cornerN = Instance.new("UICorner", notifyFrame)
        cornerN.CornerRadius = UDim.new(0,10)

        local title = Instance.new("TextLabel", notifyFrame)
        title.Size = UDim2.new(1, 0, 0, 30)
        title.Text = notifTitle
        title.BackgroundTransparency = 1
        title.TextColor3 = Color3.new(1,1,1)
        title.Font = Enum.Font.GothamBold
        title.TextScaled = true

        local text = Instance.new("TextLabel", notifyFrame)
        text.Size = UDim2.new(1, 0, 0, 30)
        text.Position = UDim2.new(0, 0, 0, 30)
        text.Text = notifText
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.new(1,1,1)
        text.Font = Enum.Font.Gotham
        text.TextScaled = true

        -- Slide in
        TweenService:Create(notifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(1, -320, 0.8, 0)}):Play()

        -- Wait & slide out
        task.delay(3, function()
            TweenService:Create(notifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(1, 300, 0.8, 0)}):Play()
            task.wait(0.5)
            notifyGui:Destroy()
        end)
    end

    return windowObj
end

return DarkUI
