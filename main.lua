-- [[ ★ PPINGYYY HUB - PREMIUM LOADING SCREEN v6 ★ ]] --
local lp = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

-- ⚙️ CONFIG
local LOADING_TIME = 3.5
local PRIMARY_COLOR = Color3.fromRGB(0, 255, 130)
local PRIMARY_COLOR_LIGHT = Color3.fromRGB(120, 255, 190)
local SECONDARY_COLOR = Color3.fromRGB(100, 200, 255)
local ACCENT_COLOR = Color3.fromRGB(255, 100, 200)
local BG_COLOR = Color3.fromRGB(12, 12, 22)
local STAR_COUNT = 60
local OVERSCAN = 0.08

-- ★ ระยะตก: ใช้ pixel จริงจากความสูงจอ (viewport) คูณ 1.5 เท่า รับประกันหลุดจอทุกอุปกรณ์แน่นอน
-- (ของเดิมคำนวณจาก Scale ของกรอบเล็กๆ อย่าง TitleGroup/ProgressGroup ที่สูงแค่ 100-200px เลยตกไม่พ้นจอ)
local function GetDropDistance()
    local h = Camera and Camera.ViewportSize.Y or 1000
    return h * 1.6
end

-- ✨ ล้างของเก่า
for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do 
    if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end 
end

local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "PPINGYYY_Hub_Ultimate"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true

-- 📦 Main Loading Container — ขนาดเท่าจอจริงพอดี (เนื้อหา UI ทั้งหมดอิงตำแหน่งจากตรงนี้ จะได้ไม่ล้นขอบ)
local LoadingContainer = Instance.new("Frame", sg)
LoadingContainer.Size = UDim2.new(1, 0, 1, 0)
LoadingContainer.Position = UDim2.new(0, 0, -1, 0) -- เริ่มเหนือจอ
LoadingContainer.BackgroundTransparency = 1 -- พื้นหลังจริงย้ายไปอยู่ที่ BackgroundLayer แทน (จะได้ขยายเกินขอบได้อิสระ)
LoadingContainer.BorderSizePixel = 0
LoadingContainer.ZIndex = 999
LoadingContainer.ClipsDescendants = false

-- 🌌 BackgroundLayer: ชั้นพื้นหลัง (ขยายเกินขอบจอกันโหว่) แยกออกจากชั้นเนื้อหา UI
local BackgroundLayer = Instance.new("Frame", LoadingContainer)
BackgroundLayer.Size = UDim2.new(1 + OVERSCAN * 2, 0, 1 + OVERSCAN * 2, 0)
BackgroundLayer.Position = UDim2.new(-OVERSCAN, 0, -OVERSCAN, 0)
BackgroundLayer.BackgroundColor3 = BG_COLOR
BackgroundLayer.BackgroundTransparency = 0.65
BackgroundLayer.BorderSizePixel = 0
BackgroundLayer.ZIndex = 999
local UIGradient = Instance.new("UIGradient", BackgroundLayer)
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 24, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 25))
}
UIGradient.Rotation = 90

-- ⭐ Animated Starfield (อยู่ใน BackgroundLayer ที่ขยายเกินขอบ)
local stars = {}
local function CreateStarfield()
    for i = 1, STAR_COUNT do
        local star = Instance.new("Frame", BackgroundLayer)
        local size = math.random(1, 3)
        star.Size = UDim2.new(0, size, 0, size)
        star.Position = UDim2.new(math.random(0, 100)/100, 0, math.random(0, 100)/100, 0)
        star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        star.BorderSizePixel = 0
        star.ZIndex = 1000
        star.BackgroundTransparency = math.random(4, 8) / 10
        Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)
        table.insert(stars, star)
        task.spawn(function()
            while star.Parent do
                local moveTime = math.random(40, 80) / 10
                local newX = math.clamp(star.Position.X.Scale + (math.random(-6, 6) / 100), 0, 1)
                local newY = math.clamp(star.Position.Y.Scale + (math.random(-6, 6) / 100), 0, 1)
                TweenService:Create(star, TweenInfo.new(moveTime, Enum.EasingStyle.Sine), {
                    Position = UDim2.new(newX, 0, newY, 0),
                    BackgroundTransparency = math.random(3, 9) / 10
                }):Play()
                task.wait(moveTime)
            end
        end)
    end
end
CreateStarfield()

-- ✨ Corner glow ประดับมุม (อยู่ใน BackgroundLayer เช่นกัน)
local function CreateCornerGlow(anchorX, anchorY, posX, posY)
    local glow = Instance.new("ImageLabel", BackgroundLayer)
    glow.Size = UDim2.new(0, 500, 0, 500)
    glow.AnchorPoint = Vector2.new(anchorX, anchorY)
    glow.Position = UDim2.new(posX, 0, posY, 0)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/particles/sparkles_main.dds"
    glow.ImageColor3 = PRIMARY_COLOR
    glow.ImageTransparency = 0.85
    glow.ZIndex = 998
    return glow
end
CreateCornerGlow(0, 1, 0.05, 0.95)
CreateCornerGlow(1, 1, 0.95, 0.95)
CreateCornerGlow(0, 0, 0.05, 0.05)
CreateCornerGlow(1, 0, 0.95, 0.05)

-- 🎯 Main Title Group — ★ ตอนนี้อยู่ใน LoadingContainer ตรงๆ (ไม่ใช่ BackgroundLayer ที่ขยายเกิน) เพื่อให้ตำแหน่งอิงจอจริง ไม่ล้นขอบ
local TitleGroup = Instance.new("Frame", LoadingContainer)
TitleGroup.Size = UDim2.new(1, 0, 0, 200)
TitleGroup.Position = UDim2.new(0, 0, 0.3, 0)
TitleGroup.BackgroundTransparency = 1
TitleGroup.ZIndex = 1001

local TopLine = Instance.new("Frame", TitleGroup)
TopLine.Size = UDim2.new(0, 0, 0, 3)
TopLine.Position = UDim2.new(0.5, 0, 0, -20)
TopLine.BackgroundColor3 = PRIMARY_COLOR
TopLine.BorderSizePixel = 0
TopLine.AnchorPoint = Vector2.new(0.5, 0)

local MainTitle = Instance.new("TextLabel", TitleGroup)
MainTitle.Size = UDim2.new(0.9, 0, 0, 80)
MainTitle.Position = UDim2.new(0.05, 0, 0.15, 0)
MainTitle.Text = "★ PPINGYYY HUB ★"
MainTitle.TextColor3 = PRIMARY_COLOR
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 48
MainTitle.BackgroundTransparency = 1
MainTitle.ZIndex = 1001
MainTitle.TextTransparency = 1
local TitleAspect = Instance.new("UITextSizeConstraint", MainTitle)
TitleAspect.MinTextSize = 22
TitleAspect.MaxTextSize = 48

