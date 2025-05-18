local PhantomUI = {}

local function create(instance, properties)
    local obj = Instance.new(instance)
    for k, v in pairs(properties) do
        obj[k] = v
    end
    return obj
end

function PhantomUI:CreateWindow(config)
    local screenGui = create("ScreenGui", {
        Name = "PhantomUI",
        ResetOnSpawn = false,
        Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    })

    -- Welcome Frame
    local welcomeFrame = create("Frame", {
        Name = "WelcomeFrame",
        Size = UDim2.new(0, 400, 0, 200),
        Position = UDim2.new(0.5, -200, 0.5, -100),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Parent = screenGui
    })

    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = welcomeFrame})

    local rightPanel = create("Frame", {
        Name = "RightPanel",
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 0,
        Parent = welcomeFrame
    })

    local title = create("TextLabel", {
        Text = config.Name or "PhantomUI",
        Font = Enum.Font.GothamBold,
        TextSize = 26,
        Position = UDim2.new(0.25, 0, 0.2, 0),
        Size = UDim2.new(0.5, 0, 0.2, 0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(0, 0, 0),
        Parent = welcomeFrame
    })

    local desc = create("TextLabel", {
        Text = config.Description or "Welcome to PhantomUI",
        Font = Enum.Font.Gotham,
        TextSize = 18,
        Position = UDim2.new(0.25, 0, 0.5, 0),
        Size = UDim2.new(0.5, 0, 0.2, 0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(0, 0, 0),
        Parent = welcomeFrame
    })

    local logo = create("TextLabel", {
        Text = "PhantomUI",
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Position = UDim2.new(0.5, 5, 0.9, -10),
        Size = UDim2.new(0.5, -10, 0.1, 0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = rightPanel
    })

-- Fade-in
for _, obj in ipairs({welcomeFrame, title, desc, logo, rightPanel}) do
    obj.BackgroundTransparency = 1
    if obj:IsA("TextLabel") then
        obj.TextTransparency = 1
    end
    TweenService:Create(obj, TweenInfo.new(0.4), {
        BackgroundTransparency = 0,
        TextTransparency = 0
    }):Play()
end

-- Wait, then fade-out
task.delay(1.5, function()
    for _, obj in ipairs({welcomeFrame, title, desc, logo, rightPanel}) do
        TweenService:Create(obj, TweenInfo.new(0.4), {
            BackgroundTransparency = 1,
            TextTransparency = 1
        }):Play()
    end

    task.delay(0.5, function()
        welcomeFrame:Destroy()
    end)
end)


    -- Main UI
    local mainFrame = create("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.5, -300, 0.5, -200),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        Visible = true,
        Parent = screenGui
    })

    create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = mainFrame})

    local sidebar = create("Frame", {
        Size = UDim2.new(0, 150, 1, 0),
        BackgroundColor3 = Color3.new(1, 1, 1),
        Parent = mainFrame
    })

    local tabHolder = create("Frame", {
        Size = UDim2.new(1, -150, 1, 0),
        Position = UDim2.new(0, 150, 0, 0),
        BackgroundColor3 = Color3.new(0, 0, 0),
        Parent = mainFrame
    })

    local tabs = {}

    function PhantomUI:CreateTab(tabName)
        local tab = {}

        local button = create("TextButton", {
            Text = tabName,
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
            TextSize = 18,
            TextColor3 = Color3.new(0, 0, 0),
            Parent = sidebar
        })

        local content = create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible = false,
            Parent = tabHolder
        })

        local layout = create("UIListLayout", {
            Padding = UDim.new(0, 5),
            Parent = content
        })

        layout.SortOrder = Enum.SortOrder.LayoutOrder

        button.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.Content.Visible = false
            end
            content.Visible = true
        end)

        function tab:CreateButton(text, callback)
            local btn = create("TextButton", {
                Text = text,
                Size = UDim2.new(1, -10, 0, 40),
                BackgroundColor3 = Color3.new(1, 1, 1),
                Font = Enum.Font.Gotham,
                TextSize = 18,
                TextColor3 = Color3.new(0, 0, 0),
                Parent = content
            })

            create("UICorner", {Parent = btn})

            btn.MouseButton1Click:Connect(callback)
        end

        tab.Content = content
        table.insert(tabs, tab)
        return tab
    end

    return PhantomUI
end

return PhantomUI
