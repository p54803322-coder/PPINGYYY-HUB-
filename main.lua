-- [[ ★PPINGYYY HUB - CLEAN VERSION ★ ]] --
local lp = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager") 

-- ล้าง GUI เก่าทิ้ง
for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end end
for _, v in ipairs(lp:WaitForChild("PlayerGui"):GetChildren()) do if v.Name == "PPINGYYY_Hub_Ultimate" then v:Destroy() end end

getgenv().NWKZ_Anchor = false getgenv().NWKZ_AutoCast = false getgenv().PP_Noclip = false getgenv().PP_WalkSpeed = 16 getgenv().PP_FishingThipActive = false
getgenv().PP_AutoSkillAll = false getgenv().PP_Skill_Z = false getgenv().PP_Skill_X = false getgenv().PP_Skill_C = false getgenv().PP_Skill_V = false
local skillKeys = {Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}

local sg = Instance.new("ScreenGui", (pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or lp:WaitForChild("PlayerGui")))
sg.Name = "PPINGYYY_Hub_Ultimate" sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 420, 0, 250) Main.Position = UDim2.new(0.3, 0, 0.3, 0) Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10) Instance.new("UIStroke", Main).Color = Color3.fromRGB(0, 255, 150)

local TitleBar = Instance.new("Frame", Main) TitleBar.Size = UDim2.new(1, 0, 0, 40) TitleBar.BackgroundTransparency = 1
local Title = Instance.new("TextLabel", TitleBar) Title.Size = UDim2.new(0.5, 0, 1, 0) Title.Position = UDim2.new(0.05, 0, 0, 0) Title.Text = "★PPINGYYY HUB★" Title.TextColor3 = Color3.fromRGB(0, 255, 150) Title.Font = Enum.Font.GothamBold Title.BackgroundTransparency = 1
local CloseBtn = Instance.new("TextButton", TitleBar) CloseBtn.Size = UDim2.new(0, 25, 0, 25) CloseBtn.Position = UDim2.new(0.9, 0, 0.25, 0) CloseBtn.Text = "X" CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) CloseBtn.TextColor3 = Color3.new(1, 1, 1) Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

local Sidebar = Instance.new("Frame", Main) Sidebar.Size = UDim2.new(0, 120, 1, -40) Sidebar.Position = UDim2.new(0, 0, 0, 40) Sidebar.BackgroundTransparency = 1
local Pages = Instance.new("Frame", Main) Pages.Size = UDim2.new(1, -130, 1, -50) Pages.Position = UDim2.new(0, 125, 0, 45) Pages.BackgroundTransparency = 1

local function createTabButton(text, posIndex)
    local btn = Instance.new("TextButton", Sidebar) btn.Size = UDim2.new(0.85, 0, 0, 30) btn.Position = UDim2.new(0.05, 0, 0, 8 + (posIndex * 35)) btn.Text = text btn.TextColor3 = Color3.fromRGB(150, 150, 150) btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25) btn.Font = Enum.Font.GothamBold Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local Tab1Btn = createTabButton("🎣 ตกปลา", 0) local Tab2Btn = createTabButton("⚡ สกิล", 1) local Tab3Btn = createTabButton("🛠️ เครื่องมือ", 2) local Tab4Btn = createTabButton("🏝️ วาร์ป", 3)

local function createPage() local page = Instance.new("ScrollingFrame", Pages) page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1 page.ScrollBarThickness = 2 page.Visible = false return page end
local Page1, Page2, Page3, Page4 = createPage(), createPage(), createPage(), createPage()
local activePage, activeBtn = nil, nil

local function showPage(targetPage, targetBtn)
    if activePage then activePage.Visible = false end
    targetPage.Visible = true activePage = targetPage
end

Tab1Btn.MouseButton1Click:Connect(function() showPage(Page1, Tab1Btn) end)
Tab2Btn.MouseButton1Click:Connect(function() showPage(Page2, Tab2Btn) end)
Tab3Btn.MouseButton1Click:Connect(function() showPage(Page3, Tab3Btn) end)
Tab4Btn.MouseButton1Click:Connect(function() showPage(Page4, Tab4Btn) end)

-- [ ต่อจากนี้คือระบบปุ่มและฟังก์ชันทั้งหมดมึง ]
local function createNormalButton(parent, text, yPos)
    local btn = Instance.new("TextButton", parent) btn.Size = UDim2.new(0.95, 0, 0, 32) btn.Position = UDim2.new(0.025, 0, 0, yPos) btn.Text = text btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) btn.TextColor3 = Color3.new(1, 1, 1) btn.Font = Enum.Font.GothamBold btn.TextSize = 10 Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6) return btn
end

-- มึงก๊อปปี้โค้ดส่วนปุ่ม (CastBtn, AnchorBtn, บลาๆ) ที่มึงมี มาแปะต่อจากบรรทัดนี้ได้เลยครับ!