local TitleGlow = Instance.new("TextLabel", TitleGroup)
TitleGlow.Size = MainTitle.Size
TitleGlow.Position = MainTitle.Position
TitleGlow.Text = "★ PPINGYYY HUB ★"
TitleGlow.TextColor3 = PRIMARY_COLOR
TitleGlow.Font = Enum.Font.GothamBold
TitleGlow.TextSize = 48
TitleGlow.BackgroundTransparency = 1
TitleGlow.ZIndex = 1000
TitleGlow.TextTransparency = 0.6
local GlowAspect = Instance.new("UITextSizeConstraint", TitleGlow)
GlowAspect.MinTextSize = 22
GlowAspect.MaxTextSize = 48

local Subtitle = Instance.new("TextLabel", TitleGroup)
Subtitle.Size = UDim2.new(0.8, 0, 0, 40)
Subtitle.Position = UDim2.new(0.1, 0, 0.65, 0)
Subtitle.Text = "LOADING EXPERIENCE"
Subtitle.TextColor3 = SECONDARY_COLOR
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 18
Subtitle.BackgroundTransparency = 1
Subtitle.ZIndex = 1001
Subtitle.TextTransparency = 1
local SubAspect = Instance.new("UITextSizeConstraint", Subtitle)
SubAspect.MinTextSize = 12
SubAspect.MaxTextSize = 18

local BottomLine = Instance.new("Frame", TitleGroup)
BottomLine.Size = UDim2.new(0, 0, 0, 2)
BottomLine.Position = UDim2.new(0.5, 0, 1, 20)
BottomLine.BackgroundColor3 = ACCENT_COLOR
BottomLine.BorderSizePixel = 0
BottomLine.AnchorPoint = Vector2.new(0.5, 0)

-- 📊 Progress Bar Section — อยู่ใน LoadingContainer ตรงๆ เช่นกัน (แก้ปัญหาเปอร์เซ็นต์ล้นขอบจอ)
local ProgressGroup = Instance.new("Frame", LoadingContainer)
ProgressGroup.Size = UDim2.new(1, 0, 0, 100)
ProgressGroup.Position = UDim2.new(0, 0, 0.65, 0)
ProgressGroup.BackgroundTransparency = 1
ProgressGroup.ZIndex = 1001

local BarBg = Instance.new("Frame", ProgressGroup)
BarBg.Size = UDim2.new(0.7, 0, 0, 6) -- ลดความกว้างเล็กน้อยเพื่อเผื่อที่ให้ % ด้านขวาไม่ชนขอบ
BarBg.Position = UDim2.new(0.08, 0, 0.3, 0)
BarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
BarBg.BackgroundTransparency = 0.3
BarBg.BorderSizePixel = 0
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame", BarBg)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = PRIMARY_COLOR
BarFill.BorderSizePixel = 0
BarFill.ClipsDescendants = true
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

local FillGradient = Instance.new("UIGradient", BarFill)
FillGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, PRIMARY_COLOR),
    ColorSequenceKeypoint.new(0.5, PRIMARY_COLOR_LIGHT),
    ColorSequenceKeypoint.new(1, PRIMARY_COLOR)
}
FillGradient.Rotation = 90

local BarShine = Instance.new("Frame", BarFill)
BarShine.Size = UDim2.new(0, 30, 1, 0)
BarShine.Position = UDim2.new(0, 0, 0, 0)
BarShine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BarShine.BackgroundTransparency = 0.7
BarShine.BorderSizePixel = 0
BarShine.ZIndex = 1002

-- ★ เปอร์เซ็นต์: ใช้ AnchorPoint + ตำแหน่งแบบ Scale ล้วนๆ ชิดขวาแบบเผื่อขอบ ไม่มีทางล้นจออีกต่อไป
local PercentText = Instance.new("TextLabel", ProgressGroup)
PercentText.Size = UDim2.new(0, 70, 0, 30)
PercentText.AnchorPoint = Vector2.new(1, 0) -- ยึดขอบขวาของตัวเอง
PercentText.Position = UDim2.new(0.97, 0, 0.2, 0) -- ชิดขวาแบบเว้นขอบ 3%
PercentText.Text = "0%"
PercentText.TextColor3 = PRIMARY_COLOR
PercentText.Font = Enum.Font.GothamBold
PercentText.TextSize = 16
PercentText.TextXAlignment = Enum.TextXAlignment.Right
PercentText.BackgroundTransparency = 1
PercentText.TextTransparency = 1
PercentText.ZIndex = 1001

-- Status Pill (ข้อความ "Loading resources..." ฯลฯ)
local StatusPill = Instance.new("Frame", ProgressGroup)
StatusPill.Size = UDim2.new(0, 220, 0, 32)
StatusPill.AnchorPoint = Vector2.new(0.5, 0)
StatusPill.Position = UDim2.new(0.5, 0, 0.62, 0)
StatusPill.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
StatusPill.BackgroundTransparency = 0.35
StatusPill.ZIndex = 1000
StatusPill.Visible = false
Instance.new("UICorner", StatusPill).CornerRadius = UDim.new(1, 0)
local PillStroke = Instance.new("UIStroke", StatusPill)
PillStroke.Color = PRIMARY_COLOR
PillStroke.Transparency = 0.5
PillStroke.Thickness = 1

local StatusDot = Instance.new("Frame", StatusPill)
StatusDot.Size = UDim2.new(0, 8, 0, 8)
StatusDot.AnchorPoint = Vector2.new(0, 0.5)
StatusDot.Position = UDim2.new(0, 14, 0.5, 0)
StatusDot.BackgroundColor3 = PRIMARY_COLOR
StatusDot.BorderSizePixel = 0
Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)
local statusDotBlinking = true
task.spawn(function()
    while statusDotBlinking and StatusDot.Parent do
        TweenService:Create(StatusDot, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {BackgroundTransparency = 0.7}):Play()
        task.wait(0.6)
        TweenService:Create(StatusDot, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {BackgroundTransparency = 0}):Play()
        task.wait(0.6)
    end
end)

local StatusText = Instance.new("TextLabel", StatusPill)
StatusText.Size = UDim2.new(1, -34, 1, 0)
StatusText.Position = UDim2.new(0, 28, 0, 0)
StatusText.Text = "Initializing systems..."
StatusText.TextColor3 = SECONDARY_COLOR
StatusText.Font = Enum.Font.GothamMedium
StatusText.TextSize = 14
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.BackgroundTransparency = 1
StatusText.ZIndex = 1001
StatusText.TextTransparency = 1

