-- Загрузка библиотеки Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Создание главного окна
local Window = Rayfield:CreateWindow({
   Name = "Пример интерфейса",
   LoadingTitle = "Загрузка...",
   LoadingSubtitle = "Rayfield UI",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false -- Включение/отключение системы ключей
})

-- Создание вкладки
local MainTab = Window:CreateTab("Главное", 4483362458) -- ID иконки (необязательно)

-- Создание секции
local Section = MainTab:CreateSection("Управление настройками")

-- Пример кнопки (Button)
local Button = MainTab:CreateButton({
   Name = "Нажать кнопку",
   Callback = function()
       print("Кнопка была успешно нажата!")
   end,
})

-- Пример переключателя (Toggle)
local Toggle = MainTab:CreateToggle({
   Name = "Включить функцию",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
       print("Статус переключателя:", Value)
   end,
})

-- Пример слайдера (Slider)
local Slider = MainTab:CreateSlider({
   Name = "Скорость движения",
   Range = {16, 100},
   Increment = 1,
   Suffix = " единиц",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
       local player = game.Players.LocalPlayer
       if player and player.Character and player.Character:FindFirstChild("Humanoid") then
           player.Character.Humanoid.WalkSpeed = Value
       end
   end,
})

-- Уведомление о успешном запуске
Rayfield:Notify({
   Title = "Готово",
   Content = "Интерфейс успешно загружен!",
   Duration = 3,
   Image = 4483362458,
})
