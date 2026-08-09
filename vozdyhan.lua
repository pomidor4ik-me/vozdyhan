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

-- Переменные для Air Walk
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local airPart = nil
local airWalkConnection = nil
local airWalkEnabled = false

-- Функция включения/выключения ходьбы по воздуху
local function toggleAirWalk(state)
    airWalkEnabled = state
    
    if airWalkEnabled then
        -- Создаем невидимую платформу
        airPart = Instance.new("Part")
        airPart.Size = Vector3.new(5, 1, 5)
        airPart.Transparency = 1
        airPart.Anchored = true
        airPart.CanCollide = true
        airPart.Parent = workspace
        
        -- Обновляем позицию каждый кадр
        airWalkConnection = RunService.RenderStepped:Connect(function()
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                airPart.Position = rootPart.Position - Vector3.new(0, 3.2, 0)
            end
        end)
    else
        -- Удаляем привязку и саму платформу
        if airWalkConnection then
            airWalkConnection:Disconnect()
            airWalkConnection = nil
        end
        if airPart then
            airPart:Destroy()
            airPart = nil
        end
    end
end

-- Переключатель в интерфейсе
local AirWalkToggle = MainTab:CreateToggle({
   Name = "Air Walk (Ходьба по воздуху)",
   CurrentValue = false,
   Flag = "AirWalkToggleFlag",
   Callback = function(Value)
       toggleAirWalk(Value)
   end,
})

-- Уведомление об успешной загрузке
Rayfield:Notify({
   Title = "Успешно",
   Content = "Интерфейс Air Walk загружен!",
   Duration = 3,
   Image = 4483362458,
})
