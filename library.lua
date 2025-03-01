local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local BetterUI = {}

-- Create the base UI with dark mode, rounded corners, and scrolling areas.
function BetterUI:CreateUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "M1M1_UI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = PlayerGui

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(51,51,51)
    MainFrame.Size = UDim2.new(0,350,0,250)
    MainFrame.Position = UDim2.new(0.30813,0,0.28464,0)
    MainFrame.BorderColor3 = Color3.fromRGB(0,0,0)
    local mainCorner = Instance.new("UICorner", MainFrame)
    mainCorner.CornerRadius = UDim.new(0,20)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Name = "Title"
    Title.TextWrapped = true
    Title.BorderSizePixel = 0
    Title.TextScaled = true
    Title.BackgroundColor3 = Color3.fromRGB(51,51,51)
    Title.TextSize = 14
    Title.FontFace = Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    Title.TextColor3 = Color3.fromRGB(151,151,151)
    Title.BackgroundTransparency = 0.1
    Title.Size = UDim2.new(0,350,0,50)
    Title.BorderColor3 = Color3.fromRGB(0,0,0)
    Title.Text = "Title"
    local titleCorner = Instance.new("UICorner", Title)
    titleCorner.CornerRadius = UDim.new(0,20)

    local TabsFrame = Instance.new("Frame", MainFrame)
    TabsFrame.Name = "Tabs"
    TabsFrame.BorderSizePixel = 0
    TabsFrame.BackgroundColor3 = Color3.fromRGB(51,51,51)
    TabsFrame.Size = UDim2.new(0,115,0,200)
    TabsFrame.Position = UDim2.new(0,0,0.2,0)
    TabsFrame.BorderColor3 = Color3.fromRGB(0,0,0)
    TabsFrame.BackgroundTransparency = 0.1
    local tabsCorner = Instance.new("UICorner", TabsFrame)
    tabsCorner.CornerRadius = UDim.new(0,20)

    local TabScroll = Instance.new("ScrollingFrame", TabsFrame)
    TabScroll.Name = "TabScroll"
    TabScroll.Active = true
    TabScroll.BorderSizePixel = 0
    TabScroll.BackgroundColor3 = Color3.fromRGB(255,255,255)
    TabScroll.Size = UDim2.new(0,100,0,200)
    TabScroll.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
    TabScroll.BorderColor3 = Color3.fromRGB(0,0,0)
    TabScroll.BackgroundTransparency = 1
    local uiListTabs = Instance.new("UIListLayout", TabScroll)
    uiListTabs.Padding = UDim.new(0,3)
    uiListTabs.SortOrder = Enum.SortOrder.LayoutOrder

    local ElementScroll = Instance.new("ScrollingFrame", MainFrame)
    ElementScroll.Name = "elementScroll"
    ElementScroll.Active = true
    ElementScroll.BorderSizePixel = 0
    ElementScroll.BackgroundColor3 = Color3.fromRGB(255,255,255)
    ElementScroll.Size = UDim2.new(0,233,0,200)
    ElementScroll.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
    ElementScroll.Position = UDim2.new(0.32857,0,0.19837,0)
    ElementScroll.BorderColor3 = Color3.fromRGB(0,0,0)
    ElementScroll.BackgroundTransparency = 1
    local uiListElem = Instance.new("UIListLayout", ElementScroll)
    uiListElem.Padding = UDim.new(0,3)
    uiListElem.SortOrder = Enum.SortOrder.LayoutOrder

    local NotificationPlace = Instance.new("ScrollingFrame", ScreenGui)
    NotificationPlace.Name = "NOTIFICATIONPLACE"
    NotificationPlace.Active = true
    NotificationPlace.BorderSizePixel = 0
    NotificationPlace.BackgroundColor3 = Color3.fromRGB(255,255,255)
    NotificationPlace.Size = UDim2.new(0,240,0,557)
    NotificationPlace.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
    NotificationPlace.Position = UDim2.new(0.73754,0,0,0)
    NotificationPlace.BorderColor3 = Color3.fromRGB(0,0,0)
    NotificationPlace.BackgroundTransparency = 1
    local uiListNotifs = Instance.new("UIListLayout", NotificationPlace)
    uiListNotifs.Padding = UDim.new(0,3)
    uiListNotifs.SortOrder = Enum.SortOrder.LayoutOrder

    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Title = Title,
        TabsFrame = TabsFrame,
        TabScroll = TabScroll,
        ElementScroll = ElementScroll,
        NotificationPlace = NotificationPlace
    }
end

