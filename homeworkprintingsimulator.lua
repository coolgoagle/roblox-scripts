local function main()

-- savedata
local owned_items = require(game.Players.LocalPlayer.PlayerScripts.Main.Data):GetData().Owned
local colors = workspace.UsedInScripts.PlayerLocker.LockerColor.Value

local savedata = {
    Money = workspace:GetAttribute("Money"),
    Time = workspace:GetAttribute("TimeToDraw"),
    Multiplier = workspace:GetAttribute("Multiplier"),
    Paper = workspace:GetAttribute("Paper"),
    GoldMulti = workspace:GetAttribute("GoldMulti"),
    FinishedTutorial = workspace:GetAttribute("FinishedTutorial"),
    TrunkPaper = workspace:GetAttribute("TrunkPaper"),
    TrunkCapacity = workspace:GetAttribute("TrunkCapacity"),
    Staff = workspace:GetAttribute("Staff"),
    BadGraphics = workspace:GetAttribute("BadGraphics"),
    StaffPaper = workspace:GetAttribute("StaffPaper"),
    SludgeLevel = workspace:GetAttribute("SludgeLevel"),
    SludgeLevel1 = workspace:GetAttribute("SludgeLevel1"),
    DestroyedTree = workspace:GetAttribute("DestroyedTree"),
    UnlockedPark = workspace:GetAttribute("UnlockedPark"),
    Verified = workspace:GetAttribute("verified"),
    Miners = workspace:GetAttribute("Miners"),
    MultiplierTime = workspace:GetAttribute("MultiplierTime"),
    GoldMultiplierTime = workspace:GetAttribute("GoldMultiplierTime"),
    MemeMultiplierTime = workspace:GetAttribute("MemeMultiplierTime"),
    Dead = workspace:GetAttribute("Dead"),
    Alive = workspace:GetAttribute("Alive"),
    Godly = workspace:GetAttribute("Godly"),
    Gold = workspace:GetAttribute("Gold"),
    Locker = {
        Color = {colors.R, colors.G, colors.B},
        Material = workspace.UsedInScripts.PlayerLocker.Material.Value and "Metal"
    },
    Owned = owned_items
}

--game.ReplicatedStorage.Remotes.SaveData:FireServer(savedata)
--task.wait(5)
--game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/coolgoagle/ui-libs/main/rayfield/source.lua'))()

local Window = Rayfield:CreateWindow({
	Name = "homework printing simulator by coolgoagle",
	LoadingTitle = "Homework Printing Simulator",
	LoadingSubtitle = "by coolgoagle",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = "coolgoagle",
		FileName = "homework sim"
	},
	KeySystem = false
})

local function get_save_drop_values(table)
    if table == nil then return {} end
    local values = {}
    for i,v in pairs(table) do
        if type(v) == "number" then
            values[#values+1] = i
        end
    end
    return values
end

local savedatatab = Window:CreateTab("Savedata Editor")

local savedatatabmainsection = savedatatab:CreateSection("Main")

savedatatab:CreateLabel("Savedata Editor")

local currentdatalabel = savedatatab:CreateLabel("nil")

local function updatecurrentdatalabel()
    currentdatalabel:Set("Current Value: "..savedata[_G.selectedsavedataoption])
end

local savedatakeysdropdown = savedatatab:CreateDropdown({
	Name = "Data Keys",
	Options = get_save_drop_values(savedata),
	CurrentOption = "nil",
	Flag = "savedatadropdown",
	Callback = function(option)
        _G.selectedsavedataoption = option
        updatecurrentdatalabel()
	end
})

savedatatab:CreateInput({
	Name = "New Value",
	PlaceholderText = "Amount",
	RemoveTextAfterFocusLost = false,
	Callback = function(value)
        savedata[_G.selectedsavedataoption] = tonumber(value)
        updatecurrentdatalabel()
	end
})

savedatatab:CreateButton({
    Name = "Refresh Data to Current Data",
    Callback = function()
        -- Rayfield:Notify({Title = "Execute again", Content = "Sadly this UI library does not allow you to set the value of a dropdown, please re-execute to update to current data"})
        main()
    end
})

savedatatab:CreateButton({
	Name = "Save Data",
	Callback = function()
        Rayfield:Notify({Title = "Please Wait", Content = "Saving Data..."})
        game.ReplicatedStorage.Remotes.SaveData:FireServer(savedata)
        task.wait(5)
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
	end
})

end
main()