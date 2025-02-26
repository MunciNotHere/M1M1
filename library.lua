local Library = {}

function Library:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    -- UICorner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame

    -- UIStroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1.5
    stroke.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 35)
    titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.Text = title or "🔥 Premium UI Library"
    titleLabel.Parent = mainFrame

    -- Tabs Holder
    local tabsHolder = Instance.new("Frame")
    tabsHolder.Size = UDim2.new(0, 120, 1, -35)
    tabsHolder.Position = UDim2.new(0, 0, 0, 35)
    tabsHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    tabsHolder.Parent = mainFrame

    local tabs = {}

    function Library:CreateTab(tabName)
        local tab = Instance.new("TextButton")
        tab.Size = UDim2.new(1, 0, 0, 40)
        tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        tab.TextColor3 = Color3.fromRGB(200, 200, 200)
        tab.Font = Enum.Font.GothamBold
        tab.TextSize = 14
        tab.Text = tabName
        tab.Parent = tabsHolder

        local content = Instance.new("Frame")
        content.Size = UDim2.new(1, -120, 1, -35)
        content.Position = UDim2.new(0, 120, 0, 35)
        content.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        content.Visible = false
        content.Parent = mainFrame

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = tab

        local tabStroke = Instance.new("UIStroke")
        tabStroke.Color = Color3.fromRGB(255, 255, 255)
        tabStroke.Thickness = 1
        tabStroke.Parent = tab

        local function highlightTab()
            for _, v in pairs(tabs) do
                v[1].BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                v[2].Visible = false
            end
            tab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            content.Visible = true
        end

        tab.MouseButton1Click:Connect(highlightTab)
        table.insert(tabs, {tab, content})
        if #tabs == 1 then highlightTab() end

        local elements = {}

        function elements:CreateButton(text, callback)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0.9, 0, 0, 35)
            button.Position = UDim2.new(0.05, 0, #content:GetChildren() * 0.1, 0)
            button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.Gotham
            button.TextSize = 14
            button.Text = text
            button.Parent = content

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = button

            button.MouseButton1Click:Connect(callback)
        end

        function elements:CreateToggle(text, default, callback)
            local toggle = Instance.new("Frame")
            toggle.Size = UDim2.new(0.9, 0, 0, 35)
            toggle.Position = UDim2.new(0.05, 0, #content:GetChildren() * 0.1, 0)
            toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            toggle.Parent = content

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = toggle

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.Text = text
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.BackgroundTransparency = 1
            label.Parent = toggle

            local imageButton = Instance.new("ImageButton")
            imageButton.Size = UDim2.new(0, 30, 0, 30)
            imageButton.Position = UDim2.new(0.9, -30, 0.1, 0)
            imageButton.BackgroundTransparency = 1
            imageButton.Image = default and "rbxassetid://105620223191972" or "rbxassetid://98219838597023"
            imageButton.Parent = toggle

            local state = default
            imageButton.MouseButton1Click:Connect(function()
                state = not state
                imageButton.Image = state and "rbxassetid://105620223191972" or "rbxassetid://98219838597023"
                callback(state)
            end)
        end

        return elements
    end

    return Library
end

return Library