-- Create a notification that slides in and out smoothly,
-- and gets added to the NotificationPlace scrolling frame.
function BetterUI:Notify(uiTable, notifTitle, notifText, displayTime)
    displayTime = displayTime or 3
    local notifPlace = uiTable.NotificationPlace

    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(1,0,0,60)
    notification.BackgroundColor3 = Color3.fromRGB(40,40,40)
    notification.BackgroundTransparency = 0.2
    notification.BorderSizePixel = 0
    local notifCorner = Instance.new("UICorner", notification)
    notifCorner.CornerRadius = UDim.new(0,10)

    local titleLabel = Instance.new("TextLabel", notification)
    titleLabel.Size = UDim2.new(1, -10, 0, 25)
    titleLabel.Position = UDim2.new(0,5,0,0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = notifTitle or "Notification"
    titleLabel.TextColor3 = Color3.new(1,1,1)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextScaled = true

    local textLabel = Instance.new("TextLabel", notification)
    textLabel.Size = UDim2.new(1, -10, 0, 25)
    textLabel.Position = UDim2.new(0,5,0,25)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = notifText or ""
    textLabel.TextColor3 = Color3.new(1,1,1)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextScaled = true

    notification.Parent = notifPlace

    -- Slide in animation
    notification.Position = UDim2.new(1,300,0,0)
    TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(0,0,0,0)}):Play()

    task.delay(displayTime, function()
        TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(1,300,0,0)}):Play()
        task.wait(0.5)
        notification:Destroy()
    end)
end

-- Create a new tab. This adds a button to TabScroll and a container to ElementScroll.
function BetterUI:CreateTab(uiTable, tabName)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1,0,0,30)
    tabButton.BackgroundColor3 = Color3.fromRGB(35,35,35)
    tabButton.BackgroundTransparency = 0.2
    tabButton.Text = tabName or "Tab"
    tabButton.TextColor3 = Color3.new(1,1,1)
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextScaled = true
    tabButton.Parent = uiTable.TabScroll
    local btnCorner = Instance.new("UICorner", tabButton)
    btnCorner.CornerRadius = UDim.new(0,5)

    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1,0,1,0)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = uiTable.ElementScroll
    tabContainer.Visible = false

    tabButton.MouseButton1Click:Connect(function()
        for _,child in pairs(uiTable.ElementScroll:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false
            end
        end
        tabContainer.Visible = true
    end)

    local Tab = {}
    Tab.Button = tabButton
    Tab.Container = tabContainer

    function Tab:AddButton(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
        btn.BackgroundTransparency = 0.2
        btn.Text = text or "Button"
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.Gotham
        btn.TextScaled = true
        btn.Parent = tabContainer
        local btnCorner = Instance.new("UICorner", btn)
        btnCorner.CornerRadius = UDim.new(0,5)
        btn.MouseButton1Click:Connect(function()
            if callback then pcall(callback) end
        end)
    end

    function Tab:AddToggle(text, default, callback)
        local togFrame = Instance.new("Frame")
        togFrame.Size = UDim2.new(1, -10, 0, 30)
        togFrame.BackgroundTransparency = 1
        togFrame.Parent = tabContainer

        local lbl = Instance.new("TextLabel", togFrame)
        lbl.Size = UDim2.new(0.7,0,1,0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text or "Toggle"
        lbl.TextColor3 = Color3.new(1,1,1)
        lbl.Font = Enum.Font.Gotham
        lbl.TextScaled = true

        local toggleButton = Instance.new("TextButton", togFrame)
        toggleButton.Size = UDim2.new(0.3,0,1,0)
        toggleButton.Position = UDim2.new(0.7,0,0,0)
        toggleButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
        toggleButton.BackgroundTransparency = 0.2
        toggleButton.TextColor3 = Color3.new(1,1,1)
        toggleButton.Font = Enum.Font.Gotham
        toggleButton.TextScaled = true
        local togCorner = Instance.new("UICorner", toggleButton)
        togCorner.CornerRadius = UDim.new(0,5)

        local state = default or false
        toggleButton.Text = state and "ON" or "OFF"
        toggleButton.MouseButton1Click:Connect(function()
            state = not state
            toggleButton.Text = state and "ON" or "OFF"
            if callback then pcall(callback, state) end
        end)
    end

    function Tab:AddLabel(text)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -10, 0, 30)
        lbl.BackgroundTransparency = 1
        lbl.Text = text or "Label"
        lbl.TextColor3 = Color3.new(1,1,1)
        lbl.Font = Enum.Font.Gotham
        lbl.TextScaled = true
        lbl.Parent = tabContainer
    end

    return Tab
end

return BetterUI
