local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pgui = lp:WaitForChild("PlayerGui")

local function drag(handle,target)
    local dragging,startPos,base; handle.Active=true; target.Active=true
    handle.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; startPos=i.Position; base=target.Position
            i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dragging=false end end)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local d=i.Position-startPos
            TweenService:Create(target, TweenInfo.new(0.08,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {Position=UDim2.new(base.X.Scale,base.X.Offset+d.X,base.Y.Scale,base.Y.Offset+d.Y)}):Play()
        end
    end)
end

local M = {}
function M.start(opt)
    opt = opt or {}
    local title   = opt.title or "UFO HUB X"
    local logoId  = opt.logoId or 106029438403666
    local accent  = opt.accent or Color3.fromRGB(22,247,123)
    local center  = (opt.centerOpen ~= false)
    local twoCol  = (opt.twoColumns ~= false)

    -- Toggle
    local Toggle = Instance.new("ImageButton", pgui)
    Toggle.Name = "UFOX_TOGGLE"
    Toggle.Size = UDim2.new(0,58,0,58)
    Toggle.Position = UDim2.new(0,20,0.45,-29)
    Toggle.BackgroundColor3 = Color3.fromRGB(20,24,27)
    Toggle.Image = "rbxassetid://"..logoId
    Toggle.ImageColor3 = accent
    local tc = Instance.new("UICorner", Toggle); tc.CornerRadius = UDim.new(0,14)
    drag(Toggle, Toggle)

    -- Main
    local Gui = Instance.new("ScreenGui", pgui)
    Gui.Name = "UFOX_MAIN"
    Gui.DisplayOrder = 2200
    Gui.IgnoreGuiInset = true
    Gui.ResetOnSpawn = false

    local Win = Instance.new("Frame", Gui)
    Win.AnchorPoint = Vector2.new(0.5,0.5)
    Win.Position = UDim2.fromScale(0.5,0.5)
    Win.Size = UDim2.new(0,680,0,360)
    Win.BackgroundColor3 = Color3.fromRGB(14,17,19)
    local wC = Instance.new("UICorner", Win); wC.CornerRadius = UDim.new(0,16)

    local Bar = Instance.new("Frame", Win)
    Bar.Size = UDim2.new(1,-10,0,48); Bar.Position=UDim2.new(0,5,0,5)
    Bar.BackgroundColor3 = Color3.fromRGB(20,24,27)
    local bC = Instance.new("UICorner", Bar); bC.CornerRadius = UDim.new(0,12)

    local I = Instance.new("ImageLabel", Bar)
    I.BackgroundTransparency=1; I.Image="rbxassetid://"..logoId; I.ImageColor3=accent
    I.Size=UDim2.new(0,26,0,26); I.Position=UDim2.new(0,10,0.5,-13)

    local T = Instance.new("TextLabel", Bar)
    T.BackgroundTransparency=1; T.Font=Enum.Font.GothamBold; T.TextSize=19; T.TextColor3=Color3.fromRGB(221,228,234); T.RichText=true
    T.Text = ('<font color="#%02X%02X%02X">UFO</font> HUB X'):format(accent.R*255, accent.G*255, accent.B*255)
    T.Size=UDim2.new(1,-100,1,0); T.Position=UDim2.new(0,42,0,0)

    local Close = Instance.new("TextButton", Bar)
    Close.Size=UDim2.new(0,28,0,28); Close.Position=UDim2.new(1,-36,0.5,-14)
    Close.Text="✕"; Close.Font=Enum.Font.GothamBold; Close.TextSize=16; Close.TextColor3=Color3.fromRGB(221,228,234)
    Close.BackgroundColor3=Color3.fromRGB(36,40,44); local cC=Instance.new("UICorner", Close); cC.CornerRadius=UDim.new(0,14)

    drag(Bar, Win)

    local Tabs = Instance.new("Frame", Win)
    Tabs.Size=UDim2.new(1,-10,0,38); Tabs.Position=UDim2.new(0,5,0,58)
    Tabs.BackgroundColor3=Color3.fromRGB(27,32,36); local tC=Instance.new("UICorner", Tabs); tC.CornerRadius=UDim.new(0,10)

    local list=Instance.new("UIListLayout", Tabs); list.FillDirection=Enum.FillDirection.Horizontal; list.Padding=UDim.new(0,6); list.VerticalAlignment=Enum.VerticalAlignment.Center
    local function mkTab(name)
        local b=Instance.new("TextButton"); b.Size=UDim2.new(0,106,1,-10); b.Position=UDim2.new(0,0,0,5)
        b.Text=name; b.Font=Enum.Font.Gotham; b.TextSize=15; b.TextColor3=Color3.fromRGB(221,228,234); b.BackgroundColor3=Color3.fromRGB(14,17,19)
        local cc=Instance.new("UICorner", b); cc.CornerRadius=UDim.new(0,10)
        local u=Instance.new("Frame", b); u.AnchorPoint=Vector2.new(0.5,1); u.Position=UDim2.new(0.5,0,1,0); u.Size=UDim2.new(0,0,0,2); u.BackgroundColor3=accent; u.Visible=false; Instance.new("UICorner",u).CornerRadius=UDim.new(0,2)
        b.MouseEnter:Connect(function() b.BackgroundColor3=Color3.fromRGB(24,28,32) end)
        b.MouseLeave:Connect(function() b.BackgroundColor3=Color3.fromRGB(14,17,19) end)
        return b,function(on) u.Visible=on; u.Size=UDim2.new(on and 1 or 0,0,0,2) end
    end

    local Content = Instance.new("Frame", Win)
    Content.Size=UDim2.new(1,-10,1,-(58+38+10)); Content.Position=UDim2.new(0,5,0,58+38+5)
    Content.BackgroundColor3=Color3.fromRGB(20,24,27); local cc2=Instance.new("UICorner", Content); cc2.CornerRadius=UDim.new(0,12)

    local names={"หน้าหลัก","ผู้เล่น","ภาพ/แสง","เทเลพอร์ต","ตั้งค่า","เครดิต"}
    local pages, tabs, marks = {}, {}, {}
    local function mkPage() 
        local p=Instance.new("Frame", Content); p.Size=UDim2.new(1,-10,1,-10); p.Position=UDim2.new(0,5,0,5); p.BackgroundTransparency=1; p.Visible=false
        if twoCol then
            local row=Instance.new("Frame", p); row.Size=UDim2.new(1,0,1,0); row.BackgroundTransparency=1
            local lay=Instance.new("UIListLayout", row); lay.FillDirection=Enum.FillDirection.Horizontal; lay.Padding=UDim.new(0,10)
            for i=1,2 do local box=Instance.new("Frame", row); box.Size=UDim2.new(0.5,-5,1,0); box.BackgroundColor3=Color3.fromRGB(27,32,36); local cr=Instance.new("UICorner",box); cr.CornerRadius=UDim.new(0,10) end
        end
        return p
    end
    for _,n in ipairs(names) do
        local b,m=mkTab(n); b.Parent=Tabs; tabs[n]=b; marks[n]=m; pages[n]=mkPage()
    end
    local current; local function switchTo(n) if current then pages[current].Visible=false; marks[current](false) end; current=n; pages[n].Visible=true; marks[n](true) end
    for n,b in pairs(tabs) do b.MouseButton1Click:Connect(function() switchTo(n) end) end
    switchTo("หน้าหลัก")

    local isOpen=false; local anim=false
    local function center() if center then Win.AnchorPoint=Vector2.new(0.5,0.5); Win.Position=UDim2.fromScale(0.5,0.5) end end
    local function open() if anim or isOpen then return end; anim=true; center(); Win.Visible=true; Win.BackgroundTransparency=1; 
        TweenService:Create(Win, TweenInfo.new(0.18,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {BackgroundTransparency=0, Position=Win.Position+UDim2.new(0,0,0,10)}):Play()
        task.wait(0.18); isOpen=true; anim=false end
    local function close() if anim or not isOpen then return end; anim=true; TweenService:Create(Win, TweenInfo.new(0.16,Enum.EasingStyle.Quad,Enum.EasingDirection.In), {BackgroundTransparency=1, Position=Win.Position-UDim2.new(0,0,0,10)}):Play()
        task.wait(0.16); Win.Visible=false; isOpen=false; anim=false end

    Toggle.MouseButton1Click:Connect(function() if isOpen then close() else open() end end)
    Close.MouseButton1Click:Connect(close)

    -- เปิดครั้งแรก
    open()
end

return M