-- 🎉 Welcome Text
local WelcomeText = Instance.new("TextLabel", LoadingContainer)
WelcomeText.Size = UDim2.new(0.9, 0, 0, 60)
WelcomeText.Position = UDim2.new(0.05, 0, 0.45, 0)
WelcomeText.Text = "WELCOME TO SCRIPT PPINGYYY HUB"
WelcomeText.TextColor3 = PRIMARY_COLOR
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.TextSize = 34
WelcomeText.BackgroundTransparency = 1
WelcomeText.ZIndex = 1001
WelcomeText.TextTransparency = 1
WelcomeText.TextWrapped = true
local WelcomeAspect = Instance.new("UITextSizeConstraint", WelcomeText)
WelcomeAspect.MinTextSize = 18
WelcomeAspect.MaxTextSize = 34

-- 🎬 ANIMATIONS

TweenService:Create(LoadingContainer, TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()

TweenService:Create(TopLine, TweenInfo.new(1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 220, 0, 3)}):Play()
TweenService:Create(BottomLine, TweenInfo.new(1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 160, 0, 2)}):Play()

task.delay(0.6, function()
    TweenService:Create(MainTitle, TweenInfo.new(1.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    TweenService:Create(TitleGlow, TweenInfo.new(1.2, Enum.EasingStyle.Quad), {TextTransparency = 0.6}):Play()
    TweenService:Create(Subtitle, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    TweenService:Create(PercentText, TweenInfo.new(1.2), {TextTransparency = 0}):Play()
    StatusPill.Visible = true
    StatusPill.BackgroundTransparency = 1
    TweenService:Create(StatusPill, TweenInfo.new(1.2), {BackgroundTransparency = 0.35}):Play()
    TweenService:Create(StatusText, TweenInfo.new(1.2), {TextTransparency = 0}):Play()
end)

local titleFloating = true
task.spawn(function()
    local startPos = MainTitle.Position
    local t = 0
    while titleFloating and MainTitle.Parent do
        t = t + RunService.RenderStepped:Wait()
        local floatY = math.sin(t * 1.3) * 6
        local swayX = math.sin(t * 0.8) * 10
        local rot = math.sin(t * 0.8) * 2.5
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + swayX, startPos.Y.Scale, startPos.Y.Offset + floatY)
        MainTitle.Position = newPos
        MainTitle.Rotation = rot
        TitleGlow.Position = newPos
        TitleGlow.Rotation = rot
    end
end)

TweenService:Create(BarFill, TweenInfo.new(LOADING_TIME, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()

local shineActive = true
task.spawn(function()
    while shineActive and BarFill.Parent do
        BarShine.Position = UDim2.new(0, 0, 0, 0)
        TweenService:Create(BarShine, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {Position = UDim2.new(1, 0, 0, 0)}):Play()
        task.wait(1.5)
    end
end)

task.spawn(function()
    local statusMessages = {
        "Initializing systems...",
        "Loading resources...",
        "Preparing interface...",
        "Finalizing setup...",
        "Ready to go!"
    }
    for i = 0, 100 do
        PercentText.Text = i .. "%"
        local messageIndex = math.floor((i / 100) * (#statusMessages - 1)) + 1
        StatusText.Text = statusMessages[messageIndex]
        task.wait(LOADING_TIME / 100)
    end
end)

task.wait(LOADING_TIME + 0.3)

titleFloating = false
shineActive = false
statusDotBlinking = false

-- 🍂 ตกลงไปแบบหมุน "ตกลึก" — ★ แก้แล้ว: ใช้ pixel offset จริงจากความสูงจอ รับประกันหลุดจอ 100% ไม่เหลือค้าง
local DROP_DISTANCE = GetDropDistance()

local function DropAndFade(obj, delayTime, rotationAmount, extraFadeObjs)
    task.delay(delayTime, function()
        if not obj.Parent then return end
        local goalPos = UDim2.new(
            obj.Position.X.Scale, obj.Position.X.Offset,
            obj.Position.Y.Scale, obj.Position.Y.Offset + DROP_DISTANCE
        )
        local tweenInfo = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local goals = {Position = goalPos}
        if obj:IsA("TextLabel") then
            goals.TextTransparency = 1
            goals.Rotation = (obj.Rotation or 0) + rotationAmount
        else
            goals.BackgroundTransparency = 1
            goals.Rotation = (obj.Rotation or 0) + rotationAmount
        end
        TweenService:Create(obj, tweenInfo, goals):Play()
        -- เผื่อมี object ลูกที่มี transparency ของตัวเอง (เช่น BarFill ในหลอดโหลด) ให้เฟดตามไปด้วย
        if extraFadeObjs then
            for _, extraObj in ipairs(extraFadeObjs) do
                if extraObj:IsA("TextLabel") then
                    TweenService:Create(extraObj, tweenInfo, {TextTransparency = 1}):Play()
                else
                    TweenService:Create(extraObj, tweenInfo, {BackgroundTransparency = 1}):Play()
                end
            end
        end
    end)
end

DropAndFade(MainTitle, 0, 220)
DropAndFade(TitleGlow, 0, 220)
DropAndFade(TopLine, 0.05, -60)
DropAndFade(BottomLine, 0.1, 60)
DropAndFade(Subtitle, 0.15, -30)
-- ★ หลอดโหลด: ตกพร้อมกัน + เฟด BarFill/BarShine ไปด้วย (เมื่อก่อนแค่ BarBg เฟดแต่ BarFill สีเขียวยังทึบอยู่)
DropAndFade(BarBg, 0.25, 40, {BarFill, BarShine})
DropAndFade(PercentText, 0.3, -40)
DropAndFade(StatusPill, 0.35, 30)

task.delay(1.2, function()
    TweenService:Create(WelcomeText, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
end)

task.wait(1.2 + 1.8)

TweenService:Create(WelcomeText, TweenInfo.new(1, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
TweenService:Create(BackgroundLayer, TweenInfo.new(1.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()

for i, star in ipairs(stars) do
    task.delay(i * 0.008, function()
        if star.Parent then
            TweenService:Create(star, TweenInfo.new(0.7), {BackgroundTransparency = 1}):Play()
        end
    end)
end

task.wait(1.3)
LoadingContainer:Destroy()

-- 🎮 ===== เอาสคริปต์หลักของมึงมาต่อจากตรงนี้นะ! =====
-- ตรวจสอบให้ดีว่ามี end ครบทุกฟังก์ชัน
-- [[ ★PPINGYYY HUB - FULLY FIXED VERSION ★ ]] --
local lp = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager") 

for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end end
for _, v in ipairs(lp:WaitForChild("PlayerGui"):GetChildren()) do if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end end

getgenv().NWKZ_Anchor = false getgenv().NWKZ_AutoCast = false getgenv().PP_Noclip = false getgenv().PP_WalkSpeed = 16 getgenv().PP_FishingThipActive = false
getgenv().PP_AutoSkillAll = false getgenv().PP_Skill_Z = false getgenv().PP_Skill_X = false getgenv().PP_Skill_C = false getgenv().PP_Skill_V = false
local skillKeys = {Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}

local sg = Instance.new("ScreenGui", (pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or lp:WaitForChild("PlayerGui")))
sg.Name = "PPINGYYY_Hub_Ultimate" sg.ResetOnSpawn = false

local MainSize = UDim2.new(0, 420, 0, 250) local MinimizedSize = UDim2.new(0, 420, 0, 40)
local tweenInfoMain = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local Main = Instance.new("Frame", sg) Main.Size = MainSize Main.Position = UDim2.new(0.3, 0, 0.3, 0) Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10) Instance.new("UIStroke", Main).Color = Color3.fromRGB(0, 255, 150)

local TitleBar = Instance.new("Frame", Main) TitleBar.Size = UDim2.new(1, 0, 0, 40) TitleBar.BackgroundTransparency = 1
local TitleText = Instance.new("TextLabel", TitleBar) TitleText.Size = UDim2.new(1, 0, 1, 0) TitleText.Text = "★ PPINGYYY HUB ★" TitleText.TextColor3 = Color3.fromRGB(0, 255, 150) TitleText.Font = Enum.Font.GothamBold TitleText.TextSize = 14 TitleText.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TitleBar) CloseBtn.Size = UDim2.new(0, 25, 0, 25) CloseBtn.Position = UDim2.new(0.9, 0, 0.25, 0) CloseBtn.Text = "X" CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) CloseBtn.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
local MinBtn = Instance.new("TextButton", TitleBar) MinBtn.Size = UDim2.new(0, 25, 0, 25) MinBtn.Position = UDim2.new(0.8, 0, 0.25, 0) MinBtn.Text = "—" MinBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) MinBtn.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

local Sidebar = Instance.new("Frame", Main) Sidebar.Size = UDim2.new(0, 120, 1, -40) Sidebar.Position = UDim2.new(0, 0, 0, 40) Sidebar.BackgroundTransparency = 1
local Pages = Instance.new("Frame", Main) Pages.Size = UDim2.new(1, -130, 1, -50) Pages.Position = UDim2.new(0, 125, 0, 45) Pages.BackgroundTransparency = 1

local function createTabButton(text, posIndex) local btn = Instance.new("TextButton", Sidebar) btn.Size = UDim2.new(0.85, 0, 0, 30) btn.Position = UDim2.new(0.05, 0, 0, 4 + (posIndex * 34)) btn.Text = text btn.TextColor3 = Color3.fromRGB(150, 150, 150) btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25) btn.Font = Enum.Font.GothamBold btn.TextSize = 11 Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6) return btn end
local Tab1Btn, Tab2Btn, Tab3Btn, Tab4Btn, Tab5Btn = createTabButton("🎣 ตกปลา", 0), createTabButton("⚡ สกิล", 1), createTabButton("🛠️ เครื่องมือ", 2), createTabButton("🏝️ วาร์ป", 3), createTabButton("🥷 พ่อค้าลับ", 4)

local function createPage() local page = Instance.new("ScrollingFrame", Pages) page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1 page.ScrollBarThickness = 2 page.Visible = false return page end
local Page1, Page2, Page3, Page4, Page5 = createPage(), createPage(), createPage(), createPage(), createPage()
local activePage = nil local function showPage(targetPage) if activePage then activePage.Visible = false end targetPage.Visible = true activePage = targetPage end
Tab1Btn.MouseButton1Click:Connect(function() showPage(Page1) end) 
Tab2Btn.MouseButton1Click:Connect(function() showPage(Page2) end) 
Tab3Btn.MouseButton1Click:Connect(function() showPage(Page3) end) 
Tab4Btn.MouseButton1Click:Connect(function() showPage(Page4) end)
Tab5Btn.MouseButton1Click:Connect(function() showPage(Page5) end)

local function createNormalButton(parent, text, yPos) local btn = Instance.new("TextButton", parent) btn.Size = UDim2.new(0.95, 0, 0, 32) btn.Position = UDim2.new(0.025, 0, 0, yPos) btn.Text = text btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) btn.TextColor3 = Color3.new(1, 1, 1) btn.Font = Enum.Font.GothamBold btn.TextSize = 10 Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6) return btn end

-- ==========================================================
-- 🥷 ระบบหมวดหมู่พ่อค้าลับ (Page 5)
-- ==========================================================
local MerchantTpBtn = createNormalButton(Page5, "🥷 วาปไปหาพ่อค้าลับ (Auto Scan)", 5)
MerchantTpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)

local function TeleportToSecretMerchant()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local found = false
    -- วนหา NPC พ่อค้าใน Workspace
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and (string.find(string.lower(obj.Name), "merchant") or string.find(string.lower(obj.Name), "traveling") or string.find(string.lower(obj.Name), "secret")) then
            local targetHrp = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("PrimaryPart")
            if targetHrp then
                hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, -3)
                found = true
                print("★ เจอพ่อค้าลับ! วาปสำเร็จ: " .. obj.Name)
                break
            end
        end
    end
    
    if not found then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "★ PPINGYYY HUB ★",
            Text = "ไม่พบพ่อค้าลับในเซิร์ฟ! (มันยังไม่สปอว์นหรือซ่อนอยู่)",
            Duration = 5
        })
    end
