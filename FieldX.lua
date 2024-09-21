local GuiLibrary = {}

-- Initialize the GUI library
function GuiLibrary:CreateWindow(windowTitle)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "OrionGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    mainFrame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = windowTitle or "Orion UI"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    title.Parent = mainFrame

    local tabs = {}

    -- Tab creation
    function GuiLibrary:AddTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.Text = tabName
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.Parent = mainFrame

        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 1, -40)
        tabFrame.Position = UDim2.new(0, 0, 0, 40)
        tabFrame.BackgroundTransparency = 1
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

    -- Section creation inside tabs
    function GuiLibrary:AddSection(tabFrame, sectionTitle)
        local sectionFrame = Instance.new("Frame")
        sectionFrame.Size = UDim2.new(1, -20, 0, 100)
        sectionFrame.Position = UDim2.new(0, 10, 0, 10)
        sectionFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        sectionFrame.Parent = tabFrame

        local sectionTitleLabel = Instance.new("TextLabel")
        sectionTitleLabel.Size = UDim2.new(1, 0, 0, 30)
        sectionTitleLabel.Text = sectionTitle or "Section"
        sectionTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        sectionTitleLabel.BackgroundTransparency = 1
        sectionTitleLabel.Parent = sectionFrame

        return sectionFrame
    end

    -- Add button element
    function GuiLibrary:AddButton(sectionFrame, buttonText, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -10, 0, 30)
        button.Position = UDim2.new(0, 5, 0, 35)
        button.Text = buttonText or "Button"
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Parent = sectionFrame

        button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
    end

    -- Add label element
    function GuiLibrary:AddLabel(sectionFrame, labelText)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 30)
        label.Position = UDim2.new(0, 5, 0, 70)
        label.Text = labelText or "Label"
        label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Parent = sectionFrame
    end

    -- Add slider element
    function GuiLibrary:AddSlider(sectionFrame, sliderText, min, max, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, -10, 0, 30)
        sliderFrame.Position = UDim2.new(0, 5, 0, 105)
        sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        sliderFrame.Parent = sectionFrame

        local sliderLabel = Instance.new("TextLabel")
        sliderLabel.Size = UDim2.new(0.5, -5, 1, 0)
        sliderLabel.Text = sliderText or "Slider"
        sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        sliderLabel.BackgroundTransparency = 1
        sliderLabel.Parent = sliderFrame

        local sliderButton = Instance.new("TextButton")
        sliderButton.Size = UDim2.new(0.5, 0, 1, 0)
        sliderButton.Position = UDim2.new(0.5, 0, 0, 0)
        sliderButton.Text = tostring(min or 0)
        sliderButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        sliderButton.Parent = sliderFrame

        local dragging = false
        sliderButton.MouseButton1Down:Connect(function()
            dragging = true
        end)
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local relativePos = math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * relativePos)
                sliderButton.Text = tostring(value)
                if callback then callback(value) end
            end
        end)
    end

    -- Add color picker
    function GuiLibrary:AddColorPicker(sectionFrame, pickerText, defaultColor, callback)
        local pickerFrame = Instance.new("Frame")
        pickerFrame.Size = UDim2.new(1, -10, 0, 30)
        pickerFrame.Position = UDim2.new(0, 5, 0, 140)
        pickerFrame.BackgroundColor3 = defaultColor or Color3.fromRGB(255, 0, 0)
        pickerFrame.Parent = sectionFrame

        local pickerLabel = Instance.new("TextLabel")
        pickerLabel.Size = UDim2.new(0.5, -5, 1, 0)
        pickerLabel.Text = pickerText or "Color Picker"
        pickerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        pickerLabel.BackgroundTransparency = 1
        pickerLabel.Parent = pickerFrame

        pickerFrame.MouseButton1Click:Connect(function()
            local picker = Instance.new("Color3Value")
            picker.Value = defaultColor or Color3.fromRGB(255, 0, 0)
            if callback then callback(picker.Value) end
        end)
    end

    return GuiLibrary
end

-- Example usage
-- This will be commented out when hosted, for testing purposes only
-- local window = GuiLibrary:CreateWindow("My Orion-Like GUI")
-- local tab1 = GuiLibrary:AddTab("Main")
-- local section1 = GuiLibrary:AddSection(tab1, "Controls")
-- GuiLibrary:AddButton(section1, "Click Me!", function() print("Button clicked!") end)
-- GuiLibrary:AddLabel(section1, "This is a label")
-- GuiLibrary:AddSlider(section1, "Volume", 0, 100, function(value) print("Slider value: " .. value) end)
-- GuiLibrary:AddColorPicker(section1, "Choose Color", Color3.fromRGB(0, 255, 0), function(color) print("Color selected:", color) end)

return GuiLibrary
