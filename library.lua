local library = {}

function library:CreateWindow(title)
    local window = {}
    window.title = title or "Script Hub"
    window.tabs = {}

    -- Function to Create a Tab
    function window:CreateTab(tabName)
        local tab = {}
        tab.name = tabName
        tab.elements = {}

        -- Function to Add a Button
        function tab:CreateButton(text, callback)
            table.insert(tab.elements, { type = "Button", text = text, callback = callback })
        end

        -- Function to Add a Toggle
        function tab:CreateToggle(text, default, callback)
            table.insert(tab.elements, { type = "Toggle", text = text, state = default, callback = callback })
        end

        -- Function to Add a Color Picker
        function tab:CreateColorPicker(text, defaultColor, callback)
            table.insert(tab.elements, { type = "ColorPicker", text = text, color = defaultColor, callback = callback })
        end

        -- Store Tab
        table.insert(window.tabs, tab)
        return tab
    end

    -- Function to Change UI Color
    function window:ChangeUIColor(color)
        print("UI color changed to:", color)
    end

    return window
end

return library
