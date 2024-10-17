--if you steal this then credit me

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

function Init()
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
end

function Test()
    print(Fluent.Options)
end

Init()
Test()

local Window = Fluent:CreateWindow({
    Title = "M1M1: MM2 " .. Fluent.Version,
    SubTitle = "by muncinotherexd ( discord )",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

-- Fluent provides Lucide Icons, they are optional
local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "" }),
    Game = Window:AddTab({ Title = "Game", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

local Section = Tabs.Info:AddSection("yap yap")

Tabs.Info:AddParagraph({
    Title = "Yap Yap",
    Content = "Hey this is munci use this script how you want idc tbh"
})

Tabs.Info:AddButton({
    Title = "Discord Invite",
    Description = "Copy Discord Invite Link",
    Callback = function()
            if setclipboard then setclipboard("https://discord.gg/7gdsaRCJMc") end
                print("Copied In Clipboard")


    end
})

local Section = Tabs.Game:AddSection("Visuals")

Tabs.Game:AddButton({
    Title = "MM2 Aura",
    Description = "Adds a highlighter with the color of what every player in the game is",
    Callback = function()
            --[[
    Credits to Kiriot22 for the Role getter <3
        - poorly coded by FeIix <3
]]

-- > Declarations < --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local roles

-- > Functions <--

function CreateHighlight() -- make any new highlights for new players
	for i, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and not v.Character:FindFirstChild("Highlight") then
			Instance.new("Highlight", v.Character)           
		end
	end
end

function UpdateHighlights() -- Get Current Role Colors (messy)
	for _, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and v.Character:FindFirstChild("Highlight") then
			Highlight = v.Character:FindFirstChild("Highlight")
			if v.Name == Sheriff and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(0, 0, 225)
			elseif v.Name == Murder and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(225, 0, 0)
			elseif v.Name == Hero and IsAlive(v) and not IsAlive(game.Players[Sheriff]) then
				Highlight.FillColor = Color3.fromRGB(255, 250, 0)
			else
				Highlight.FillColor = Color3.fromRGB(0, 225, 0)
			end
		end
	end
end	

function IsAlive(Player) -- Simple sexy function
	for i, v in pairs(roles) do
		if Player.Name == i then
			if not v.Killed and not v.Dead then
				return true
			else
				return false
			end
		end
	end
end


-- > Loops < --

RunService.RenderStepped:connect(function()
	roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
	for i, v in pairs(roles) do
		if v.Role == "Murderer" then
			Murder = i
		elseif v.Role == 'Sheriff'then
			Sheriff = i
		elseif v.Role == 'Hero'then
			Hero = i
		end
	end
	CreateHighlight()
	UpdateHighlights()
end)
    end
})


local Section = Tabs.Game:AddSection("Character")

Tabs.Game:AddButton({
    Title = "Noclip",
    Description = "Gives you an other gui that lets you choose from on and off",
    Callback = function()
            local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Noclip = Instance.new("ScreenGui")
local BG = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local StatusPF = Instance.new("TextLabel")
local Status = Instance.new("TextLabel")
local Credit = Instance.new("TextLabel")
local Plr = Players.LocalPlayer
local Clipon = false

Noclip.Name = "Noclip"
Noclip.Parent = game.CoreGui

BG.Name = "BG"
BG.Parent = Noclip
BG.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
BG.BorderColor3 = Color3.new(0.0588235, 0.0588235, 0.0588235)
BG.BorderSizePixel = 2
BG.Position = UDim2.new(0.149479166, 0, 0.82087779, 0)
BG.Size = UDim2.new(0, 210, 0, 127)
BG.Active = true
BG.Draggable = true

Title.Name = "Title"
Title.Parent = BG
Title.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
Title.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
Title.BorderSizePixel = 2
Title.Size = UDim2.new(0, 210, 0, 33)
Title.Font = Enum.Font.Highway
Title.Text = "Noclip"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.FontSize = Enum.FontSize.Size32
Title.TextSize = 30
Title.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Title.TextStrokeTransparency = 0

Toggle.Parent = BG
Toggle.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
Toggle.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
Toggle.BorderSizePixel = 2
Toggle.Position = UDim2.new(0.152380958, 0, 0.374192119, 0)
Toggle.Size = UDim2.new(0, 146, 0, 36)
Toggle.Font = Enum.Font.Highway
Toggle.FontSize = Enum.FontSize.Size28
Toggle.Text = "Toggle"
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.TextSize = 25
Toggle.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Toggle.TextStrokeTransparency = 0

StatusPF.Name = "StatusPF"
StatusPF.Parent = BG
StatusPF.BackgroundColor3 = Color3.new(1, 1, 1)
StatusPF.BackgroundTransparency = 1
StatusPF.Position = UDim2.new(0.314285725, 0, 0.708661377, 0)
StatusPF.Size = UDim2.new(0, 56, 0, 20)
StatusPF.Font = Enum.Font.Highway
StatusPF.FontSize = Enum.FontSize.Size24
StatusPF.Text = "Status:"
StatusPF.TextColor3 = Color3.new(1, 1, 1)
StatusPF.TextSize = 20
StatusPF.TextStrokeColor3 = Color3.new(0.333333, 0.333333, 0.333333)
StatusPF.TextStrokeTransparency = 0
StatusPF.TextWrapped = true

Status.Name = "Status"
Status.Parent = BG
Status.BackgroundColor3 = Color3.new(1, 1, 1)
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0.580952346, 0, 0.708661377, 0)
Status.Size = UDim2.new(0, 56, 0, 20)
Status.Font = Enum.Font.Highway
Status.FontSize = Enum.FontSize.Size14
Status.Text = "off"
Status.TextColor3 = Color3.new(0.666667, 0, 0)
Status.TextScaled = true
Status.TextSize = 14
Status.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Status.TextWrapped = true
Status.TextXAlignment = Enum.TextXAlignment.Left

Credit.Name = "Credit"
Credit.Parent = BG
Credit.BackgroundColor3 = Color3.new(1, 1, 1)
Credit.BackgroundTransparency = 1
Credit.Position = UDim2.new(0.195238099, 0, 0.866141737, 0)
Credit.Size = UDim2.new(0, 128, 0, 17)
Credit.Font = Enum.Font.SourceSans
Credit.FontSize = Enum.FontSize.Size18
Credit.Text = "epic script"
Credit.TextColor3 = Color3.new(1, 1, 1)
Credit.TextSize = 16
Credit.TextStrokeColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Credit.TextStrokeTransparency = 0
Credit.TextWrapped = true

Toggle.MouseButton1Click:connect(function()
	if Status.Text == "off" then
		Clipon = true
		Status.Text = "on"
		Status.TextColor3 = Color3.new(0,185,0)
		Stepped = game:GetService("RunService").Stepped:Connect(function()
			if not Clipon == false then
				for a, b in pairs(Workspace:GetChildren()) do
                if b.Name == Plr.Name then
                for i, v in pairs(Workspace[Plr.Name]:GetChildren()) do
                if v:IsA("BasePart") then
                v.CanCollide = false
                end end end end
			else
				Stepped:Disconnect()
			end
		end)
	elseif Status.Text == "on" then
		Clipon = false
		Status.Text = "off"
		Status.TextColor3 = Color3.new(170,0,0)
                    end
                end)
        end
})

Tabs.Game:AddButton({
    Title = "God Mode",
    Description = "you cant die",
    Callback = function()
			local Cam = workspace.CurrentCamera
			local Pos, Char = Cam.CFrame, localplayer.Character
			local Human = Char and Char.FindFirstChildWhichIsA(Char, "Humanoid")
			local nHuman = Human.Clone(Human)
			nHuman.Parent, localplayer.Character = Char, nil
			nHuman.SetStateEnabled(nHuman, 15, false)
			nHuman.SetStateEnabled(nHuman, 1, false)
			nHuman.SetStateEnabled(nHuman, 0, false)
			nHuman.BreakJointsOnDeath, Human = true, Human.Destroy(Human)
			localplayer.Character, Cam.CameraSubject, Cam.CFrame = Char, nHuman, wait() and Pos
			nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			local Script = Char.FindFirstChild(Char, "Animate")
			if Script then
				Script.Disabled = true
				wait()
				Script.Disabled = false
			end
			nHuman.Health = nHuman.MaxHealth
    end
})

local Slider = Tabs.Game:AddSlider("Slider", 
{
    Title = "Speed Slider",
    Description = "This is a speed slider",
    Default = 16,
    Min = 0,
    Max = 50,
    Rounding = 1,
    Callback = function(Value)
        print("Slider was changed:", Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
    end
})

local Slider = Tabs.Game:AddSlider("Slider", 
{
    Title = "Jump Slider",
    Description = "This is a jump slider",
    Default = 50,
    Min = 0,
    Max = 300,
    Rounding = 1,
    Callback = function(Value)
        print("Slider was changed:", Value)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
    end
})


local Section = Tabs.Game:AddSection("Other")

Tabs.Game:AddButton({
    Title = "Infinite Yeild",
    Description = "Universal admin script",
    Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

local Section = Tabs.Game:AddSection("Winning")

Tabs.Game:AddButton({
    Title = "TP to gun",
    Description = "teleport",
    Callback = function()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Function to search for the "GunDrop" part in all models
local function findGunDrop()
    for _, object in pairs(game.Workspace:GetChildren()) do
        if object:IsA("Model") then
            local gunDrop = object:FindFirstChild("GunDrop")
            if gunDrop then
                return gunDrop
            end
        end
    end
    return nil
end

local targetPart = findGunDrop()

if character and targetPart then
    -- Save the player's current position
    local lastPosition = character.HumanoidRootPart.Position
    
    -- Teleport to GunDrop
    character:MoveTo(targetPart.Position)
    
    -- Wait 0.1 second, then teleport back to the last position
    wait(0.1)
    character:MoveTo(lastPosition)
end

    end
})

Tabs.Game:AddButton({
    Title = "Aimbot",
    Description = "AIM",
    Callback = function()
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

function Init()
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
end

function Test()
    print(Fluent.Options)
end

Init()
Test()

local Window = Fluent:CreateWindow({
    Title = "M1M1: MM2 " .. Fluent.Version,
    SubTitle = "by muncinotherexd ( discord )",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

-- Fluent provides Lucide Icons, they are optional
local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "" }),
    Game = Window:AddTab({ Title = "Game", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

local Section = Tabs.Info:AddSection("yap yap")

Tabs.Info:AddParagraph({
    Title = "Yap Yap",
    Content = "Hey this is munci use this script how you want idc tbh"
})

Tabs.Info:AddButton({
    Title = "Discord Invite",
    Description = "Copy Discord Invite Link",
    Callback = function()
            if setclipboard then setclipboard("https://discord.gg/7gdsaRCJMc") end
                print("Copied In Clipboard")


    end
})

local Section = Tabs.Game:AddSection("Visuals")

Tabs.Game:AddButton({
    Title = "MM2 Aura",
    Description = "Adds a highlighter with the color of what every player in the game is",
    Callback = function()
            --[[
    Credits to Kiriot22 for the Role getter <3
        - poorly coded by FeIix <3
]]

-- > Declarations < --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local roles

-- > Functions <--

function CreateHighlight() -- make any new highlights for new players
	for i, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and not v.Character:FindFirstChild("Highlight") then
			Instance.new("Highlight", v.Character)           
		end
	end
end

function UpdateHighlights() -- Get Current Role Colors (messy)
	for _, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and v.Character:FindFirstChild("Highlight") then
			Highlight = v.Character:FindFirstChild("Highlight")
			if v.Name == Sheriff and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(0, 0, 225)
			elseif v.Name == Murder and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(225, 0, 0)
			elseif v.Name == Hero and IsAlive(v) and not IsAlive(game.Players[Sheriff]) then
				Highlight.FillColor = Color3.fromRGB(255, 250, 0)
			else
				Highlight.FillColor = Color3.fromRGB(0, 225, 0)
			end
		end
	end
end	

function IsAlive(Player) -- Simple sexy function
	for i, v in pairs(roles) do
		if Player.Name == i then
			if not v.Killed and not v.Dead then
				return true
			else
				return false
			end
		end
	end
end


-- > Loops < --

RunService.RenderStepped:connect(function()
	roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
	for i, v in pairs(roles) do
		if v.Role == "Murderer" then
			Murder = i
		elseif v.Role == 'Sheriff'then
			Sheriff = i
		elseif v.Role == 'Hero'then
			Hero = i
		end
	end
	CreateHighlight()
	UpdateHighlights()
end)
    end
})


local Section = Tabs.Game:AddSection("Character")

Tabs.Game:AddButton({
    Title = "Noclip",
    Description = "Gives you an other gui that lets you choose from on and off",
    Callback = function()
            local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Noclip = Instance.new("ScreenGui")
local BG = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local StatusPF = Instance.new("TextLabel")
local Status = Instance.new("TextLabel")
local Credit = Instance.new("TextLabel")
local Plr = Players.LocalPlayer
local Clipon = false

Noclip.Name = "Noclip"
Noclip.Parent = game.CoreGui

BG.Name = "BG"
BG.Parent = Noclip
BG.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
BG.BorderColor3 = Color3.new(0.0588235, 0.0588235, 0.0588235)
BG.BorderSizePixel = 2
BG.Position = UDim2.new(0.149479166, 0, 0.82087779, 0)
BG.Size = UDim2.new(0, 210, 0, 127)
BG.Active = true
BG.Draggable = true

Title.Name = "Title"
Title.Parent = BG
Title.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
Title.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
Title.BorderSizePixel = 2
Title.Size = UDim2.new(0, 210, 0, 33)
Title.Font = Enum.Font.Highway
Title.Text = "Noclip"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.FontSize = Enum.FontSize.Size32
Title.TextSize = 30
Title.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Title.TextStrokeTransparency = 0

Toggle.Parent = BG
Toggle.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
Toggle.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
Toggle.BorderSizePixel = 2
Toggle.Position = UDim2.new(0.152380958, 0, 0.374192119, 0)
Toggle.Size = UDim2.new(0, 146, 0, 36)
Toggle.Font = Enum.Font.Highway
Toggle.FontSize = Enum.FontSize.Size28
Toggle.Text = "Toggle"
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.TextSize = 25
Toggle.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Toggle.TextStrokeTransparency = 0

StatusPF.Name = "StatusPF"
StatusPF.Parent = BG
StatusPF.BackgroundColor3 = Color3.new(1, 1, 1)
StatusPF.BackgroundTransparency = 1
StatusPF.Position = UDim2.new(0.314285725, 0, 0.708661377, 0)
StatusPF.Size = UDim2.new(0, 56, 0, 20)
StatusPF.Font = Enum.Font.Highway
StatusPF.FontSize = Enum.FontSize.Size24
StatusPF.Text = "Status:"
StatusPF.TextColor3 = Color3.new(1, 1, 1)
StatusPF.TextSize = 20
StatusPF.TextStrokeColor3 = Color3.new(0.333333, 0.333333, 0.333333)
StatusPF.TextStrokeTransparency = 0
StatusPF.TextWrapped = true

Status.Name = "Status"
Status.Parent = BG
Status.BackgroundColor3 = Color3.new(1, 1, 1)
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0.580952346, 0, 0.708661377, 0)
Status.Size = UDim2.new(0, 56, 0, 20)
Status.Font = Enum.Font.Highway
Status.FontSize = Enum.FontSize.Size14
Status.Text = "off"
Status.TextColor3 = Color3.new(0.666667, 0, 0)
Status.TextScaled = true
Status.TextSize = 14
Status.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Status.TextWrapped = true
Status.TextXAlignment = Enum.TextXAlignment.Left

Credit.Name = "Credit"
Credit.Parent = BG
Credit.BackgroundColor3 = Color3.new(1, 1, 1)
Credit.BackgroundTransparency = 1
Credit.Position = UDim2.new(0.195238099, 0, 0.866141737, 0)
Credit.Size = UDim2.new(0, 128, 0, 17)
Credit.Font = Enum.Font.SourceSans
Credit.FontSize = Enum.FontSize.Size18
Credit.Text = "epic script"
Credit.TextColor3 = Color3.new(1, 1, 1)
Credit.TextSize = 16
Credit.TextStrokeColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Credit.TextStrokeTransparency = 0
Credit.TextWrapped = true

Toggle.MouseButton1Click:connect(function()
	if Status.Text == "off" then
		Clipon = true
		Status.Text = "on"
		Status.TextColor3 = Color3.new(0,185,0)
		Stepped = game:GetService("RunService").Stepped:Connect(function()
			if not Clipon == false then
				for a, b in pairs(Workspace:GetChildren()) do
                if b.Name == Plr.Name then
                for i, v in pairs(Workspace[Plr.Name]:GetChildren()) do
                if v:IsA("BasePart") then
                v.CanCollide = false
                end end end end
			else
				Stepped:Disconnect()
			end
		end)
	elseif Status.Text == "on" then
		Clipon = false
		Status.Text = "off"
		Status.TextColor3 = Color3.new(170,0,0)
                    end
                end)
        end
})

Tabs.Game:AddButton({
    Title = "God Mode",
    Description = "you cant die",
    Callback = function()
			local Cam = workspace.CurrentCamera
			local Pos, Char = Cam.CFrame, localplayer.Character
			local Human = Char and Char.FindFirstChildWhichIsA(Char, "Humanoid")
			local nHuman = Human.Clone(Human)
			nHuman.Parent, localplayer.Character = Char, nil
			nHuman.SetStateEnabled(nHuman, 15, false)
			nHuman.SetStateEnabled(nHuman, 1, false)
			nHuman.SetStateEnabled(nHuman, 0, false)
			nHuman.BreakJointsOnDeath, Human = true, Human.Destroy(Human)
			localplayer.Character, Cam.CameraSubject, Cam.CFrame = Char, nHuman, wait() and Pos
			nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			local Script = Char.FindFirstChild(Char, "Animate")
			if Script then
				Script.Disabled = true
				wait()
				Script.Disabled = false
			end
			nHuman.Health = nHuman.MaxHealth
    end
})

local Slider = Tabs.Game:AddSlider("Slider", 
{
    Title = "Speed Slider",
    Description = "This is a speed slider",
    Default = 16,
    Min = 0,
    Max = 50,
    Rounding = 1,
    Callback = function(Value)
        print("Slider was changed:", Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
    end
})

local Slider = Tabs.Game:AddSlider("Slider", 
{
    Title = "Jump Slider",
    Description = "This is a jump slider",
    Default = 50,
    Min = 0,
    Max = 300,
    Rounding = 1,
    Callback = function(Value)
        print("Slider was changed:", Value)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
    end
})


local Section = Tabs.Game:AddSection("Other")

Tabs.Game:AddButton({
    Title = "Infinite Yeild",
    Description = "Universal admin script",
    Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

local Section = Tabs.Game:AddSection("Winning")

Tabs.Game:AddButton({
    Title = "TP to gun",
    Description = "teleport",
    Callback = function()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Function to search for the "GunDrop" part in all models
local function findGunDrop()
    for _, object in pairs(game.Workspace:GetChildren()) do
        if object:IsA("Model") then
            local gunDrop = object:FindFirstChild("GunDrop")
            if gunDrop then
                return gunDrop
            end
        end
    end
    return nil
end

local targetPart = findGunDrop()

if character and targetPart then
    -- Save the player's current position
    local lastPosition = character.HumanoidRootPart.Position
    
    -- Teleport to GunDrop
    character:MoveTo(targetPart.Position)
    
    -- Wait 0.1 second, then teleport back to the last position
    wait(0.1)
    character:MoveTo(lastPosition)
end

    end
})

Tabs.Game:AddButton({
    Title = "Aimbot",
    Description = "AIM",
    Callback = function()
-- Aim configuration
local aim_config = _G.AIMCONFIG or {
    Enabled = true,
    KeyActivation = Enum.KeyCode.Q,
    FOV = 175,
    TeamCheck = true,
    DistanceCheck = true,
    VisibleCheck = true,
    Smoothness = 0.9999,
    Prediction = {Enabled = false, Value = 0}
}
_G.AIMCONFIG = _G.AIMCONFIG or aim_config

-- Services and objects
local input_service = game:GetService("UserInputService")
local players = game:GetService("Players")
local run_service = game:GetService("RunService")
local camera = workspace.CurrentCamera
local player = players.LocalPlayer

local fovCircle = Drawing.new("Circle")
local targetBox = Drawing.new("Square")

-- Helper functions
local function is_player_valid(plr)
    local char = plr.Character
    local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
    local rootPart = char and char:FindFirstChild("HumanoidRootPart")
    return plr ~= player and char and humanoid and humanoid.Health > 0 and not char:FindFirstChildWhichIsA("ForceField") 
        and (not aim_config.TeamCheck or (plr.Neutral or plr.TeamColor ~= player.TeamColor)), rootPart
end

local function get_root_part(plr)
    return plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
end

local function in_line_of_sight(origin_pos, ...)
    return #camera:GetPartsObscuringTarget({origin_pos}, {camera, player.Character, ...}) == 0
end

local function get_prediction(part)
    return part.CFrame + Vector3.new(part.Velocity.X, math.clamp(part.Velocity.Y * 0.5, -5, 10), part.Velocity.Z) * aim_config.Prediction.Value
end

-- Get nearest player
local function get_nearest_player()
    local closest = {aimPart = nil, cursor_dist = math.huge, char_dist = math.huge}

    for _, plr in players:GetPlayers() do
        local valid, part = is_player_valid(plr)
        if valid and part then
            local screen_pos, on_screen = camera:WorldToViewportPoint(part.Position)
            local fov_dist = (input_service:GetMouseLocation() - Vector2.new(screen_pos.X, screen_pos.Y)).Magnitude
            local char_dist = (get_root_part(player).Position - part.Position).Magnitude

            if (not aim_config.VisibleCheck or (on_screen and in_line_of_sight(camera.CFrame, plr.Character))) and
               fov_dist <= aim_config.FOV and fov_dist < closest.cursor_dist and
               (not aim_config.DistanceCheck or char_dist < closest.char_dist) then
                closest = {aimPart = part, cursor_dist = fov_dist, char_dist = char_dist}
            end
        end
    end
    return closest.aimPart and closest or nil
end

-- Main loop
fovCircle.Color = Color3.fromRGB(225, 225, 225)
fovCircle.Thickness = 2
fovCircle.Transparency = 0.6
fovCircle.Visible = true

targetBox.Color = Color3.fromRGB(225, 225, 225)
targetBox.Filled = true
targetBox.Size = Vector2.new(0, 0)
targetBox.Thickness = 20
targetBox.Transparency = 0.6

run_service.PreSimulation:Connect(function()
    local nearest = get_nearest_player()
    fovCircle.Radius = aim_config.FOV
    fovCircle.Position = input_service:GetMouseLocation()

    if nearest then
        local screen_pos, on_screen = camera:WorldToViewportPoint(nearest.aimPart.Position)
        targetBox.Visible = on_screen
        targetBox.Position = Vector2.new(screen_pos.X, screen_pos.Y) - (targetBox.Size / 2)

        if input_service:IsKeyDown(aim_config.KeyActivation) then
            local target_pos = aim_config.Prediction.Enabled and get_prediction(nearest.aimPart) or nearest.aimPart.CFrame
            camera.CFrame = camera.CFrame:Lerp(CFrame.lookAt(camera.CFrame.Position, target_pos.Position), aim_config.Smoothness)
        end
    else
        targetBox.Visible = false
        targetBox.Position = Vector3.zero
    end
end)
    end
})

