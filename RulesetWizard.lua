
OOB_RSW_CHANGEDBVALUE = "rswChangedbValue";
OOB_RSW_CREATECHILD = "rswCreateChild";
OOB_RSW_DELETENODE = "rswDeleteNode";

function onInit()
	OOBManager.registerOOBMsgHandler(OOB_RSW_CHANGEDBVALUE, performChangeDBValueOOB);
	OOBManager.registerOOBMsgHandler(OOB_RSW_CREATECHILD, performCreateChildOOB);
	OOBManager.registerOOBMsgHandler(OOB_RSW_DELETENODE, performDeleteNodeOOB);	
end
		
function performChangeDBValueOOB(msgOOB)
	local dbNode = DB.findNode(msgOOB.path);
	if dbNode then
		dbNode.setValue(msgOOB.newValue);
	else
		ChatManager.SystemMessage("ERROR. Cannot find dbNode " .. msgOOB.path); 		
	end
end

function performCreateChildOOB(msgOOB)
	local dbNode = DB.findNode(msgOOB.path);
	if dbNode then
		if msgOOB.name then
			if msgOOB.nodetype then
				DB.createChild(dbNode, msgOOB.name, msgOOB.nodetype);
			else
				DB.createChild(dbNode, msgOOB.name);
			end;
		else
			DB.createChild(dbNode);
		end;
	else
		ChatManager.SystemMessage("ERROR. Cannot find dbNode " .. msgOOB.path);
	end
end

function performDeleteNodeOOB(msgOOB)
	local dbNode = DB.findNode(msgOOB.path);
	if dbNode then
		DB.deleteNode(dbNode);
	else
		ChatManager.SystemMessage("ERROR. Cannot find dbNode " .. msgOOB.path);
	end
end

function changeDBValueOOB(dbNode, newValue)
	local msgOOB = {};
	msgOOB.type = OOB_RSW_CHANGEDBVALUE;
	msgOOB.newValue = newValue;
	callOOB(msgOOB, dbNode);
end

function createDBChildOOB(dbNode, name, nodetype)
	local msgOOB = {};
	msgOOB.type = OOB_RSW_CREATECHILD;
	msgOOB.name = name;
	msgOOB.nodetype = nodetype;
	callOOB(msgOOB, dbNode);
end

function deleteDBNodeOOB(dbNode)
	local msgOOB = {};
	msgOOB.type = OOB_RSW_DELETENODE;
	callOOB(msgOOB, dbNode);
end

function callOOB(msgOOB, dbNode)
	if not dbNode then
		ChatManager.SystemMessage("ERROR. Cannot find dbNode"); 
		return;
	end
	
	if dbNode.getPath then
		msgOOB.path = dbNode.getPath();
	else
		msgOOB.path = dbNode;
	end
	
	Comm.deliverOOBMessage(msgOOB, "");
end
    