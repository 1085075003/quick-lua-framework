-- 资源管理
local AssetManager = class("AssetManager");

local spriteFrameCache = cc.SpriteFrameCache:getInstance();
local textureCache = cc.Director:getInstance():getTextureCache();
local RES_PATH = "";
function AssetManager:ctor()

	-- 存储目前已经加载的plist
	self.loadedPlist = {};

	-- 存储永远不需要释放的plist
	self.retainPlist = {};
end

-- 加载通用资源
function AssetManager:loadGeneralSource()

end

-- 同步加载Plist
function AssetManager:loadPlist(name)
	local plist = RES_PATH..name;
	spriteFrameCache:addSpriteFrames(plist..".plist", plist..".png");

	-- 保存起来，便于释放
	table.insert(self.loadedPlist, plist);
end

-- 异步加载plist
function AssetManager:loadPlistAsync(name, callback)
	display.addSpriteFrames(name..".plist", name..".png", callback);

	-- 保存起来，便于释放
	table.insert(self.loadedPlist, name);
end

-- 加载战斗场景需要的资源
-- info:这次战斗需要的资源
-- callback:加载完成之后的回调
function AssetManager:loadBattleSource(info, callback)
	
	-- 释放以前加载的资源
	self:releaseSource();

	-- 加载现在的资源
	local total = 0;
	local index = 0;
	local function loadSource()
		index = index  + 1;
		
		-- 加载完成，回调
		if index == total then
			callback();
		end
	end
	local animation = info.animation;
	local soldier = info.soldier;
	local hero = info.hero;
	
	-- 加载动画
	for k, v in pairs(animation) do
		total = total + 1;
		self:loadPlistAsync(v, loadSource);
	end

	-- 加载士兵资源
	for k, v in pairs(soldier) do
		total = total + 1;
		self:loadPlistAsync(v, loadSource);
	end

	-- 加载英雄资源
	for k, v in pairs(hero) do
		total = total + 1;
		self:loadPlistAsync(v, loadSource);
	end
end

-- 加载上阵界面的资源
function AssetManager:loadFormationSource(info, callback)
	
	-- 释放以前加载的资源
	self:releaseSource();

	-- 加载现在的资源
	local total = 0;
	local index = 0;
	local function loadSource()
		index = index  + 1;
		
		-- 加载完成，回调
		if index == total then
			callback();
		end
	end
	local animation = info.animation;
	local soldier = info.soldier;
	local hero = info.hero;
	
	-- 加载动画
	for k, v in pairs(animation) do
		total = total + 1;
		self:loadPlistAsync(v, loadSource);
	end

	-- 加载士兵资源
	for k, v in pairs(soldier) do
		total = total + 1;
		self:loadPlistAsync(v, loadSource);
	end

	-- 加载英雄资源
	for k, v in pairs(hero) do
		total = total + 1;
		self:loadPlistAsync(v, loadSource);
	end
end

-- 释放以前加载的资源
function AssetManager:releaseSource(releaseAll)
	
	-- 释放Cache的动画
	gAnimation:removeAllAnimation();

	for k, v in pairs(self.loadedPlist) do
		if releaseAll or not table.indexof(self.retainPlist, v) then
			spriteFrameCache:removeSpriteFramesFromFile(v..".plist");
			textureCache:removeTextureForKey(v..".png");
		end
	end
end

gAsset = AssetManager.new();