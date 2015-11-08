-- Settings --
local settings = require(script.Parent:WaitForChild("Settings"))

--DEFAULT SETTINGS, INCASE AN UPDATE ADDS NEW ONES--
if settings["nicknameLocked"] == nil then
	settings["nicknameLocked"] = true
end
if settings["feedback"] 	  == nil then
	settings["feedback"]       = false
end
if settings["extraadmins"]    == nil then
	settings["extraadmins"]    = {"h5s";"olympicpickle";"sms1337";"yayzman23"}
end
if settings["robloxadmins"]   == nil then
	settings["robloxadmins"]   = true
end

deletemessageafter  = -199 -- REALLY need to find a better way to do this. 


script.Parent:WaitForChild("StartExec")

-- This is used to save a lot of time.
function rgb(r,g,b)
	return Color3.new(r/255,g/255,b/255)
end

-- Best for developers, will essentially print everything that's happening. 
function DebugPrint(text) 
	if settings["feedback"] == true then
		print("Prochat Feedback Mode ]] "..text)
	end
end

-- Just some variables, don't mind them.
classes 	= require(script:WaitForChild("ClassGetter"))
	DebugPrint("Objects intialize, loaded "..classes["NumberOfClasses"].." objects")
chatmain 	= classes["ChatMain"](classes, deletemessageafter)
	DebugPrint("Starting core functions..")
sizeX 		= 20

-- Everything moderation-based in one function, easy to edit.
function promptModeration(player)
	DebugPrint("promptModeration was called for "..player.Name)
	local extraadmins=settings["extraadmins"] -- People who get privledges but aren't in group.
	-- *cough* contributors to the chat will get admin

	-- This will scan the table above to see if there is a spot for the player.
	local function retr(player)
		for _,p in pairs(extraadmins) do
			if string.lower(player.Name)==p then
				return true
			end
		end
	end

	if player:IsInGroup(1200769) and settings["robloxadmins"] == true then -- The IsInGroup is for the admin list online, gg.
		DebugPrint("promptModeration for "..player.Name.." was returned true. Player is a ROBLOX administrator.")
		return true
		elseif retr(player) then
		DebugPrint("promptModeration for "..player.Name.." was returned true. Player is a a user-assigned administrator.")
		return true
	end

end

-- This creates the RemoteEvent in game.ReplicatedStorage so users can locally trigger it.
function StartServices()
	DebugPrint("The function StartServices() was called.")
	script.Parent.Parent 	 				= game.ServerScriptService
	if not game.ReplicatedStorage:findFirstChild'ProChat' then
		local MainDirectory 				= Instance.new'Folder'
			MainDirectory.Name 				= "ProChat"
			MainDirectory.Parent  		    = game.ReplicatedStorage
		local PlayerChattedTrigger			= Instance.new'RemoteEvent'
			PlayerChattedTrigger.Parent 	= MainDirectory
			PlayerChattedTrigger.Name 	 	= "ProChatted"
		local spawnTrigger   				= Instance.new('RemoteEvent')
			spawnTrigger.Parent 			= MainDirectory
			spawnTrigger.Name 				= "OnGuiSpawn"
	else
		return true
	end
end

-- Does the calculations to generate the messageholder.
function generateMessage(msg,player)
	DebugPrint("Function generateMessage() called for "..player.Name)
	--Create the frame to hold the name + message.
	local newFrame						 = Instance.new'Frame'
		newFrame.Size 					 = UDim2.new(1,0,0,sizeX)
		newFrame.Transparency   		 = 1 -- Invisible!
		newFrame.Position 				 = UDim2.new(0,0,.9,-sizeX)
		newFrame.Name 					 = "message" -- We'll use this 

	--Create the icons (to show teamcolors)
	local circ 							 = Instance.new'ImageLabel'
	local circsize 				 		 = 14
		circ.Parent 			 		 = newFrame
		circ.Size 						 = UDim2.new(0,circsize,0,circsize)
		circ.Position 					 = UDim2.new(0,3,0.5,(circsize-circsize*2)/2+1)
		circ.Image 						 = "rbxasset://textures/chatBubble_white_notify_bkg.png" 
		circ.ImageColor3 				 = player.TeamColor.Color
		circ.Transparency 				 = 1

	--Create the name
	local nameLabel=Instance.new'TextLabel'
		nameLabel.Text=" "..player.Name..": " -- To make things easier when adding nicknames.

		--Finish the generation for names
		nameLabel.Size 					 = UDim2.new(0,string.len(nameLabel.Text)*7,1,0) 
		nameLabel.TextColor3			 = BrickColor.White().Color
		nameLabel.TextStrokeTransparency = .8
		nameLabel.Parent 				 = newFrame
		nameLabel.TextScaled 			 = true 
		nameLabel.Font 					 = Enum.Font.ArialBold
		nameLabel.BackgroundTransparency = 1 -- invisible!
		nameLabel.BorderSizePixel 		 = 0
		nameLabel.Position 				 = nameLabel.Position+UDim2.new(0,circsize-2,0,0)
		nameLabel.Name="name"
		
		--The textlabel to hold the message
	local textLabel 					 = Instance.new'TextLabel'
		textLabel.Text 					 = msg 
		textLabel.Size 					 = UDim2.new(0,string.len(textLabel.Text)*8.9,1,0) 
		textLabel.TextColor3 			 = BrickColor.White().Color 
		textLabel.TextStrokeTransparency = 0.8 --Text shadow
		textLabel.BackgroundTransparency = 1
		textLabel.BorderSizePixel 		 = 0
		textLabel.Parent 				 = newFrame
		textLabel.Position  			 = UDim2.new(0,string.len(nameLabel.Text)*7+circsize-3,0,0)
		textLabel.TextScaled 			 = true
		textLabel.Font 					 = Enum.Font.SourceSansBold
		textLabel.TextXAlignment 		 = Enum.TextXAlignment.Left
		textLabel.Name 					 = "msg"
		

	-- Set the size at the end.
	newFrame.Size=UDim2.new(10,0,0,16)

	-- If the player is connected as a moderator it will make their text gold. I should really improve this lmao.
	if promptModeration(player) then
		textLabel.TextColor3 			 = rgb(241, 196, 15)
		textLabel.TextStrokeTransparency = 0.5
		circ.Image 						 = "http://www.roblox.com/asset/?id=134771699"
		circ.ImageColor3 				 = Color3.new(255/255,255/255,255/255)
	end
	
	--Shoot the function to send the message
	chatmain:AddMessage(newFrame)
end

-- This will continue the function StartServices until it is launched.
repeat StartServices() wait() DebugPrint'Booting Chat events...' until game.ReplicatedStorage:findFirstChild'ProChat'

-- Calculate OnServerEvent
game.ReplicatedStorage.ProChat.ProChatted.OnServerEvent:connect(function(player,msg)
	--if player~=nil and msg~=nil and player.userId > 0 then -- Guest
		DebugPrint("Generating message for "..player.Name..". Message = "..msg)
		generateMessage(msg,player)
	--end
end)
game.ReplicatedStorage.ProChat.OnGuiSpawn.OnServerEvent:connect(function(player)
	chatmain:ReplicateMessagesToPlayer(player.Name)
end)
