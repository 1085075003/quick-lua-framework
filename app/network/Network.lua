-- http communication
local Network = class("Network");

-- server URL
local SERVER_URL = "";

-- route which need add waiting sign
local filters = {};

function Network:ctor()
end

function Network:sendMsgToServer(route, callback, keys)
	local function onRequestFinished(data)
		if data.name == "completed" then
			local request = data.request;
			local response = request:getResponseString();
			local code = request:getResponseStatusCode();

			if code ~= 200 then

				-- error, do something according to route
				error("route = "..route);
				return;
			end

			-- callback succeed
			response = json.decode(response);
			callback(response);
		end
	end
	
	local request = network.createHTTPRequest(onRequestFinished, SERVER_URL..route, "POST");

	-- set parameters
	for k, v in pairs(keys) do
		request:addPOSTValue(k, v);
	end

	-- Setting the route, forbid user to send same message to server in a short period of time
	self:setWaiting(route);

	request:setTimeout(5);
	request:start();
end

-- Setting the route, forbid user to send same message to server in a short period of time, like:click a button to buy something
function Network:setWaiting(route)

	if table.indexof(filters, route) then
		
		-- add a container to swallow

	end
end
gNetwork = Network.new();