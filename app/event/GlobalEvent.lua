-- addListener for events 

GlobalEvent = class("GlobalEvent");

-- extend from EventProtocol
function GlobalEvent:ctor()
	cc.GameObject.extend(self):addComponent("components.behavior.EventProtocol"):exportMethods();
	self.eventDispatcher = cc.Director:getInstance():getEventDispatcher();
end

-- two interface for node
-- add listener in a node, it will removed when the node removed
function GlobalEvent:addListenerToNode(eventName, node, handleFunc)
	local listener = cc.EventListenerCustom:create(eventName, handleFunc);
	self.eventDispatcher:addEventListenerWithSceneGraphPriority(listener, node);
end

-- dispatch event
-- event：the type of event is table, must take a parameter, name
function GlobalEvent:dispatchEvent(event)
	local dispatchEvent = cc.EventCustom:new(event.name);
	for i, v in pairs(event) do
		dispatchEvent[i] = v;
	end
	if dispatchEvent then 
		self.eventDispatcher:dispatchEvent(dispatchEvent);
	end
end

-- two interface for not node
-- be care for:the node is removed, but the listener is still there
function GlobalEvent:addListener(eventName, handleFunc)
	self:addEventListener(eventName, handleFunc)
end

-- event:table
function GlobalEvent:dispatch(event)
	self:dispatchEvent(event);
end

-- a global variable
gEvent = GlobalEvent.new();