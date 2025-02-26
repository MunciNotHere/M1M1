local library = {}

-- Create Main UI
function library:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game:GetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    mainFrame.Parent = screenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Text = title or "Script Hub"
    titleLabel.Parent = mainFrame

    -- Dragging Function
    local dragging, dragInput, startPos
    local function startDrag(input)
        dragging = true
        startPos = input.Position
    end
    local function updateDrag(input)
        if dragging then
            local delta = input.Position - startPos
            mainFrame.Position = UDim2.new(0, mainFrame.Position.X.Offset + delta.X, 0, mainFrame.Position.Y.Offset + delta.Y)
            startPos = input.Position
        end
    end
    local function stopDrag()
        dragging = false
    end
    titleLabel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            startDrag(input)
        end
    end)
    titleLabel.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            updateDrag(input)
        end
    end)
    titleLabel.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            stopDrag()
        end
    end)

    -- Store Tabs
    local tabs = {}

    -- Create Tab Function
    function library:CreateTab(tabName)
        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 0, 40)
        tabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabFrame.Parent = mainFrame

        local tabLabel = Instance.new("TextLabel")
        tabLabel.Size = UDim2.new(1, 0, 1, 0)
        tabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabLabel.Text = tabName
        tabLabel.Parent = tabFrame

        local tab = {}
        tab.elements = {}

        -- Create Button
        function tab:CreateButton(buttonText, callback)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, 0, 0, 30)
            button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Text = buttonText
            button.Parent = tabFrame
            button.MouseButton1Click:Connect(callback)
        end

        -- Create Toggle
        function tab:CreateToggle(toggleText, default, callback)
            local toggle = Instance.new("TextButton")
            toggle.Size = UDim2.new(1, 0, 0, 30)
            toggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            toggle.TextColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            toggle.Text = toggleText
            toggle.Parent = tabFrame

            local state = default
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.TextColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                callback(state)
            end)
        end

        table.insert(tabs, tab)
        return tab
    end

    return library
end

return library
