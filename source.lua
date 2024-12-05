-- M1M1 Library (Complete)

local M1M1 = {}  -- Main Library Table

-- Create ScreenGui
M1M1.ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
M1M1.ScreenGui.Name = "Library"
M1M1.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Create Main Frame
M1M1.MainFrame = Instance.new("Frame")
M1M1.MainFrame.Size = UDim2.new(0, 400, 0, 600)
M1M1.MainFrame.Position = UDim2.new(0.5, -200, 0.5, -300)
M1M1.MainFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)  -- Main frame color (brighter)
M1M1.MainFrame.BackgroundTransparency = 0.8
M1M1.MainFrame.Parent = M1M1.ScreenGui

-- Add DropShadowHolder in Main
local dropShadowHolder = Instance.new("Frame")
dropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
dropShadowHolder.Position = UDim2.new(0, 0, 0, 0)
dropShadowHolder.BackgroundTransparency = 1
dropShadowHolder.Parent = M1M1.MainFrame

-- Add DropShadow Image
local dropShadow = Instance.new("ImageLabel")
dropShadow.Size = UDim2.new(1, 47, 1, 47)
dropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
dropShadow.Image = "rbxassetid://6014261993"
dropShadow.BackgroundTransparency = 1
dropShadow.Parent = dropShadowHolder

-- Create Topbar
local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(0, 398, 0, 49)
topbar.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
topbar.Position = UDim2.new(0, 0, 0, 0)
topbar.Parent = M1M1.MainFrame

-- Add UICorner to Topbar
local topbarUICorner = Instance.new("UICorner")
topbarUICorner.CornerRadius = UDim.new(0, 13)
topbarUICorner.Parent = topbar

-- Add Title to Topbar
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 0, 49)
titleLabel.Position = UDim2.new(0.5, -100, 0, 0)
titleLabel.Text = "Title"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = topbar

-- Draggable Script (for Main Frame)
local screenGui = M1M1.ScreenGui
local dragging = false
local offset
local targetPosition

local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

screenGui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		local mousePos = userInputService:GetMouseLocation()
		offset = Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenGui.Position.X.Offset, screenGui.Position.Y.Offset)
		targetPosition = screenGui.Position -- Initialize target position
	end
end)

userInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

runService.RenderStepped:Connect(function()
	if dragging then
		local mousePos = userInputService:GetMouseLocation()
		targetPosition = UDim2.new(
			screenGui.Position.X.Scale,
			mousePos.X - offset.X,
			screenGui.Position.Y.Scale,
			mousePos.Y - offset.Y
		)
	end

	-- Smoothly interpolate towards the target position
	if targetPosition then
		screenGui.Position = screenGui.Position:Lerp(targetPosition, 0.2)
	end
end)

-- Function to Add Buttons with Toggle
function M1M1:AddButton(title, callback)
	-- Button Creation
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 40)
	button.Text = title
	button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.Gotham
	button.TextSize = 18
	button.Parent = M1M1.MainFrame

	-- Add Click Event for Button
	button.MouseButton1Click:Connect(function()
		callback()
	end)
end

-- Toggle Functionality
function M1M1:AddToggle(title, defaultState, callback)
	-- Toggle Creation
	local toggleFrame = Instance.new("Frame")
	toggleFrame.Size = UDim2.new(1, 0, 0, 40)
	toggleFrame.BackgroundTransparency = 1
	toggleFrame.Parent = M1M1.MainFrame

	local toggleText = Instance.new("TextLabel")
	toggleText.Size = UDim2.new(0, 200, 0, 40)
	toggleText.Text = title
	toggleText.BackgroundTransparency = 1
	toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggleText.TextSize = 18
	toggleText.Font = Enum.Font.Gotham
	toggleText.Parent = toggleFrame

	local toggleSwitch = Instance.new("TextButton")
	toggleSwitch.Size = UDim2.new(0, 50, 0, 25)
	toggleSwitch.Position = UDim2.new(1, -60, 0, 7)
	toggleSwitch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	toggleSwitch.Text = defaultState and "On" or "Off"
	toggleSwitch.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggleSwitch.Font = Enum.Font.Gotham
	toggleSwitch.TextSize = 16
	toggleSwitch.Parent = toggleFrame

	-- Toggle Functionality
	local isOn = defaultState
	toggleSwitch.MouseButton1Click:Connect(function()
		isOn = not isOn
		toggleSwitch.Text = isOn and "On" or "Off"
		callback(isOn)
	end)
end

-- Make sure to add the library to the Player's GUI
M1M1.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
