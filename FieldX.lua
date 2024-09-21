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

    -- Make the main frame draggable
    local isDragging = false
    local dragStartPos = nil

    local function startDrag(input)
        isDragging = true
        dragStartPos = input.Position
    end

    local function drag(input)
        if isDragging then
            local delta = input.Position - dragStartPos
            mainFrame.Position = UDim2.new(
                mainFrame.Position.X.Scale,
                mainFrame.Position.X.Offset + delta.X,
                mainFrame.Position.Y.Scale,
                mainFrame.Position.Y.Offset + delta.Y
            )
            dragStartPos = input.Position
        end
    end

    local function endDrag()
        isDragging = false
    end

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            startDrag(input)
        end
    end)

    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            drag(input)
        end
    end)

    mainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            endDrag()
        end
    end)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Text = title or "Space GUI"
    titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 28
    titleLabel.Parent = mainFrame

    -- Close button
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

    -- Function to add dropdowns
    function GuiLibrary:AddDropdown(parent, name, options, callback)
        local dropdownButton = Instance.new("TextButton")
        dropdownButton.Size = UDim2.new(0, 200, 0, 40)
        dropdownButton.Text = name
        dropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        dropdownButton.Font = Enum.Font.SourceSans
        dropdownButton.TextSize = 18
        dropdownButton.Parent = parent

        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
        dropdownFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        dropdownFrame.Parent = parent
        dropdownFrame.Visible = false

        for _, option in pairs(options) do
            local optionButton = Instance.new("TextButton")
            optionButton.Size = UDim2.new(1, 0, 0, 30)
            optionButton.Text = option
            optionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            optionButton.Font = Enum.Font.SourceSans
            optionButton.TextSize = 16
            optionButton.Parent = dropdownFrame

            optionButton.MouseButton1Click:Connect(function()
                callback(option)
                dropdownFrame.Visible = false
            end)
        end

        dropdownButton.MouseButton1Click:Connect(function()
            dropdownFrame.Visible = not dropdownFrame.Visible
        end)
    end

    -- Function to add a slider
    function GuiLibrary:AddSlider(parent, name, min, max, callback)
        local sliderLabel = Instance.new("TextLabel")
        sliderLabel.Size = UDim2.new(0, 200, 0, 30)
        sliderLabel.Text = name
        sliderLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        sliderLabel.Font = Enum.Font.SourceSans
        sliderLabel.TextSize = 18
        sliderLabel.Parent = parent

        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, 0, 0, 20)
        sliderFrame.Position = UDim2.new(0, 0, 1, 0)
        sliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        sliderFrame.Parent = parent

        local sliderButton = Instance.new("Frame")
        sliderButton.Size = UDim2.new(0, 20, 1, 0)
        sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        sliderButton.Parent = sliderFrame

        local dragging = false

        sliderButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        sliderButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        sliderButton.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local relativeX = input.Position.X - sliderFrame.AbsolutePosition.X
                local percentage = math.clamp(relativeX / sliderFrame.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (percentage * (max - min)))
                sliderButton.Position = UDim2.new(percentage, -10, 0, 0) -- Adjust position
                callback(value)
            end
        end)
    end

    -- Function to add color picker
    function GuiLibrary:AddColorPicker(parent, name, initialColor, callback)
        local colorPickerButton = Instance.new("TextButton")
        colorPickerButton.Size = UDim2.new(0, 200, 0, 40)
        colorPickerButton.Text = name
        colorPickerButton.BackgroundColor3 = initialColor
        colorPickerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        colorPickerButton.Font = Enum.Font.SourceSans
        colorPickerButton.TextSize = 18
        colorPickerButton.Parent = parent

        colorPickerButton.MouseButton1Click:Connect(function()
            local colorPickerGui = Instance.new("ScreenGui")
            local colorFrame = Instance.new("Frame")
            colorFrame.Size = UDim2.new(0, 200, 0, 200)
            colorFrame.Position = UDim2.new(0.5, -100, 0.5, -100)
            colorFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30
            colorFrame.BackgroundTransparency = 0.5
            colorFrame.Parent = colorPickerGui

            -- Create a color wheel
            local colorWheel = Instance.new("ImageLabel")
            colorWheel.Size = UDim2.new(1, 0, 1, 0)
            colorWheel.Image = "rbxassetid://6013045921" -- Color wheel asset
            colorWheel.Parent = colorFrame

            -- Create a button to confirm color selection
            local confirmButton = Instance.new("TextButton")
            confirmButton.Size = UDim2.new(1, 0, 0, 30)
            confirmButton.Position = UDim2.new(0, 0, 1, 0)
            confirmButton.Text = "Select Color"
            confirmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
            confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            confirmButton.Font = Enum.Font.SourceSans
            confirmButton.TextSize = 18
            confirmButton.Parent = colorFrame

            colorPickerGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

            confirmButton.MouseButton1Click:Connect(function()
                local color = colorPickerButton.BackgroundColor3
                callback(color)
                colorPickerGui:Destroy()
            end)

            colorPickerGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        end)
    end

    return self
end

return GuiLibrary
            colorFrame.BackgroundTransparency = 0.5
            colorFrame.Parent = colorPickerGui

            -- Create a color wheel
            local colorWheel = Instance.new("ImageLabel")
            colorWheel.Size = UDim2.new(1, 0, 1, 0)
            colorWheel.Image = "rbxassetid://6013045921" -- Color wheel asset
            colorWheel.Parent = colorFrame

            -- Create a button to confirm color selection
            local confirmButton = Instance.new("TextButton")
            confirmButton.Size = UDim2.new(1, 0, 0, 30)
            confirmButton.Position = UDim2.new(0, 0, 1, 0)
            confirmButton.Text = "Select Color"
            confirmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
            confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            confirmButton.Font = Enum.Font.SourceSans
            confirmButton.TextSize = 18
            confirmButton.Parent = colorFrame

            colorPickerGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

            confirmButton.MouseButton1Click:Connect(function()
                local color = colorPickerButton.BackgroundColor3
                callback(color)
                colorPickerGui:Destroy()
            end)

            colorPickerGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        end)
    end

    return self
end

return GuiLibrary