end

MerchantTpBtn.MouseButton1Click:Connect(function()
    TeleportToSecretMerchant()
end)

local CheckSpotBtn = createNormalButton(Page5, "🌊 วาปส่องจุดเกิดสำรอง (หลังน้ำตก/ถ้ำ)", 45)
CheckSpotBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)

CheckSpotBtn.MouseButton1Click:Connect(function()
    -- วาปเช็กพิกัดจุดซ่อนยอดฮิต (ปรับแก้พิกัดได้ตามจริง)
    local char = lp.Character or lp.CharacterAdded:Wait()
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(0, 50, -500) -- จุดเช็กสำรอง
    end
end)

showPage(Page1) -- เปิดมาหน้าแรกสุดไว้ก่อน

-- มึงเอาปุ่มเก่าๆ ของมึง (CastBtn, SkillBtn ฯลฯ) มาวางต่อจากตรงนี้ลงไปได้เลยเพื่อนรัก!
-- [[ ★ PPINGYYY HUB - ULTIMATE (FULL VERSION & FIXED ROCK BAR ALWAYS CENTER) ★ ]] --

-- 🛑 ระบบเช็ก UI ซ้ำ: ถ้ามีตัวเก่าเปิดอยู่แล้ว จะดีดตัวใหม่ทิ้งทันที
pcall(function()
    local coreGui = game:GetService("CoreGui")
    local players = game:GetService("Players")
    local lp = players.LocalPlayer
    local playerGui = lp and lp:FindFirstChild("PlayerGui")
    
    local existingGui = coreGui:FindFirstChild("PPINGYYY_Hub_Ultimate") or (playerGui and playerGui:FindFirstChild("PPINGYYY_Hub_Ultimate"))
    
    if existingGui then
        warn("★ [PPINGYYY] กดเบิ้ลทำไม! ตรวจพบ UI เก่าเปิดไว้อยู่แล้ว ทำการลบตัวใหม่ทิ้งด่วน!")
        error("Duplicate UI Blocked")
    end
end)

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager") 
local TweenService = game:GetService("TweenService")

