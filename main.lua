-- [[ ★ PPINGYYY HUB - FULL INTEGRATED LOADER ★ ]] --
repeat task.wait() until game:IsLoaded()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- 1. ล้างของเก่า
for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end end
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "PPINGYYY_Hub_Ultimate"

-- 2. Loading Screen System (ระบบโหลดที่มึงชอบ)
local LoadingFrame = Instance.new("Frame", sg)
LoadingFrame.Size = UDim2.new(2, 0, 1.5, 0); LoadingFrame.Position = UDim2.new(-0.5, 0, -1.6, 0); LoadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0); LoadingFrame.BackgroundTransparency = 0.75; LoadingFrame.ZIndex = 999

local stars = {}
for i = 1, 80 do
    local star = Instance.new("Frame", LoadingFrame)
    local s = math.random(2, 4); star.Size = UDim2.new(0, s, 0, s); star.Position = UDim2.new(math.random(), 0, math.random(), 0); star.BackgroundColor3 = Color3.fromRGB(255, 255, 255); star.BorderSizePixel = 0; star.BackgroundTransparency = math.random(3, 8) / 10; Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)
    table.insert(stars, star)
    task.spawn(function()
        while star.Parent do
            local nextPos = UDim2.new(math.clamp(star.Position.X.Scale + (math.random(-5, 5)/100), 0, 1), 0, math.clamp(star.Position.Y.Scale + (math.random(-5, 5)/100), 0, 1), 0)
            TweenService:Create(star, TweenInfo.new(math.random(3, 6)), {Position = nextPos}):Play(); task.wait(math.random(3, 6))
        end
    end)
end

local TextLabel = Instance.new("TextLabel", LoadingFrame)
TextLabel.Size = UDim2.new(0, 500, 0, 100); TextLabel.Position = UDim2.new(0.5, -250, 0.45, 0); TextLabel.Text = "★ PPINGYYYHUB ★"; TextLabel.TextColor3 = Color3.fromRGB(0, 255, 150); TextLabel.Font = Enum.Font.GothamBold; TextLabel.TextSize = 40; TextLabel.BackgroundTransparency = 1; TextLabel.TextTransparency = 1; TweenService:Create(TextLabel, TweenInfo.new(2), {TextTransparency = 0}):Play()

task.spawn(function()
    local startPos = TextLabel.Position; local t = 0
    while TextLabel.Parent do
        t = t + RunService.RenderStepped:Wait()
        TextLabel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + math.sin(t*1.5)*8, startPos.Y.Scale, startPos.Y.Offset + math.cos(t*1.2)*12); TextLabel.Rotation = math.sin(t*1.2)*4
    end
end)

local BarBg = Instance.new("Frame", LoadingFrame); BarBg.Size = UDim2.new(0, 300, 0, 10); BarBg.Position = UDim2.new(0.5, -150, 0.6, 0); BarBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255); BarBg.BorderSizePixel = 0
local BarFill = Instance.new("Frame", BarBg); BarFill.Size = UDim2.new(0, 0, 1, 0); BarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 150); BarFill.BorderSizePixel = 0
local PercentText = Instance.new("TextLabel", BarBg); PercentText.Size = UDim2.new(1, 0, 0, 30); PercentText.Position = UDim2.new(0, 0, 1, 5); PercentText.Text = "0%"; PercentText.TextColor3 = Color3.fromRGB(255, 255, 255); PercentText.Font = Enum.Font.GothamBold; PercentText.BackgroundTransparency = 1

TweenService:Create(LoadingFrame, TweenInfo.new(3.5, Enum.EasingStyle.Quart), {Position = UDim2.new(-0.5, 0, -0.25, 0)}):Play()
TweenService:Create(BarFill, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.spawn(function() for i = 0, 100 do PercentText.Text = i .. "%"; task.wait(0.03) end end)

-- 3. จบโหลดปุ๊บ ค่อยรันสคริปต์หลักมึง
task.wait(3.5)
for i = #stars, 1, -1 do local j = math.random(i); stars[i], stars[j] = stars[j], stars[i] end
for _, star in ipairs(stars) do TweenService:Create(star, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play(); task.wait(0.005) end
TweenService:Create(LoadingFrame, TweenInfo.new(1.5, Enum.EasingStyle.Quart), {Position = UDim2.new(math.random(-1, 0), 0, 1.5, 0), BackgroundTransparency = 1}):Play()
TweenService:Create(TextLabel, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
TweenService:Create(BarBg, TweenInfo.new(1.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(BarFill, TweenInfo.new(1.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(PercentText, TweenInfo.new(1.5), {TextTransparency = 1}):Play()

task.wait(1.5); LoadingFrame:Destroy()

-- สุดท้าย: เสกสคริปต์หลักมึงขึ้นมา
loadstring(game:HttpGet("https://raw.githubusercontent.com/p54803322-coder/PPINGYYY-HUB-/refs/heads/main/main.lua"))()
