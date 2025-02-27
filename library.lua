local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- Quick blur for background
local blur = Instance.new("BlurEffect")
blur.Size = 6
blur.Parent = Lighting

local EZUI = {}

function EZUI:CreateWindow(title, color, toggleKey)
    color = color or Color3.fromRGB(60,60,60)
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "EZUI_Library"
    gui.Parent = game.CoreGui

    local Main = Instance.new("Frame", gui)
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 500, 0, 300)
    Main.Position = UDim2.new(0.5, -250, 0.5, -150)
    Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Main.BackgroundTransparency = 0.2

    local corner = Instance.new("UICorner", Main)
    corner.CornerRadius = UDim.new(0, 10)

    -- Title
    local Top = Instance.new("Frame", Main)
    Top.Size = UDim2.new(1, 0, 0, 30)
    Top.BackgroundColor3 = color
    Top.BackgroundTransparency = 0.2

    local Title = Instance.new("TextLabel", Top)
    Title.Text = title or "EZUI"
    Title.Size = UDim2.new(1, -10, 1, 0)
    Title.Position = UDim2.new(0,5,0,0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextScaled = true

    -- Drag
    local dragging, dragStart, startPos
    Top.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = Main.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Top.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = i.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    if toggleKey then
        UserInputService.InputBegan:Connect(function(inp, proc)
            if not proc and inp.KeyCode == toggleKey then
                Main.Visible = not Main.Visible
            end
        end)
    end

    -- Tabs
    local Tabs = Instance.new("ScrollingFrame", Main)
    Tabs.Size = UDim2.new(0,120,1,-30)
    Tabs.Position = UDim2.new(0,0,0,30)
    Tabs.BackgroundTransparency = 1
    Tabs.ScrollBarThickness = 4

    local tabList = Instance.new("UIListLayout", Tabs)
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0,5)

    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1,-120,1,-30)
    Content.Position = UDim2.new(0,120,0,30)
    Content.BackgroundTransparency = 1

    local windowObj = {}
    windowObj.Main = Main
    windowObj.Tabs = {}

    function windowObj:CreateTab(tabName)
        local tabBtn = Instance.new("TextButton", Tabs)
        tabBtn.Size = UDim2.new(1,0,0,30)
        tabBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
        tabBtn.BackgroundTransparency = 0.2
        tabBtn.Text = tabName
        tabBtn.TextColor3 = Color3.new(1,1,1)
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextScaled = true

        local tCorner = Instance.new("UICorner", tabBtn)
        tCorner.CornerRadius = UDim.new(0,5)

        local tabContent = Instance.new("ScrollingFrame", Content)
        tabContent.Visible = false
        tabContent.Size = UDim2.new(1,0,1,0)
        tabContent.ScrollBarThickness = 4
        tabContent.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout", tabContent)
        layout.Padding = UDim.new(0,5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local tabObj = {}
        tabObj.Content = tabContent

        tabBtn.MouseButton1Click:Connect(function()
            for _,v in pairs(Content:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            tabContent.Visible = true
        end)

        function tabObj:Button(txt,callback)
            local b = Instance.new("TextButton", tabContent)
            b.Size = UDim2.new(1,-10,0,30)
            b.BackgroundColor3 = Color3.fromRGB(45,45,45)
            b.BackgroundTransparency = 0.2
            b.Text = txt
            b.TextColor3 = Color3.new(1,1,1)
            b.Font = Enum.Font.Gotham
            b.TextScaled = true

            local bC = Instance.new("UICorner", b)
            bC.CornerRadius = UDim.new(0,5)

            b.MouseButton1Click:Connect(function()
                if callback then pcall(callback) end
            end)
        end

        function tabObj:Toggle(txt,default,callback)
            local f = Instance.new("Frame", tabContent)
            f.Size = UDim2.new(1,-10,0,30)
            f.BackgroundTransparency = 1

            local l = Instance.new("TextLabel", f)
            l.Size = UDim2.new(0.7,0,1,0)
            l.BackgroundTransparency = 1
            l.Text = txt
            l.TextColor3 = Color3.new(1,1,1)
            l.Font = Enum.Font.Gotham
            l.TextScaled = true

            local t = Instance.new("TextButton", f)
            t.Size = UDim2.new(0.3,0,1,0)
            t.Position = UDim2.new(0.7,0,0,0)
            t.BackgroundColor3 = Color3.fromRGB(45,45,45)
            t.BackgroundTransparency = 0.2
            t.TextColor3 = Color3.new(1,1,1)
            t.Font = Enum.Font.Gotham
            t.TextScaled = true

            local c = Instance.new("UICorner", t)
            c.CornerRadius = UDim.new(0,5)

            local val = default
            t.Text = val and "ON" or "OFF"
            t.MouseButton1Click:Connect(function()
                val = not val
                t.Text = val and "ON" or "OFF"
                if callback then pcall(callback, val) end
            end)
        end

        function tabObj:Label(txt)
            local l = Instance.new("TextLabel", tabContent)
            l.Size = UDim2.new(1,-10,0,30)
            l.BackgroundTransparency = 1
            l.Text = txt
            l.TextColor3 = Color3.new(1,1,1)
            l.Font = Enum.Font.Gotham
            l.TextScaled = true
        end

        windowObj.Tabs[tabName] = tabObj
        return tabObj
    end

    function windowObj:Notify(nTitle, nText)
        local nGui = Instance.new("ScreenGui", game.CoreGui)
        nGui.Name = "EZUI_Notification"

        local nFrame = Instance.new("Frame", nGui)
        nFrame.Size = UDim2.new(0,300,0,80)
        nFrame.Position = UDim2.new(1,300,0.8,0)
        nFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
        nFrame.BackgroundTransparency = 0.2

        local nc = Instance.new("UICorner", nFrame)
        nc.CornerRadius = UDim.new(0,10)

        local t1 = Instance.new("TextLabel", nFrame)
        t1.Size = UDim2.new(1,0,0,30)
        t1.BackgroundTransparency = 1
        t1.Text = nTitle
        t1.TextColor3 = Color3.new(1,1,1)
        t1.Font = Enum.Font.GothamBold
        t1.TextScaled = true

        local t2 = Instance.new("TextLabel", nFrame)
        t2.Size = UDim2.new(1,0,0,30)
        t2.Position = UDim2.new(0,0,0,30)
        t2.BackgroundTransparency = 1
        t2.Text = nText
        t2.TextColor3 = Color3.new(1,1,1)
        t2.Font = Enum.Font.Gotham
        t2.TextScaled = true

        -- Slide in
        TweenService:Create(nFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(1, -320, 0.8, 0)}):Play()

        task.delay(3, function()
            -- Slide out
            TweenService:Create(nFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(1, 300, 0.8, 0)}):Play()
            task.wait(0.5)
            nGui:Destroy()
        end)
    end

    return windowObj
end

return EZUI
