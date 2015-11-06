local Class = {}
Class.__index = Class

setmetatable(Class, {
  	__call = function (cls, ...)
	return cls.new(...)
  end,
})

Class.new = function(classes, deleteafter)
	local self = setmetatable({}, Class)
	self.classes = classes
	self.DeleteAfter = deleteafter
	self.MessageFrames = {}
	return self
end

Class.AddMessage = function(self, messageframe)
	for i=1, #self.MessageFrames do
		self.MessageFrames[i].DistanceFromNewest = self.MessageFrames[i].DistanceFromNewest+1
	end
	table.insert(self.MessageFrames,self.classes["Message"].new(self.classes, messageframe, self.DeleteAfter))
	for i=1, #self.MessageFrames do
		self.MessageFrames[i]:UpdatePos()
	end
	for i=1, #self.MessageFrames do
		if self.MessageFrames[i] ~= nil then
			if self.MessageFrames[i]:CheckForDeletion() == true then
				table.remove(self.MessageFrames, i)
			end
		end
	end
	--print(#self.MessageFrames)
end

Class.ReplicateMessagesToPlayer = function(self, playername)
	for i=1, #self.MessageFrames do
		self.MessageFrames[i]:ReplicateBackToPlayer(playername)
	end
end

return Class
