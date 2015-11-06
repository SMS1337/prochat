-- needs cleaning

local version = script.Parent:WaitForChild("Version").Value
local modelid = 234218451

local model = game:GetService("InsertService"):LoadAsset(modelid)
model = model:GetChildren()[1]

local function printf(text)
	game:GetService('TestService'):Warn(false, " [ ProChat Auto Update Function ] "..text)
end

local function continue()
	canrun = Instance.new("BoolValue")
	canrun.Name = "StartExec"
	canrun.Parent = script.Parent
end

if model~= nil then -- If it's not trusted, it will nil. 
	if model:WaitForChild("Version").Value > version then
		model:WaitForChild("Settings"):Destroy()
		local realsettings = script.Parent:WaitForChild("Settings"):Clone()
			realsettings.Parent = model

		printf("ProChat just automagically updated to version " .. model:WaitForChild("Version").Value.. ", courtesy of the ProChat contributers")
		printf("Don't worry, all your settings should carry over, you should consider manually updating sometime though")
		printf("If an update added new settings, they will be set to their default values")
		
		model.Parent = script.Parent.Parent
		script.Parent:Destroy()
	else
		print("did not update")
		continue()
	end
else -- If the model is nil
	printf"Auto Update was disabled due to an fatal error."
	continue()
	script.Disabled=true
end
