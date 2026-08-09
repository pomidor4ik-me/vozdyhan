-- Загрузка библиотеки Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Создание главного окна
local Window = Rayfield:CreateWindow({
   Name = "Air Walk Menu",
   LoadingTitle = "Загрузка скрипта...",
   LoadingSubtitle = "Rayfield UI",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "AirWalkConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false
})

-- Создание вкладки
local MainTab = Window:CreateTab("Главная", 4483362458)

-- Переменные
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local airPart = nil
local airWalkConnection = nil
local airWalkEnabled = false
local lockedPosition = nil

-- Функция фиксации высоты (заморозка по оси Y на текущем уровне)
local function toggleAirWalk(state)
    airWalkEnabled = state
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if airWalkEnabled then
        if not rootPart then return end
        
        -- Запоминаем текущую высоту (Y), на которой стоит или находится игрок
        lockedPosition = rootPart.Position
        
        -- Создаем фиксированную невидимую платформу на этой высоте
        airPart = Instance.new("Part")
        airPart.Size = Vector3.new(6, 1, 6)
        airPart.Transparency = 1
        airPart.Anchored = true
        airPart.CanCollide = true
        airPart.Parent = workspace
        airPart.Position = Vector3.new(lockedPosition.X, lockedPosition.Y - 3.5, lockedPosition.Z)
        
        -- Держим платформу на той же высоте, но позволяем двигаться по X и Z (или жестко фиксируем под ногами в точке активации)
        -- Если нужно, чтобы платформа просто стояла на месте активации в воздухе:
        airWalkConnection = RunService.RenderStepped:Connect(function()
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                -- Если нужно, чтобы платформа следовала за горизонтальными движениями, но не меняла высоту Y:
                local currentPos = char.HumanoidRootPart.Position
                airPart.Position = Vector3.new(currentPos.X, lockedPosition.Y - 3.5, currentPos.Z)
            end
        end)
    else
        -- Отключаем и удаляем платформу
        if airWalkConnection then
            airWalkConnection:Disconnect()
            airWalkConnection = nil
        end
        if airPart then
            airPart:Destroy()
            airPart = nil
        end
        lockedPosition = nil
    end
end

-- Переключатель в интерфейсе
local AirWalkToggle = MainTab:CreateToggle({
   Name = "Фиксация воздуха (Заморозка высоты)",
   CurrentValue = false,
   Flag = "AirWalkToggleFlag",
   Callback = function(Value)
       toggleAirWalk(Value)
   end,
})

-- Уведомление
Rayfield:Notify({
   Title = "Успешно",
   Content = "Скрипт фиксации высоты загружен!",
   Duration = 3,
   Image = 4483362458,
})
