local GuiLibrary = {}

-- Create the main window
function GuiLibrary:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SpaceGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Text = title or "Space GUI"
    titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 28
    titleLabel.Parent = mainFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0, 10)
    closeButton.Text = "✖"
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 20
    closeButton.Parent = mainFrame

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local tabs = {}

    -- Function to add a tab
    function GuiLibrary:AddTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 100, 0, 40)
        tabButton.Text = tabName
        tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.SourceSansBold
        tabButton.TextSize = 20
        tabButton.Parent = mainFrame

        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 1, -50)
        tabFrame.Position = UDim2.new(0, 0, 0, 50)
        tabFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        tabFrame.Visible = false
        tabFrame.Parent = mainFrame

        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(tabs) do
                tab.Visible = false
            end
            tabFrame.Visible = true
        end)

        tabs[#tabs + 1] = tabFrame

        return tabFrame
    end

    -- Add more UI elements with a space theme...
    -- For example, buttons, sliders, etc., with glowing effects

    return GuiLibrary
end

return GuiLibrary
