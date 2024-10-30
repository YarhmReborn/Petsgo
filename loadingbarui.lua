local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.35, 0, 0.25, 0)
frame.Position = UDim2.new(0.325, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = screenGui

local frameUICorner = Instance.new("UICorner")
frameUICorner.CornerRadius = UDim.new(0.1, 0)
frameUICorner.Parent = frame

local frameGradient = Instance.new("UIGradient")
frameGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
}
frameGradient.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = CustomTitle -- Using CustomTitle here
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextScaled = true
titleLabel.Parent = frame

local loadingBarBackground = Instance.new("Frame")
loadingBarBackground.Size = UDim2.new(0.9, 0, 0.3, 0)
loadingBarBackground.Position = UDim2.new(0.05, 0, 0.55, 0)
loadingBarBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
loadingBarBackground.BorderSizePixel = 0
loadingBarBackground.Parent = frame

local loadingBarBackgroundCorner = Instance.new("UICorner")
loadingBarBackgroundCorner.CornerRadius = UDim.new(0.1, 0)
loadingBarBackgroundCorner.Parent = loadingBarBackground

local loadingBar = Instance.new("Frame")
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.Position = UDim2.new(0, 0, 0, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
loadingBar.BorderSizePixel = 0
loadingBar.Parent = loadingBarBackground

local loadingBarCorner = Instance.new("UICorner")
loadingBarCorner.CornerRadius = UDim.new(0.1, 0)
loadingBarCorner.Parent = loadingBar

local percentageText = Instance.new("TextLabel")
percentageText.Size = UDim2.new(1, 0, 1, 0)
percentageText.BackgroundTransparency = 1
percentageText.Text = "Loading 0%"
percentageText.TextColor3 = Color3.fromRGB(255, 255, 255)
percentageText.TextSize = 20
percentageText.Font = Enum.Font.GothamBold
percentageText.TextScaled = true
percentageText.Parent = loadingBarBackground

local notificationFrame = Instance.new("Frame")
notificationFrame.Size = UDim2.new(0.3, 0, 0.05, 0)
notificationFrame.Position = UDim2.new(0.35, 0, 0.8, 0)
notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
notificationFrame.BackgroundTransparency = 0.3
notificationFrame.BorderSizePixel = 0
notificationFrame.Parent = screenGui
notificationFrame.Visible = false

local notificationUICorner = Instance.new("UICorner")
notificationUICorner.CornerRadius = UDim.new(0.1, 0)
notificationUICorner.Parent = notificationFrame

local notificationText = Instance.new("TextLabel")
notificationText.Size = UDim2.new(1, 0, 1, 0)
notificationText.BackgroundTransparency = 1
notificationText.Text = ""
notificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
notificationText.TextSize = 20
notificationText.Font = Enum.Font.GothamBold
notificationText.TextScaled = true
notificationText.Parent = notificationFrame

local function vibrateFrame(targetFrame, times, intensity)
    for i = 1, times do
        targetFrame.Position = targetFrame.Position + UDim2.new(0, math.random(-intensity, intensity), 0, math.random(-intensity, intensity))
        wait(0.05)
        targetFrame.Position = targetFrame.Position - UDim2.new(0, math.random(-intensity, intensity), 0, math.random(-intensity, intensity))
        wait(0.05)
    end
end

local function fadeOutAndDestroy(targetFrame)
    for i = 0, 1, 0.05 do
        targetFrame.BackgroundTransparency = i
        loadingBarBackground.BackgroundTransparency = i
        wait(0.05)
    end
    targetFrame:Destroy()
end

local function startLoading()
    for i = 1, 100 do
        loadingBar.Size = UDim2.new(i / 100, 0, 1, 0)
        percentageText.Text = "Loading " .. i .. "%"
        wait(LoadingSpeed)

        if i == 100 then
            local success, err = pcall(function()
                loadstring(game:HttpGet(CustomScript))()
            end)

            if success then
                notificationText.Text = "Script Loaded Successfully!"
                notificationFrame.Visible = true
                vibrateFrame(frame, 10, 5)
                wait(2)
                notificationFrame.Visible = false
                fadeOutAndDestroy(frame)
            else
                notificationText.Text = "Failed to Load Scripts"
                notificationFrame.Visible = true
                wait(2)
                notificationFrame.Visible = false
            end
        end
    end
end

startLoading()
