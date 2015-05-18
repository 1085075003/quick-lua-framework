
function __G__TRACKBACK__(errorMessage)
	print("----------------------------------------");
	local msg = "LUA ERROR: " .. tostring(errorMessage) .. "\n";
	msg = msg..debug.traceback("", 2);
	print(msg);
	print("----------------------------------------");
    
    if DEBUG > 0 then
    	showErrorMsg(msg);
    end
end

package.path = package.path .. ";src/"
cc.FileUtils:getInstance():setPopupNotify(false)
require("app.MyApp").new():run()