print("★ [PPINGYYY] Initializing Full Hub Ultimate...")

-- ระบบลบ UI เก่าทิ้งกันซ้ำซ้อน
pcall(function()
    for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do 
        if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end 
    end
    for _, v in ipairs(lp.PlayerGui:GetChildren()) do 
        if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end 
    end
end)

getgenv().NWKZ_Anchor = false 
getgenv().NWKZ_AutoCast = false 
getgenv().PP_Noclip = false 
getgenv().PP_WalkSpeed = 46 
getgenv().PP_FishingThipActive = false
getgenv().PP_AutoSkillAll = false 
getgenv().PP_Skill_Z = false 
getgenv().PP_Skill_X = false 
getgenv().PP_Skill_C = false 
getgenv().PP_Skill_V = false

local sg = Instance.new("ScreenGui")
sg.Name = "PPINGYYY_Hub_Ultimate" 
sg.ResetOnSpawn = false
pcall(function()
    sg.Parent = game:GetService("CoreGui")
end)
if not sg.Parent then
    sg.Parent = lp:WaitForChild("PlayerGui")
end

local function createSound(id)
    local s = Instance.new("Sound", sg)
    pcall(function()
        s.SoundId = "rbxassetid://" .. id
    end)
    s.Volume = 1
    return s
end

local clickSound = createSound("140207837688369") 
local loadSound = createSound("103502836672744") 
local defaultClickSound = createSound("139719503904449") 
local skillSound = createSound("72321534878838") 
local tpSound = createSound("124934430745275") 
local speedSound = createSound("9118823292") 
local autoCastSound = createSound("119135010875996") 
local anchorSound = createSound("131661992591924") 
local deleteSound = createSound("154157386") 
local sellSound = createSound("90531793028786")

local MainSize = UDim2.new(0, 420, 0, 250) 
local MinimizedSize = UDim2.new(0, 420, 0, 40)

local Main = Instance.new("Frame", sg) 
Main.Size = MainSize 
Main.Position = UDim2.new(0.3, 0, -0.5, 0) 
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10) 
Instance.new("UIStroke", Main).Color = Color3.fromRGB(0, 255, 150)

local TitleBar = Instance.new("Frame", Main) 
TitleBar.Size = UDim2.new(1, 0, 0, 40) 
TitleBar.BackgroundTransparency = 1

-- 🖱️ ระบบลากหน้าจอ (Draggable GUI)
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local TitleText = Instance.new("TextLabel", TitleBar) 
TitleText.Size = UDim2.new(1, 0, 1, 0) 
TitleText.Text = "★ PPINGYYY HUB ULTIMATE ★" 
TitleText.TextColor3 = Color3.fromRGB(0, 255, 150) 
TitleText.Font = Enum.Font.GothamBold 
TitleText.TextSize = 14 
TitleText.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TitleBar) 
CloseBtn.Size = UDim2.new(0, 25, 0, 25) 
CloseBtn.Position = UDim2.new(0.9, 0, 0.25, 0) 
CloseBtn.Text = "X" 
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) 
CloseBtn.TextColor3 = Color3.new(1, 1, 1) 
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

local MinBtn = Instance.new("TextButton", TitleBar) 
MinBtn.Size = UDim2.new(0, 25, 0, 25) 
MinBtn.Position = UDim2.new(0.8, 0, 0.25, 0) 
MinBtn.Text = "—" 
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) 
MinBtn.TextColor3 = Color3.new(1, 1, 1) 
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

local Sidebar = Instance.new("Frame", Main) 
Sidebar.Size = UDim2.new(0, 120, 1, -40) 
Sidebar.Position = UDim2.new(0, 0, 0, 40) 
Sidebar.BackgroundTransparency = 1

local Pages = Instance.new("Frame", Main) 
Pages.Size = UDim2.new(1, -130, 1, -50) 
Pages.Position = UDim2.new(0, 125, 0, 45) 
Pages.BackgroundTransparency = 1

local tabButtons = {}
local function createTabButton(text, posIndex) 
    local btn = Instance.new("TextButton", Sidebar) 
    btn.Size = UDim2.new(0.85, 0, 0, 30) 
    btn.Position = UDim2.new(0.05, 0, 0, 4 + (posIndex * 34)) 
    btn.Text = text 
    btn.TextColor3 = Color3.fromRGB(150, 150, 150) 
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25) 
    btn.Font = Enum.Font.GothamBold 
    btn.TextSize = 11 
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6) 
    table.insert(tabButtons, btn)
    return btn 
end

local Tab1Btn = createTabButton("🎣 ตกปลา", 0)
local Tab2Btn = createTabButton("⚡ สกิล", 1)
local Tab3Btn = createTabButton("🛠️ เครื่องมือ", 2)
local Tab4Btn = createTabButton("🏝️ วาร์ป", 3)
local Tab5Btn = createTabButton("📍 พ่อค้าลับ", 4)

local function createPage() 
    local page = Instance.new("ScrollingFrame", Pages) 
    page.Size = UDim2.new(1, 0, 1, 0) 
    page.BackgroundTransparency = 1 
    page.ScrollBarThickness = 2 
    page.Visible = false 
    return page 
end

