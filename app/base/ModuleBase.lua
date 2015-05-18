-- user module base

ModuleBase = class("ModuleBase");
function ModuleBase:ctor(name)
	self.name = name;
	self:init();
end

-- initialize something in derived class
function ModuleBase:init()
end

-- handle http msg from server, override it in derived class
function ModuleBase:handleMsg(route, data)
end

-- send http msg to server
function ModuleBase:sendMsgToServer(route, keys)
	local function callback(data)
		self:handleMsg(route, data);
	end
	gNetwork:sendMsgToServer(route, callback, keys);
end