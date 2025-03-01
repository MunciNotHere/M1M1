local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local BetterUI = {}

function BetterUI:CreateUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "M1M1_UI"
    ScreenGui.Parent = PlayerGui

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(51,51,51)
    MainFrame.Size = UDim2.new(0,350,0,250)
    MainFrame.Position = UDim2.new(0.3,0,0.3,0)
    local mainCorner = Instance.new("UICorner", MainFrame)
    mainCorner.CornerRadius = UDim.new(0,20)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Name = "Title"
    Title.BorderSizePixel = 0
    Title.BackgroundColor3 = Color3.fromRGB(51,51,51)
    Title.Size = UDim2.new(1,0,0,50)
    Title.Text = "Title"
    Title.TextColor3 = Color3.fromRGB(151,151,151)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.BackgroundTransparency = 0.1
    local titleCorner = Instance.new("UICorner", Title)
    titleCorner.CornerRadius = UDim.new(0,20)

    local TabsFrame = Instance.new("Frame", MainFrame)
    TabsFrame.Name = "Tabs"
    TabsFrame.BorderSizePixel = 0
    TabsFrame.BackgroundColor3 = Color3.fromRGB(51,51,51)
    TabsFrame.Size = UDim2.new(0,115,1,-50)
    TabsFrame.Position = UDim2.new(0,0,0,50)
    TabsFrame.BackgroundTransparency = 0.1
    local tabsCorner = Instance.new("UICorner", TabsFrame)
    tabsCorner.CornerRadius = UDim.new(0,20)

    local TabScroll = Instance.new("ScrollingFrame", TabsFrame)
    TabScroll.Name = "TabScroll"
    TabScroll.Active = true
    TabScroll.Size = UDim2.new(1, -15, 1, -10)
    TabScroll.Position = UDim2.new(0,5,0,5)
    TabScroll.BackgroundTransparency = 1
    TabScroll.ScrollBarThickness = 4
    local uiListTabs = Instance.new("UIListLayout", TabScroll)
    uiListTabs.Padding = UDim.new(0,5)
    uiListTabs.SortOrder = Enum.SortOrder.LayoutOrder

    local ElementScroll = Instance.new("ScrollingFrame", MainFrame)
    ElementScroll.Name = "elementScroll"
    ElementScroll.Active = true
    ElementScroll.Size = UDim2.new(0, (350 - 115) - 10, 1, -60)
    ElementScroll.Position = UDim2.new(0,120,0,55)
    ElementScroll.BackgroundTransparency = 1
    ElementScroll.ScrollBarThickness = 4
    local uiListElem = Instance.new("UIListLayout", ElementScroll)
    uiListElem.Padding = UDim.new(0,5)
    uiListElem.SortOrder = Enum.SortOrder.LayoutOrder

    local NotificationPlace = Instance.new("ScrollingFrame", ScreenGui)
    NotificationPlace.Name = "NOTIFICATIONPLACE"
    NotificationPlace.Active = true
    NotificationPlace.Size = UDim2.new(0,240,0,300)
    NotificationPlace.Position = UDim2.new(0.75,0,0,0)
    NotificationPlace.BackgroundTransparency = 1
    NotificationPlace.ScrollBarThickness = 4
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

function BetterUI:Notify(ui, title, text, duration)
    duration = duration or 3
    local nFrame = Instance.new("Frame")
    nFrame.Size = UDim2.new(1,0,0,60)
    nFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    nFrame.BackgroundTransparency = 0.2
    local corner = Instance.new("UICorner", nFrame)
    corner.CornerRadius = UDim.new(0,10)

    local tLabel = Instance.new("TextLabel", nFrame)
    tLabel.Size = UDim2.new(1,-10,0,25)
    tLabel.Position = UDim2.new(0,5,0,0)
    tLabel.BackgroundTransparency = 1
    tLabel.Text = title or "Notification"
    tLabel.TextColor3 = Color3.new(1,1,1)
    tLabel.Font = Enum.Font.GothamBold
    tLabel.TextSize = 14

    local desc = Instance.new("TextLabel", nFrame)
    desc.Size = UDim2.new(1,-10,0,25)
    desc.Position = UDim2.new(0,5,0,25)
    desc.BackgroundTransparency = 1
    desc.Text = text or ""
    desc.TextColor3 = Color3.new(1,1,1)
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 13

    nFrame.Parent = ui.NotificationPlace
    nFrame.Position = UDim2.new(1,300,0,0)
    TweenService:Create(nFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(0,0,0,0)}):Play()

    task.delay(duration, function()
        TweenService:Create(nFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(1,300,0,0)}):Play()
        task.wait(0.5)
        nFrame:Destroy()
    end)
end

function BetterUI:CreateTab(ui, tabName)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1,0,0,30)
    tabBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    tabBtn.BackgroundTransparency = 0.2
    tabBtn.Text = tabName or "Tab"
    tabBtn.TextColor3 = Color3.new(1,1,1)
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.TextSize = 14
    tabBtn.Parent = ui.TabScroll
    local btnCorner = Instance.new("UICorner", tabBtn)
    btnCorner.CornerRadius = UDim.new(0,5)

    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1,0,1,0)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Visible = false
    tabContainer.Parent = ui.ElementScroll

    tabBtn.MouseButton1Click:Connect(function()
        for _,child in pairs(ui.ElementScroll:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false
            end
        end
        tabContainer.Visible = true
    end)

    local Tab = {}
    Tab.Container = tabContainer

    function Tab:AddButton(txt, callback)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, -10, 0, 30)
        b.BackgroundColor3 = Color3.fromRGB(45,45,45)
        b.BackgroundTransparency = 0.2
        b.Text = txt or "Button"
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.Gotham
        b.TextSize = 14
        b.Parent = tabContainer
        local bc = Instance.new("UICorner", b)
        bc.CornerRadius = UDim.new(0,5)

        b.MouseButton1Click:Connect(function()
            if callback then pcall(callback) end
        end)
    end

    function Tab:AddToggle(txt, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -10, 0, 30)
        frame.BackgroundTransparency = 1
        frame.Parent = tabContainer

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.7,0,1,0)
        label.BackgroundTransparency = 1
        label.Text = txt or "Toggle"
        label.TextColor3 = Color3.new(1,1,1)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14

        local toggleBtn = Instance.new("TextButton", frame)
        toggleBtn.Size = UDim2.new(0.3,0,1,0)
        toggleBtn.Position = UDim2.new(0.7,0,0,0)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
        toggleBtn.BackgroundTransparency = 0.2
        toggleBtn.TextColor3 = Color3.new(1,1,1)
        toggleBtn.Font = Enum.Font.Gotham
        toggleBtn.TextSize = 14
        local tCorner = Instance.new("UICorner", toggleBtn)
        tCorner.CornerRadius = UDim.new(0,5)

        local state = default or false
        toggleBtn.Text = state and "ON" or "OFF"
        toggleBtn.MouseButton1Click:Connect(function()
            state = not state
            toggleBtn.Text = state and "ON" or "OFF"
            if callback then pcall(callback, state) end
        end)
    end

    function Tab:AddLabel(txt)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 30)
        label.BackgroundTransparency = 1
        label.Text = txt or "Label"
        label.TextColor3 = Color3.new(1,1,1)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = tabContainer
    end

    return Tab
end

return BetterUI