local Page1, Page2, Page3, Page4, Page5 = createPage(), createPage(), createPage(), createPage(), createPage()
local activePage = nil 

local tweenInfoTab = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local function selectTab(selectedBtn, targetPage)
    pcall(function() clickSound:Play() end)
    for _, btn in ipairs(tabButtons) do
        if btn == selectedBtn then
            TweenService:Create(btn, tweenInfoTab, {
                BackgroundColor3 = Color3.fromRGB(0, 180, 100),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Size = UDim2.new(0.92, 0, 0, 30)
            }):Play()
        else
            TweenService:Create(btn, tweenInfoTab, {
                BackgroundColor3 = Color3.fromRGB(20, 20, 25),
                TextColor3 = Color3.fromRGB(150, 150, 150),
                Size = UDim2.new(0.85, 0, 0, 30)
            }):Play()
        end
    end
    if activePage and activePage ~= targetPage then 
        activePage.Visible = false 
    end 
    targetPage.Visible = true 
    activePage = targetPage
end

Tab1Btn.MouseButton1Click:Connect(function() selectTab(Tab1Btn, Page1) end) 
Tab2Btn.MouseButton1Click:Connect(function() selectTab(Tab2Btn, Page2) end) 
Tab3Btn.MouseButton1Click:Connect(function() selectTab(Tab3Btn, Page3) end) 
Tab4Btn.MouseButton1Click:Connect(function() selectTab(Tab4Btn, Page4) end)
Tab5Btn.MouseButton1Click:Connect(function() selectTab(Tab5Btn, Page5) end)

local function createNormalButton(parent, text, yPos) 
    local btn = Instance.new("TextButton", parent) 
    btn.Size = UDim2.new(0.95, 0, 0, 32) 
    btn.Position = UDim2.new(0.025, 0, 0, yPos) 
    btn.Text = text 
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) 
    btn.TextColor3 = Color3.new(1, 1, 1) 
    btn.Font = Enum.Font.GothamBold 
    btn.TextSize = 10 
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6) 
    return btn 
end

local CastBtn = createNormalButton(Page1, "เหวี่ยงเบ็ดออโต้: OFF", 5)
local AnchorBtn = createNormalButton(Page1, "ล็อกแถบตกปลา (Rock Bar): OFF", 42)
local FishThipBtn = createNormalButton(Page1, "🟢 เปิดปิดปุ่มตกปลาทิพย์ (ขวาจอ): OFF", 79)

local SellBtn = Instance.new("TextButton", Page1)
SellBtn.Size = UDim2.new(0.95, 0, 0, 32)
SellBtn.Position = UDim2.new(0.025, 0, 0, 116)
SellBtn.Text = "💰 ขายปลาทั้งหมด"
SellBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
SellBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
SellBtn.Font = Enum.Font.GothamBold
SellBtn.TextSize = 10
Instance.new("UICorner", SellBtn).CornerRadius = UDim.new(0, 6)

local SkillAllBtn = createNormalButton(Page2, "AUTO ALL SKILLS (รวมกดทุกสกิล): OFF", 5)

local function createGridSkillBtn(keyName, posIndex, varName)
    local btn = Instance.new("TextButton", Page2)
    btn.Size = UDim2.new(0.46, 0, 0, 30)
    local xPos = (posIndex % 2 == 0) and 0.02 or 0.51
    local yPos = 45 + (math.floor(posIndex / 2) * 35)
    btn.Position = UDim2.new(xPos, 0, 0, yPos)
    btn.Text = "AUTO SKILL ["..keyName.."]: OFF"
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    btn.MouseButton1Click:Connect(function()
        pcall(function() skillSound:Play() end)
        getgenv()[varName] = not getgenv()[varName]
        btn.Text = "AUTO SKILL ["..keyName.."]: " .. (getgenv()[varName] and "ON" or "OFF")
        btn.BackgroundColor3 = getgenv()[varName] and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(40, 40, 45)
        btn.TextColor3 = getgenv()[varName] and Color3.new(1,1,1) or Color3.fromRGB(200, 200, 200)
    end)
end

createGridSkillBtn("V", 0, "PP_Skill_V")
createGridSkillBtn("Z", 1, "PP_Skill_Z")
createGridSkillBtn("X", 2, "PP_Skill_X")
createGridSkillBtn("C", 3, "PP_Skill_C")

local NoclipBtn = createNormalButton(Page3, "ทะลุกำแพง: OFF", 5)
local SpeedLabel = Instance.new("TextLabel", Page3)
SpeedLabel.Size = UDim2.new(1, -10, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 45)
SpeedLabel.Text = "ความเร็วในการเดิน: 46"
SpeedLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 11
SpeedLabel.BackgroundTransparency = 1

local SpeedUpBtn = Instance.new("TextButton", Page3)
SpeedUpBtn.Size = UDim2.new(0.46, 0, 0, 30)
SpeedUpBtn.Position = UDim2.new(0.02, 0, 0, 70)
SpeedUpBtn.Text = "เพิ่มความเร็ว (+)"
SpeedUpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedUpBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedUpBtn.Font = Enum.Font.GothamBold
SpeedUpBtn.TextSize = 10
Instance.new("UICorner", SpeedUpBtn).CornerRadius = UDim.new(0, 5)

local SpeedDownBtn = Instance.new("TextButton", Page3)
SpeedDownBtn.Size = UDim2.new(0.46, 0, 0, 30)
SpeedDownBtn.Position = UDim2.new(0.51, 0, 0, 70)
SpeedDownBtn.Text = "ลดความเร็ว (-)"
SpeedDownBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedDownBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedDownBtn.Font = Enum.Font.GothamBold
SpeedDownBtn.TextSize = 10
Instance.new("UICorner", SpeedDownBtn).CornerRadius = UDim.new(0, 5)

local FlyBtn = Instance.new("TextButton", Page3)
FlyBtn.Size = UDim2.new(0.95, 0, 0, 35)
FlyBtn.Position = UDim2.new(0.025, 0, 0, 110)
FlyBtn.Text = "เปิดเมนูบิน"
FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
FlyBtn.TextColor3 = Color3.new(1, 1, 1)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextSize = 10
Instance.new("UICorner", FlyBtn).CornerRadius = UDim.new(0, 6)

