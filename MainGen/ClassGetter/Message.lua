local Class = {}
Class.__index = Class

setmetatable(Class, {
  	__call = function (cls, ...)
	return cls.new(...)
  end,
})

Class.new = function(classes, frame, deleteafter)
	local self = setmetatable({}, Class)
	self.classes = classes
	self.DistanceFromNewest = 0
	self.OriginalFrame = frame
	self.DeleteAfter = deleteafter
	self.PlayerReplications = {}
	local sizeX = 20
	local plrs = game.Players:GetChildren()
	for i=1, #plrs do
		if plrs[i]:FindFirstChild("PlayerGui") then
			if plrs[i]:FindFirstChild("PlayerGui"):FindFirstChild("chatGui") then
				if plrs[i]:FindFirstChild("PlayerGui"):FindFirstChild("chatGui"):FindFirstChild("Frame") then
					local msg = frame:Clone()
					msg.Parent = plrs[i]:FindFirstChild("PlayerGui"):FindFirstChild("chatGui"):FindFirstChild("Frame")
					msg.Position=UDim2.new(-1,0,1,sizeX-sizeX*2)
					--msg:TweenPosition(UDim2.new(0,0,1,sizeX-sizeX*2),"Out","Linear",0.05,true)
					self.PlayerReplications[plrs[i].Name] = msg
				end
			end
		end
	end
	
	return self
end

Class.UpdatePos = function(self)
	local sizeX = 20
	for k,v in pairs(self.PlayerReplications) do
		if v ~= nil and v.Parent ~= nil then
			v:TweenPosition(UDim2.new(0,0,1,(sizeX-sizeX*2)-(sizeX*self.DistanceFromNewest)),"Out","Linear",0.05,true)
			if v.Position.Y.Offset < self.DeleteAfter then
				v:Destroy()
				self.PlayerReplications[k] = nil
			end
		else
			v:Destroy()
			self.PlayerReplications[k] = nil
		end
	end
end

Class.RemoveFromPlayer = function(self, playername)
	if self.PlayerReplications[playername] ~= nil then
		self.PlayerReplications[playername]:Destroy()
		self.PlayerReplications[playername] = nil
	end
end

Class.ReplicateBackToPlayer = function(self, playername)
	local sizeX = 20
	self:RemoveFromPlayer(playername)
	if game.Players:FindFirstChild(playername) then
		if game.Players:FindFirstChild(playername):FindFirstChild("PlayerGui") then
			if game.Players:FindFirstChild(playername):FindFirstChild("PlayerGui"):FindFirstChild("chatGui") then
				if game.Players:FindFirstChild(playername):FindFirstChild("PlayerGui"):FindFirstChild("chatGui"):FindFirstChild("Frame") then
					local msg = self.OriginalFrame:Clone()
					msg.Parent = game.Players:FindFirstChild(playername):FindFirstChild("PlayerGui"):FindFirstChild("chatGui"):FindFirstChild("Frame")
					msg.Position=UDim2.new(-1,0,1,sizeX-sizeX*2)
					self.PlayerReplications[playername] = msg
					self:UpdatePos()
				end
			end
		end
	end
end

Class.CheckForDeletion = function(self)
	local shoulddelete = true
	for k,v in pairs(self.PlayerReplications) do
		shoulddelete = false
	end
	return shoulddelete
end

return Class
