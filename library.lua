local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Library = {}

function Library:Window(title, mainColor, toggleKey)
    mainColor = mainColor or Color3.fromRGB(60, 60, 60)

    local gui = Instance.new("ScreenGui")
    gui.Name = "DarkUILibrary"
    gui.Parent = game.CoreGui

    local main = Instance.new("Frame", gui)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.BackgroundTransparency = 0.2
    main.Size = UDim2.new(0,500,0,300)
    main.Position = UDim2.new(0.5, -250, 0.5, -150)

    local corner = Instance.new("UICorner", main)
    corner.CornerRadius = UDim.new(0,8)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 1.5
    stroke.Color = mainColor

    -- Title
    local titleBar = Instance.new("Frame", main)
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = mainColor
    titleBar.BackgroundTransparency = 0.2

    local tLabel = Instance.new("TextLabel", titleBar)
    tLabel.Text = title or "Dark Window"
    tLabel.Size = UDim2.new(1, -10, 1, 0)
    tLabel.Position = UDim2.new(0,5,0,0)
    tLabel.BackgroundTransparency = 1
    tLabel.TextColor3 = Color3.new(1,1,1)
    tLabel.Font = Enum.Font.GothamBold
    tLabel.TextScaled = true

    -- Tabs on the left
    local tabFrame = Instance.new("Frame", main)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Size = UDim2.new(0,120,1,-30)
    tabFrame.Position = UDim2.new(0,0,0,30)

    local contentFrame = Instance.new("Frame", main)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Size = UDim2.new(1,-120,1,-30)
    contentFrame.Position = UDim2.new(0,120,0,30)

    -- Drag
    local dragging, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if dragging then
                local delta = input.Position - dragStart
                main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end)

    -- Toggle Key
    if toggleKey then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == toggleKey then
                main.Visible = not main.Visible
            end
        end)
    end

    -- Tab system
    local window = {}
    window.gui = gui
    window.main = main
    window.tabFrame = tabFrame
    window.contentFrame = contentFrame
    window.tabs = {}
    window.currentTab = nil

    function window:Tab(tabName)
        local tabBtn = Instance.new("TextButton", tabFrame)
        tabBtn.Size = UDim2.new(1, 0, 0, 30)
        tabBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
        tabBtn.BackgroundTransparency = 0.2
        tabBtn.Text = tabName
        tabBtn.TextColor3 = Color3.new(1,1,1)
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextScaled = true

        local tabCorner = Instance.new("UICorner", tabBtn)
        tabCorner.CornerRadius = UDim.new(0,5)

        local tabContent = Instance.new("ScrollingFrame", contentFrame)
        tabContent.Size = UDim2.new(1,0,1,0)
        tabContent.Visible = false
        tabContent.ScrollBarThickness = 4
        tabContent.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout", tabContent)
        layout.Padding = UDim.new(0,5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local tabData = {}
        tabData.button = tabBtn
        tabData.content = tabContent

        tabBtn.MouseButton1Click:Connect(function()
            for _,tb in pairs(window.tabs) do
                tb.content.Visible = false
            end
            tabContent.Visible = true
            window.currentTab = tabData
        end)

        function tabData:Button(text,callback)
            local btn = Instance.new("TextButton", tabContent)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
            btn.BackgroundTransparency = 0.2
            btn.Text = text
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.Gotham
            btn.TextScaled = true

            local bCorner = Instance.new("UICorner", btn)
            bCorner.CornerRadius = UDim.new(0,5)

            btn.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end

        function tabData:Toggle(text,default,callback)
            local frame = Instance.new("Frame", tabContent)
            frame.Size = UDim2.new(1, -10, 0, 30)
            frame.BackgroundTransparency = 1

            local lbl = Instance.new("TextLabel", frame)
            lbl.Size = UDim2.new(0.7, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.TextColor3 = Color3.new(1,1,1)
            lbl.Font = Enum.Font.Gotham
            lbl.TextScaled = true

            local tog = Instance.new("TextButton", frame)
            tog.Size = UDim2.new(0.3, 0, 1, 0)
            tog.Position = UDim2.new(0.7, 0, 0, 0)
            tog.TextColor3 = Color3.new(1,1,1)
            tog.Font = Enum.Font.Gotham
            tog.TextScaled = true
            tog.BackgroundColor3 = Color3.fromRGB(45,45,45)
            tog.BackgroundTransparency = 0.2

            local tCorner = Instance.new("UICorner", tog)
            tCorner.CornerRadius = UDim.new(0,5)

            local val = default
            tog.Text = val and "ON" or "OFF"

            tog.MouseButton1Click:Connect(function()
                val = not val
                tog.Text = val and "ON" or "OFF"
                pcall(callback, val)
            end)
        end

        function tabData:Label(text)
            local lbl = Instance.new("TextLabel", tabContent)
            lbl.Size = UDim2.new(1, -10, 0, 30)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.TextColor3 = Color3.new(1,1,1)
            lbl.Font = Enum.Font.Gotham
            lbl.TextScaled = true
        end

        table.insert(window.tabs, tabData)
        if not window.currentTab then
            tabContent.Visible = true
            window.currentTab = tabData
        end
        return tabData
    end

    function window:Notification(title, text)
        local nGui = Instance.new("ScreenGui", game.CoreGui)
        local box = Instance.new("Frame", nGui)
        box.Size = UDim2.new(0,300,0,80)
        box.Position = UDim2.new(0.5, -150, 0.1, 0)
        box.BackgroundColor3 = Color3.fromRGB(30,30,30)
        box.BackgroundTransparency = 0.2

        local c = Instance.new("UICorner", box)
        c.CornerRadius = UDim.new(0,8)

        local tLabel = Instance.new("TextLabel", box)
        tLabel.Text = title
        tLabel.Size = UDim2.new(1,0,0,30)
        tLabel.BackgroundTransparency = 1
        tLabel.TextColor3 = Color3.new(1,1,1)
        tLabel.Font = Enum.Font.GothamBold
        tLabel.TextScaled = true

        local txt = Instance.new("TextLabel", box)
        txt.Text = text
        txt.Size = UDim2.new(1,0,0,30)
        txt.Position = UDim2.new(0,0,0,30)
        txt.BackgroundTransparency = 1
        txt.TextColor3 = Color3.new(1,1,1)
        txt.Font = Enum.Font.Gotham
        txt.TextScaled = true

        task.delay(3, function()
            for i=1,10 do
                box.BackgroundTransparency += 0.05
                task.wait(0.02)
            end
            nGui:Destroy()
        end)
    end

    return window
end

return Library