local DevTeleportBtn = Instance.new("TextButton", Page3)
DevTeleportBtn.Size = UDim2.new(0.95, 0, 0, 35)
DevTeleportBtn.Position = UDim2.new(0.025, 0, 0, 150)
DevTeleportBtn.Text = "🛠️ ใช้สำหรับคนพัฒนาสคริปteleport"
DevTeleportBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
DevTeleportBtn.TextColor3 = Color3.new(1, 1, 1)
DevTeleportBtn.Font = Enum.Font.GothamBold
DevTeleportBtn.TextSize = 10
Instance.new("UICorner", DevTeleportBtn).CornerRadius = UDim.new(0, 6)
DevTeleportBtn.MouseButton1Click:Connect(function()
    pcall(function() defaultClickSound:Play() end)
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/p54803322-coder/PPINGYYY-Teleport-XD/refs/heads/main/main.lua"))()
    end)
    DevTeleportBtn.Text = "🚀 LOADED TELEPORT SCRIPT!"
    task.wait(1)
    DevTeleportBtn.Text = "🛠️ ใช้สำหรับคนพัฒนาสคริปteleport"
end)

local function createTeleportButton(parent, name, x, y, z, yPos)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.95, 0, 0, 32)
    btn.Position = UDim2.new(0.025, 0, 0, yPos)
    btn.Text = "🏝️ " .. name
    btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        pcall(function() tpSound:Play() end)
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
        end
    end)
end

createTeleportButton(Page4, "เกาะเทพตกปลาผู้เริ่มต้น", -236, 6, 56, 5)
createTeleportButton(Page4, "เกาะไม้ไผ่", -1226, 5, -23, 42)
createTeleportButton(Page4, "เกาะหลุมขนาดใหญ่", 74, 6, 1216, 79)
createTeleportButton(Page4, "เกาะน้ำตก", -1285, 6, 1240, 116)
createTeleportButton(Page4, "เกาะปลากรายพันธุ์", -47, 9, -1337, 153)
createTeleportButton(Page4, "เกาะน้ำแข็ง", -1348, 9, -1485, 190)
createTeleportButton(Page4, "เกาะต้นมะพร้าว", 1434, 9, -1433, 227)
createTeleportButton(Page4, "เกาะแห่งฤดูใบไม้ร่วง", 1243, 6, 1393, 264)
createTeleportButton(Page4, "เกาะนักล่าบอส", 1543, 46, -51, 301)
createTeleportButton(Page4, "เกาะร้าง", 2631, 6, 60, 338)

local function createMerchantTP(name, x, y, z, yPos)
    local btn = Instance.new("TextButton", Page5)
    btn.Size = UDim2.new(0.95, 0, 0, 32)
    btn.Position = UDim2.new(0.025, 0, 0, yPos)
    btn.Text = "📍 " .. name
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        pcall(function() tpSound:Play() end)
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
        end
    end)
end

createMerchantTP("พ่อค้าลับ - จุดที่ 1", -33, 8, 1606, 5)
createMerchantTP("พ่อค้าลับ - จุดที่ 2", -1496, 9, 1134, 42)
createMerchantTP("พ่อค้าลับ - จุดที่ 3 (แก้ไขแล้ว)", -1528, 6, -1311, 79)
createMerchantTP("พ่อค้าลับ - จุดที่ 4", 1293, 8, 1428, 116)
createMerchantTP("พ่อค้าลับ - จุดที่ 5", 1592, 47, -44, 153)
createMerchantTP("พ่อค้าลับ - จุดที่ 6", -178, 6, -1268, 190)
createMerchantTP("พ่อค้าลับ - จุดที่ 7", 2861, 6, 121, 227)

local RealFishBtn = Instance.new("TextButton", sg)
RealFishBtn.Size = UDim2.new(0, 95, 0, 95)
RealFishBtn.Position = UDim2.new(0.85, 0, 0.40, 0)
RealFishBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
RealFishBtn.Text = "ตกปลา\nทิพย์"
RealFishBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
RealFishBtn.Font = Enum.Font.GothamBold
RealFishBtn.TextSize = 16
RealFishBtn.Visible = false
RealFishBtn.BorderSizePixel = 0
Instance.new("UICorner", RealFishBtn).CornerRadius = UDim.new(1, 0)

CastBtn.MouseButton1Click:Connect(function() pcall(function() autoCastSound:Play() end); getgenv().NWKZ_AutoCast = not getgenv().NWKZ_AutoCast; CastBtn.Text = "AUTO CAST (เหวี่ยงเบ็ดออโต้): " .. (getgenv().NWKZ_AutoCast and "ON" or "OFF"); CastBtn.BackgroundColor3 = getgenv().NWKZ_AutoCast and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0) end)
AnchorBtn.MouseButton1Click:Connect(function() pcall(function() anchorSound:Play() end); getgenv().NWKZ_Anchor = not getgenv().NWKZ_Anchor; AnchorBtn.Text = "ล็อกแถบตกปลา (Rock Bar): " .. (getgenv().NWKZ_Anchor and "ON" or "OFF"); AnchorBtn.BackgroundColor3 = getgenv().NWKZ_Anchor and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0) end)
FishThipBtn.MouseButton1Click:Connect(function() pcall(function() defaultClickSound:Play() end); getgenv().PP_FishingThipActive = not getgenv().PP_FishingThipActive; RealFishBtn.Visible = getgenv().PP_FishingThipActive; FishThipBtn.Text = "🟢 เปิดปิดปุ่มตกปลาทิพย์ (ขวาจอ): " .. (getgenv().PP_FishingThipActive and "ON" or "OFF"); FishThipBtn.BackgroundColor3 = getgenv().PP_FishingThipActive and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0) end)
SkillAllBtn.MouseButton1Click:Connect(function() pcall(function() skillSound:Play() end); getgenv().PP_AutoSkillAll = not getgenv().PP_AutoSkillAll; SkillAllBtn.Text = "AUTO ALL SKILLS (รวมกดทุกสกิล): " .. (getgenv().PP_AutoSkillAll and "ON" or "OFF"); SkillAllBtn.BackgroundColor3 = getgenv().PP_AutoSkillAll and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0) end)
NoclipBtn.MouseButton1Click:Connect(function() pcall(function() defaultClickSound:Play() end); getgenv().PP_Noclip = not getgenv().PP_Noclip; NoclipBtn.Text = "NOCLIP (ทะลุกำแพง): " .. (getgenv().PP_Noclip and "ON" or "OFF"); NoclipBtn.BackgroundColor3 = getgenv().PP_Noclip and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0) end)

SellBtn.MouseButton1Click:Connect(function() 
    pcall(function() sellSound:Play() end) 
    pcall(function() 
        if RS:FindFirstChild("Events") and RS.Events:FindFirstChild("SellFish") then 
            RS.Events.SellFish:FireServer("All") 
        elseif RS:FindFirstChild("SellFish") then 
            RS.SellFish:FireServer("All") 
        end 
    end) 
    SellBtn.Text = "SOLD OUT!" 
    task.wait(0.4) 
    SellBtn.Text = "💰 SELL ALL (ขายปลาทั้งหมด)" 
end)

