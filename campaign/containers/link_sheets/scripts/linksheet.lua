function onInit()
	onLockChanged();
	DB.addHandler(DB.getPath(getDatabaseNode(), "locked"), "onUpdate", onLockChanged);
end

function onClose()
	DB.removeHandler(DB.getPath(getDatabaseNode(), "locked"), "onUpdate", onLockChanged);
end

function onLockChanged()
	if header.subwindow then
		header.subwindow.update();
	end
	if content.subwindow then
		content.subwindow.update();
	end
end

function updateName(sName)
	--local sName = window.name.getValue();
	local sToolTipTest = getTooltipText();
	Debug.chat("sName",sName, "sToolTipTest",sToolTipTest);
	
	local sToolTip = ""
	if string.len(sName) > 0 then
		sToolTip = sName;
	else
		sToolTip = "url";
	end
	
	setTooltipText(sToolTip);
	sToolTipTest = getTooltipText();
	Debug.chat("sName",sName, "sToolTipTest",sToolTipTest);
end