--[[
	Use to replicate the GUI to new players.
--]]

-- Scripts --
script.Parent:WaitForChild("StartExec")

GUI=script.chatGui

function insertgui(player)
	if not player.PlayerGui:findFirstChild(GUI.Name) then
		GUI:Clone().Parent=player.PlayerGui
	end
end

local alreadyadded = {}

local players = game.Players:GetChildren()
for i=1, #players do
	table.insert(alreadyadded, players[i])
	players[i].CharacterAdded:connect(function()
		insertgui(players[i])
	end)
	insertgui(players[i])
end

game.Players.PlayerAdded:connect(function(p)
	local added = false
	for i=1, #alreadyadded do
		if alreadyadded[i] == p then
			added = true
		end
	end
	if added == false then
		p.CharacterAdded:connect(function()
			insertgui(p)
		end)
	end
end)
