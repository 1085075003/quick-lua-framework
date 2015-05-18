-- 场景管理
local SceneManager = class("SceneManager");

-- 最顶层
local TOP_LEVEL_1 = 128;
local TOP_LEVEL_2 = 127;

-- 初始化
function SceneManager:ctor()
	self.scene = display.newScene();
	if cc.Director:getInstance():getRunningScene() then
		cc.Director:getInstance():replaceScene(self.scene);
	else
		cc.Director:getInstance():runWithScene(self.scene);
	end
end

-- 进入战斗场景
function SceneManager:enterBattle(info, callback)
	local function transitionOnEnter()

		-- 加载战斗需要的资源，并且释放不用的资源
		gAsset:loadBattleSource(info, callback);
	end

	-- 取得过场界面
	self:transitionScene(transitionOnEnter);
end

-- 进入上阵界面
function SceneManager:enterFormation(info, callback)
	local function transitionOnEnter()

		-- 加载上阵需要的资源，并且释放不用的资源
		gAsset:loadFormationSource(info, callback);
	end

	-- 取得过场界面
	self:transitionScene(transitionOnEnter);
end

-- 过度动画
function SceneManager:transitionScene(callback)

	-- 播放过场动画
	local view = TransitionView.new(callback);
	view:addTo(self.scene, TOP_LEVEL_1);
end

-- 切换场景
function SceneManager:replaceScene(scene)
	cc.Director:getInstance():replaceScene(scene);
	self.scene = scene;
end

-- 添加一个界面在目前的scene上面
function SceneManager:addView(node)
	self.scene:addChild(node);
end

-- 添加一个node到顶层
function SceneManager:addTopView(node)
	self.scene:addChild(node, TOP_LEVEL_1);
end

-- 在scene上添加一个回调(这个不会被暂停)
function SceneManager:performWithDelay(callback, delay)
	self.scene:performWithDelay(callback, delay);
end
gSceneMgr = SceneManager.new();
