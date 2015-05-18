
require("config")
require("cocos.init")
require("framework.init")

-- 工具类
require("app.utils.Utils");
require("app.utils.EffectUtils");
require("app.utils.MemoryUtils");
require("app.utils.MathUtils");
require("app.utils.NumericalUtil");

-- 通信
require("app.network.Network");

-- 一些基类
require("app.base.ModuleBase");

-- 事件管理
require("app.event.GlobalEvent");

-- 一些公用UI
require("app.commonView.TransitionView");
require("app.commonView.PopView");
require("app.commonView.CustomProgressBar");

-- 动画
require("app.animation.AnimationManager");

-- 本地数据
require("app.LocalData");

local MyApp = class("MyApp", cc.mvc.AppBase);
function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    
    -- 资源管理
	require("app.assets.AssetsMgr");

    -- 进入场景
    require("app.scenes.SceneManager");

	-- config
	require("app.CSVLoader");
	require("app.config.ConfigManager");

	-- 战斗相关
	require("app.battle.BattleBase");
	require("app.battle.BattleView");
	require("app.battle.UserBattleMgr");
	require("app.battle.BattleArmy");
	require("app.battle.BattleTeam");
	require("app.battle.BattleHuman");
	require("app.battle.BattleSoldier");
	require("app.battle.BattleHero");
	require("app.battle.BattleEffectView");
	require("app.battle.formation.FormationView");
	require("app.battle.formation.FormationSoldierView");
	require("app.battle.skill.SkillBase");
	require("app.battle.skill.SkillTable");
	require("app.battle.skill.SkillButtonView");

	-- 用户数据类
	require("app.user.User");
end
return MyApp


	-- for debug
	-- local url = "http://192.168.1.10/index.php?method=IndexAction.index";
	-- local t = {add="2", device=1, fid="wo07", pf_access_token="111", session="1111", uid="wo07"};
	-- local request;
	-- local function callback(data)
	-- 	if data.name == "completed" then
	-- 		local request = data.request;
	-- 		local response = request:getResponseString();
	-- 		local code = request:getResponseStatusCode();

	-- 		if code ~= 200 then

	-- 			-- error, do something according to route
	-- 			error("route = "..route);
	-- 			return;
	-- 		end

	-- 		-- callback succeed
	-- 		response = json.decode(response);
	-- 		cclog(response);
	-- 		cclog("length:"..request:getResponseDataLength());
	-- 	end
	-- end
	-- request = network.createHTTPRequest(callback, url, "POST");
	-- request:setAcceptEncoding(1);
	-- for i,v in pairs(t) do
 --        request:addPOSTValue(i, v)
 --    end
 --    request:start();
