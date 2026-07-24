-- [[ ★ FULL FIXED PPINGYYY HUB (FINAL VERSION) ★ ]] --
local lp = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- 1. ล้างของเก่า
for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end end
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "PPINGYYY_Hub_Ultimate"

-- 2. Loading Screen System (ระบบโหลดแบบเท่ๆ)
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

task.wait(3.5)
for i = #stars, 1, -1 do local j = math.random(i); stars[i], stars[j] = stars[j], stars[i] end
for _, star in ipairs(stars) do TweenService:Create(star, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play(); task.wait(0.005) end
TweenService:Create(LoadingFrame, TweenInfo.new(1.5, Enum.EasingStyle.Quart), {Position = UDim2.new(math.random(-1, 0), 0, 1.5, 0), BackgroundTransparency = 1}):Play()
TweenService:Create(TextLabel, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
TweenService:Create(BarBg, TweenInfo.new(1.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(BarFill, TweenInfo.new(1.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(PercentText, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
task.wait(1.5); LoadingFrame:Destroy()

-- 3. สคริปต์หลักมึง (ที่มึงบอกว่ามีฟังก์ชันนั่นนี่) เอามาต่อจากตรงนี้ได้เลย!
-- มั่นใจว่าตรงท้ายสคริปต์หลักมึงมี end ปิดครบทุกฟังก์ชันนะเพื่อน!
-- [[ ★PPINGYYY HUB - BASE GUI TEMPLATE ★ ]] --
local lp = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end end
for _, v in ipairs(lp:WaitForChild("PlayerGui"):GetChildren()) do if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end end

local sg = Instance.new("ScreenGui", (pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or lp:WaitForChild("PlayerGui")))
sg.Name = "PPINGYYY_Hub_Ultimate" sg.ResetOnSpawn = false

local MainSize = UDim2.new(0, 420, 0, 250) local MinimizedSize = UDim2.new(0, 420, 0, 40)

local Main = Instance.new("Frame", sg) Main.Size = MainSize Main.Position = UDim2.new(0.3, 0, 0.3, 0) Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10) Instance.new("UIStroke", Main).Color = Color3.fromRGB(0, 255, 150)

local TitleBar = Instance.new("Frame", Main) TitleBar.Size = UDim2.new(1, 0, 0, 40) TitleBar.BackgroundTransparency = 1
local TitleText = Instance.new("TextLabel", TitleBar) TitleText.Size = UDim2.new(1, 0, 1, 0) TitleText.Text = "★ PPINGYYY HUB ★" TitleText.TextColor3 = Color3.fromRGB(0, 255, 150) TitleText.Font = Enum.Font.GothamBold TitleText.TextSize = 14 TitleText.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TitleBar) CloseBtn.Size = UDim2.new(0, 25, 0, 25) CloseBtn.Position = UDim2.new(0.9, 0, 0.25, 0) CloseBtn.Text = "X" CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) CloseBtn.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
local MinBtn = Instance.new("TextButton", TitleBar) MinBtn.Size = UDim2.new(0, 25, 0, 25) MinBtn.Position = UDim2.new(0.8, 0, 0.25, 0) MinBtn.Text = "—" MinBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) MinBtn.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

local Sidebar = Instance.new("Frame", Main) Sidebar.Size = UDim2.new(0, 120, 1, -40) Sidebar.Position = UDim2.new(0, 0, 0, 40) Sidebar.BackgroundTransparency = 1
local Pages = Instance.new("Frame", Main) Pages.Size = UDim2.new(1, -130, 1, -50) Pages.Position = UDim2.new(0, 125, 0, 45) Pages.BackgroundTransparency = 1

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
local Tab4Btn = createTabButton("🏝️ เกาะ/วาร์ป", 3)
local Tab5Btn = createTabButton("📍 พ่อค้าลับ", 4)
local Tab6Btn = createTabButton("🚀 Teleport", 5)

local function createPage() 
    local page = Instance.new("ScrollingFrame", Pages) 
    page.Size = UDim2.new(1, 0, 1, 0) 
    page.BackgroundTransparency = 1 
    page.ScrollBarThickness = 2 
    page.Visible = false 
    return page 
end

local Page1, Page2, Page3, Page4, Page5, Page6 = createPage(), createPage(), createPage(), createPage(), createPage(), createPage()
local activePage = nil 
local tweenInfoTab = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local function selectTab(selectedBtn, targetPage)
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
Tab6Btn.MouseButton1Click:Connect(function() selectTab(Tab6Btn, Page6) end)

selectTab(Tab1Btn, Page1)

local isMinimized = false
local tweenInfoResize = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

MinBtn.MouseButton1Click:Connect(function() 
    isMinimized = not isMinimized 
    if isMinimized then 
        Sidebar.Visible = false
        if activePage then activePage.Visible = false end
        TweenService:Create(Main, tweenInfoResize, {Size = MinimizedSize}):Play()
        MinBtn.Text = "⬜" 
    else 
        TweenService:Create(Main, tweenInfoResize, {Size = MainSize}):Play()
        task.wait(0.15) 
        Sidebar.Visible = true
        if activePage then activePage.Visible = true end
        MinBtn.Text = "—" 
    end 
end)

CloseBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

local dragging, dragInput, dragStart, startPos
local function update(input) local delta = input.Position - dragStart; Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end
TitleBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; dragStart = input.Position; startPos = Main.Position; input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end) end end)
TitleBar.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

-- [[ ★PPINGYYY HUB - ULTIMATE SINGLE SCRIPT ★ ]] --
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
getgenv().PP_SavedCFrame = nil 

local sg = Instance.new("ScreenGui", (pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or lp:WaitForChild("PlayerGui")))
sg.Name = "PPINGYYY_Hub_Ultimate" sg.ResetOnSpawn = false

local MainSize = UDim2.new(0, 420, 0, 250) local MinimizedSize = UDim2.new(0, 420, 0, 40)

local Main = Instance.new("Frame", sg) Main.Size = MainSize Main.Position = UDim2.new(0.3, 0, 0.3, 0) Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10) Instance.new("UIStroke", Main).Color = Color3.fromRGB(0, 255, 150)

