local GuiLibrary = {}

-- Create the main window
function GuiLibrary:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CustomGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Text = title or "Custom GUI"
    titleLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 24
    titleLabel.Parent = mainFrame

    -- Add a close button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 25, 0, 25)
    closeButton.Position = UDim2.new(1, -30, 0, 10)
    closeButton.Text = "X"
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Parent = mainFrame

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local tabs = {}

    -- Function to add a tab
    function GuiLibrary:AddTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.Text = tabName
        tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Parent = mainFrame

        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 1, -50)
        tabFrame.Position = UDim2.new(0, 0, 0, 50)
        tabFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
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

    -- Add more UI elements like buttons, sliders, etc., with similar enhancements...

    return GuiLibrary
end

return GuiLibrary