SpeedUpBtn.MouseButton1Click:Connect(function() pcall(function() speedSound:Play() end); getgenv().PP_WalkSpeed = math.clamp(getgenv().PP_WalkSpeed + 10, 16, 250); SpeedLabel.Text = "WALKSPEED (วิ่งเร็ว): " .. tostring(getgenv().PP_WalkSpeed) end)
SpeedDownBtn.MouseButton1Click:Connect(function() pcall(function() speedSound:Play() end); getgenv().PP_WalkSpeed = math.clamp(getgenv().PP_WalkSpeed - 10, 16, 250); SpeedLabel.Text = "WALKSPEED (วิ่งเร็ว): " .. tostring(getgenv().PP_WalkSpeed) end)
FlyBtn.MouseButton1Click:Connect(function() pcall(function() defaultClickSound:Play() end); pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FLY-GUI-V11-205450"))() end); FlyBtn.Text = "🚀 FLY LOADED!"; task.wait(0.8); FlyBtn.Text = "🚀 FLY GUI (เปิดโปรบิน)" end)
RealFishBtn.MouseButton1Click:Connect(function() pcall(function() defaultClickSound:Play() end); pcall(function() if RS:FindFirstChild("Events") and RS.Events:FindFirstChild("Fishing") then RS.Events.Fishing:FireServer() elseif RS:FindFirstChild("Fishing") then RS.Fishing:FireServer() end end); RealFishBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255); task.wait(0.05); RealFishBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 120) end)

selectTab(Tab1Btn, Page1)

local isMinimized = false
local tweenInfoResize = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

MinBtn.MouseButton1Click:Connect(function() 
    pcall(function() defaultClickSound:Play() end)
    isMinimized = not isMinimized 
    if isMinimized then 
        Sidebar.Visible = false
        if activePage then activePage.Visible = false end
        TweenService:Create(Main, tweenInfoResize, {Size = MinimizedSize}):Play()
        MinBtn.Text = "+" 
    else 
        TweenService:Create(Main, tweenInfoResize, {Size = MainSize}):Play()
        task.wait(0.15) 
        Sidebar.Visible = true
        if activePage then activePage.Visible = true end
        MinBtn.Text = "—" 
    end 
end)

CloseBtn.MouseButton1Click:Connect(function()
    pcall(function() defaultClickSound:Play() end)
    getgenv().NWKZ_Anchor = false
    getgenv().NWKZ_AutoCast = false
    getgenv().PP_Noclip = false
    getgenv().PP_FishingThipActive = false
    getgenv().PP_AutoSkillAll = false
    getgenv().PP_Skill_Z = false
    getgenv().PP_Skill_X = false
    getgenv().PP_Skill_C = false
    getgenv().PP_Skill_V = false
    if RealFishBtn then RealFishBtn.Visible = false end
    pcall(function()
        deleteSound:Play()
        deleteSound.Ended:Wait()
    end)
    sg:Destroy()
end)

-- 🌟 อนิเมชั่นเปิด UI
TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.3, 0, 0.3, 0)
}):Play()

pcall(function()
    loadSound.Looped = false
    loadSound:Play()
end)

task.spawn(function()
    task.wait(1.2)
    pcall(function()
        local fade = TweenService:Create(loadSound, TweenInfo.new(0.8), {Volume = 0})
        fade:Play()
        fade.Completed:Wait()
        loadSound:Stop()
    end)
end)

-- ⚙️ Background Loops
RunService.Stepped:Connect(function()
    pcall(function()
        local char = lp.Character
        if char and char:FindFirstChild("Humanoid") then
            if getgenv().PP_WalkSpeed then
                char.Humanoid.WalkSpeed = getgenv().PP_WalkSpeed
            end
        end
        if getgenv().PP_Noclip and char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

-- Auto Cast Engine
task.spawn(function()
    while task.wait(0.3) do
        if getgenv().NWKZ_AutoCast then
            pcall(function()
                if RS:FindFirstChild("Events") and RS.Events:FindFirstChild("Fishing") then
                    RS.Events.Fishing:FireServer()
                elseif RS:FindFirstChild("Fishing") then
                    RS.Fishing:FireServer()
                end
            end)
        end
    end
end)

-- 🚀 Rock Bar / Anchor Engine (ล็อกตรงกลาง 0.5 รัวๆ ตัดหน้าสคริปต์เกม)
RunService.RenderStepped:Connect(function()
    if getgenv().NWKZ_Anchor then
        pcall(function()
            local playerGui = lp:FindFirstChild("PlayerGui")
            if not playerGui then return end
            
            local fishingUI = (playerGui:FindFirstChild("MainGui") and playerGui.MainGui:FindFirstChild("Fishing")) 
                or playerGui:FindFirstChild("Fishing") 
                or playerGui:FindFirstChild("FishingUI")
            
            if fishingUI and fishingUI.Visible then
                local barFrame = fishingUI:FindFirstChild("FishingBar") or fishingUI:FindFirstChild("BarFrame") or fishingUI:FindFirstChild("Bar")
                if barFrame then
                    local bar = barFrame:FindFirstChild("Bar") or barFrame:FindFirstChild("Slider") or barFrame:FindFirstChild("Progress") or barFrame:FindFirstChild("Pointer")
                    if bar and bar:IsA("GuiObject") then
                        bar.Position = UDim2.new(0.5, 0, bar.Position.Y.Scale, 0)
                    end
                end
                
                if RS:FindFirstChild("Fishing") then
                    RS.Fishing:FireServer("1")
                elseif RS:FindFirstChild("Events") and RS.Events:FindFirstChild("Fishing") then
                    RS.Events.Fishing:FireServer("1")
                end
            end
        end)
    end
end)

-- Auto Skills Engine
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if getgenv().PP_AutoSkillAll or getgenv().PP_Skill_Z then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                task.wait(0.05)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
            end
            if getgenv().PP_AutoSkillAll or getgenv().PP_Skill_X then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
                task.wait(0.05)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
            end
            if getgenv().PP_AutoSkillAll or getgenv().PP_Skill_C then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
                task.wait(0.05)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
            end
            if getgenv().PP_AutoSkillAll or getgenv().PP_Skill_V then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.V, false, game)
                task.wait(0.05)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
            end
        end)
    end
end)

print("★ [PPINGYYY] Ultimate Hub Loaded Successfully & Rock Bar Fixed at Center (RenderStepped)!")

