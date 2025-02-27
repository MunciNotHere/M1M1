--[[ 
    Roblox UI Library
    Created for smooth animations, customizable colors, tabs on the left,
    and all the UI goodness (UICorner, UIStroke, transparency, etc.).
--]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Library = {}

-- Window creator function
function Library:Window(title, mainColor, toggleKey)
    local mainColor = mainColor or Color3.fromRGB(255, 0, 0)
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LibraryUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BackgroundTransparency = 0.2
    
    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 10)
    
    local UIStroke = Instance.new("UIStroke", MainFrame)
    UIStroke.Color = mainColor
    UIStroke.Thickness = 2

    -- Title Bar
    local TitleBar = Instance.new("Frame", MainFrame)
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = mainColor
    TitleBar.BackgroundTransparency = 0.3
    
    local TitleLabel = Instance.new("TextLabel", TitleBar)
    TitleLabel.Size = UDim2.new(1, -10, 1, 0)
    TitleLabel.Position = UDim2.new(0, 5, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title or "Window"
    TitleLabel.TextColor3 = Color3.new(1,1,1)
    TitleLabel.TextScaled = true
    TitleLabel.Font = Enum.Font.Gotham

    -- Tab buttons frame (left) & Tab content frame (right)
    local TabButtonsFrame = Instance.new("Frame", MainFrame)
    TabButtonsFrame.Name = "TabButtonsFrame"
    TabButtonsFrame.Size = UDim2.new(0, 120, 1, -30)
    TabButtonsFrame.Position = UDim2.new(0, 0, 0, 30)
    TabButtonsFrame.BackgroundTransparency = 1

    local TabContentFrame = Instance.new("Frame", MainFrame)
    TabContentFrame.Name = "TabContentFrame"
    TabContentFrame.Size = UDim2.new(1, -120, 1, -30)
    TabContentFrame.Position = UDim2.new(0, 120, 0, 30)
    TabContentFrame.BackgroundTransparency = 1

    local Window = {}
    Window.ScreenGui = ScreenGui
    Window.MainFrame = MainFrame
    Window.TabButtonsFrame = TabButtonsFrame
    Window.TabContentFrame = TabContentFrame
    Window.Tabs = {}
    Window.SelectedTab = nil

    -- Tab switching
    function Window:SelectTab(tabObj)
        for _, tab in pairs(self.Tabs) do
            if tab == tabObj then
                tab.Content.Visible = true
                local tween = TweenService:Create(tab.Content, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.2})
                tween:Play()
            else
                tab.Content.Visible = false
            end
        end
        self.SelectedTab = tabObj
    end

    -- Dragging
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)

    -- Toggle UI with key press
    if toggleKey then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == toggleKey then
                MainFrame.Visible = not MainFrame.Visible
            end
        end)
    end

    -- Tab creation
    function Window:Tab(name)
        local Tab = {}

        local TabButton = Instance.new("TextButton", TabButtonsFrame)
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(20,20,20)
        TabButton.BackgroundTransparency = 0.5
        TabButton.Text = name
        TabButton.TextColor3 = Color3.new(1,1,1)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextScaled = true
        local btnCorner = Instance.new("UICorner", TabButton)
        btnCorner.CornerRadius = UDim.new(0, 5)

        local TabContent = Instance.new("ScrollingFrame", TabContentFrame)
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollBarThickness = 4
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        local UIListLayout = Instance.new("UIListLayout", TabContent)
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)

        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.Elements = {}

        TabButton.MouseButton1Click:Connect(function()
            Window:SelectTab(Tab)
            for _, btn in pairs(TabButtonsFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20,20,20)}):Play()
                end
            end
            TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundColor3 = mainColor}):Play()
        end)

        -- Button element
        function Tab:Button(text, callback)
            local btn = Instance.new("TextButton", TabContent)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
            btn.BackgroundTransparency = 0.3
            btn.Text = text
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.Gotham
            btn.TextScaled = true
            btn.AutoButtonColor = false
            local btnCorner = Instance.new("UICorner", btn)
            btnCorner.CornerRadius = UDim.new(0, 5)

            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70,70,70)}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50,50,50)}):Play()
            end)
            btn.MouseButton1Click:Connect(function() pcall(callback) end)

            table.insert(Tab.Elements, btn)
            return btn
        end

        -- Toggle element
        function Tab:Toggle(text, state, callback)
            local toggleFrame = Instance.new("Frame", TabContent)
            toggleFrame.Size = UDim2.new(1, -10, 0, 30)
            toggleFrame.BackgroundTransparency = 1

            local label = Instance.new("TextLabel", toggleFrame)
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.Text = text
            label.TextColor3 = Color3.new(1,1,1)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.Gotham
            label.TextScaled = true

            local toggleButton = Instance.new("TextButton", toggleFrame)
            toggleButton.Size = UDim2.new(0.3, -10, 0, 20)
            toggleButton.Position = UDim2.new(0.7, 10, 0, 5)
            toggleButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
            toggleButton.Text = state and "ON" or "OFF"
            toggleButton.TextColor3 = Color3.new(1,1,1)
            toggleButton.Font = Enum.Font.Gotham
            toggleButton.TextScaled = true
            toggleButton.AutoButtonColor = false
            local togCorner = Instance.new("UICorner", toggleButton)
            togCorner.CornerRadius = UDim.new(0, 5)

            local toggled = state
            toggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                toggleButton.Text = toggled and "ON" or "OFF"
                pcall(callback, toggled)
            end)

            table.insert(Tab.Elements, toggleFrame)
            return toggleButton
        end

        -- Label element
        function Tab:Label(text)
            local lbl = Instance.new("TextLabel", TabContent)
            lbl.Size = UDim2.new(1, -10, 0, 30)
            lbl.Text = text
            lbl.TextColor3 = Color3.new(1,1,1)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.Gotham
            lbl.TextScaled = true
            table.insert(Tab.Elements, lbl)
            return lbl
        end

        table.insert(Window.Tabs, Tab)
        if not Window.SelectedTab then
            Window:SelectTab(Tab)
            TabButton.BackgroundColor3 = mainColor
        end
        return Tab
    end

    return Window
end

-- Notification function
function Library:Notification(title, text, description)
    local notifGui = Instance.new("ScreenGui")
    notifGui.Name = "Notification"
    notifGui.Parent = game:GetService("CoreGui")
    
    local frame = Instance.new("Frame", notifGui)
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(0.5, -150, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.BackgroundTransparency = 0.3
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 10)
    
    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, -10, 0, 30)
    titleLabel.Position = UDim2.new(0, 5, 0, 5)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1,1,1)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextScaled = true
    
    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(1, -10, 0, 30)
    textLabel.Position = UDim2.new(0, 5, 0, 40)
    textLabel.Text = text
    textLabel.TextColor3 = Color3.new(1,1,1)
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextScaled = true
    
    delay(3, function()
        for i = 0, 1, 0.05 do
            frame.BackgroundTransparency = frame.BackgroundTransparency + 0.05
            wait(0.03)
        end
        notifGui:Destroy()
    end)
end

return Library
