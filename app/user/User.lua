-- 用户
local User = class("User", ModuleBase);

-- 初始化各个模块的manager
function User:init()
	self.managers = {};

	-- 创建战斗管理
	local manager = UserBattleMgr.new();
	self:addUserModule("battle", manager);
end

-- 创建一个模块
function User:addUserModule(moduleName, manager)
	self.managers[moduleName] = manager;
end

-- 获取一个模块
function User:getModule(moduleName)
	return self.managers[moduleName];
end

gUser = User.new();