local TitleBar = Instance.new("Frame", Main) TitleBar.Size = UDim2.new(1, 0, 0, 40) TitleBar.BackgroundTransparency = 1
local TitleText = Instance.new("TextLabel", TitleBar) TitleText.Size = UDim2.new(1, 0, 1, 0) TitleText.Text = "★ PPINGYYY HUB ★" TitleText.TextColor3 = Color3.fromRGB(0, 255, 150) TitleText.Font = Enum.Font.GothamBold TitleText.TextSize = 14 TitleText.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TitleBar) CloseBtn.Size = UDim2.new(0, 25, 0, 25) CloseBtn.Position = UDim2.new(0.9, 0, 0.25, 0) CloseBtn.Text = "X" CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) CloseBtn.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
local MinBtn = Instance.new("TextButton", TitleBar) MinBtn.Size = UDim2.new(0, 25, 0, 25) MinBtn.Position = UDim2.new(0.8, 0, 0.25, 0) MinBtn.Text = "—" MinBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) MinBtn.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

local Sidebar = Instance.new("Frame", Main) Sidebar.Size = UDim2.new(0, 120, 1, -40) Sidebar.Position = UDim2.new(0, 0, 0, 40) Sidebar.BackgroundTransparency = 1
local Pages = Instance.new("Frame", Main) Pages.Size = UDim2.new(1, -130, 1, -50) Pages.Position = UDim2.new(0, 125, 0, 45) Pages.BackgroundTransparency = 1

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
local Tab4Btn = createTabButton("🏝️ เกาะ/วาร์ป", 3)
local Tab5Btn = createTabButton("📍 พ่อค้าลับ", 4)
local Tab6Btn = createTabButton("🚀 Teleport", 5)

local function createPage() 
    local page = Instance.new("ScrollingFrame", Pages) 
    page.Size = UDim2.new(1, 0, 1, 0) 
    page.BackgroundTransparency = 1 
    page.ScrollBarThickness = 2 
    page.Visible = false 
    return page 
end

local Page1, Page2, Page3, Page4, Page5, Page6 = createPage(), createPage(), createPage(), createPage(), createPage(), createPage()
local activePage = nil 
local tweenInfoTab = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local function selectTab(selectedBtn, targetPage)
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
Tab6Btn.MouseButton1Click:Connect(function() selectTab(Tab6Btn, Page6) end)

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

-- PAGE 1: ตกปลา
local CastBtn = createNormalButton(Page1, "เหวี่ยงเบ็ดออโต้: OFF", 5)
local AnchorBtn = createNormalButton(Page1, "ทำให้แถบอยู่ตรงกลาง: OFF", 42)
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

-- PAGE 2: สกิล
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

-- PAGE 3: เครื่องมือ
local NoclipBtn = createNormalButton(Page3, "ทะลุกำแพง: OFF", 5)
local SpeedLabel = Instance.new("TextLabel", Page3)
SpeedLabel.Size = UDim2.new(1, -10, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 45)
SpeedLabel.Text = "ความเร็วในการเดิน: 16"
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

-- PAGE 4: เกาะ/วาร์ป
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

-- PAGE 5: พ่อค้าลับ
local MerchantTpBtn = createNormalButton(Page5, "🥷 วาปไปหาพ่อค้าลับ (Auto Scan)", 5)
MerchantTpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
MerchantTpBtn.MouseButton1Click:Connect(function()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local found = false
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and (string.find(string.lower(obj.Name), "merchant") or string.find(string.lower(obj.Name), "traveling") or string.find(string.lower(obj.Name), "secret")) then
            local targetHrp = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("PrimaryPart")
            if targetHrp then
                hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, -3)
                found = true
                break
            end
        end
    end
    if not found then
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "★ PPINGYYY HUB ★", Text = "ไม่พบพ่อค้าลับในเซิร์ฟ!", Duration = 5})
        end)
    end
end)

local CheckSpotBtn = createNormalButton(Page5, "🌊 วาปส่องจุดเกิดสำรอง (ถ้ำ/น้ำตก)", 45)
CheckSpotBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
CheckSpotBtn.MouseButton1Click:Connect(function()
    local char = lp.Character or lp.CharacterAdded:Wait()
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(0, 50, -500)
    end
end)

-- ==========================================================
-- PAGE 6: TELEPORT (3 ปุ่มตามที่มึงบรีฟ)
-- ==========================================================

local CoordLabel = Instance.new("TextLabel", Page6)
CoordLabel.Size = UDim2.new(0.95, 0, 0, 32)
CoordLabel.Position = UDim2.new(0.025, 0, 0, 5)
CoordLabel.Text = "📍 พิกัดปัจจุบัน: (0, 0, 0)"
CoordLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
CoordLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
CoordLabel.Font = Enum.Font.GothamBold
CoordLabel.TextSize = 10
Instance.new("UICorner", CoordLabel).CornerRadius = UDim.new(0, 6)

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                local pos = lp.Character.HumanoidRootPart.Position
                CoordLabel.Text = string.format("📍 พิกัด: (%.1f, %.1f, %.1f)", pos.X, pos.Y, pos.Z)
            end
   
