local opened = false
local initialDataSet = false

local function sendNuiMessage(action, data)
	SendNUIMessage({
		action = action,
		data = data
	})
end

local function handleClose()
	SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
	opened = false
end

local function getGroups()
	local groupData = {}
	for i=1, #ac.groupList do
		local group = ac.groupList[i]
		local count = 0
		for j=1, #group.groups do
			count += GlobalState[('%s:count'):format(group.groups[j])] or 0
		end

		groupData[#groupData + 1] = {
			label = group.label,
			count = count
		}
	end

	return groupData
end

local function setData()
	local data = lib.callback.await('ac_scoreboard:getData', false)

	if not initialDataSet then
		initialDataSet = true
		data.serverName = ac.serverName
		data.serverId = cache.serverId
	end

	data.playerCount = GetNumberOfPlayers()
	data.groups = getGroups()

	sendNuiMessage('setData', data)
end

RegisterKeyMapping('scoreboard', 'Open scoreboard', 'keyboard', 'DELETE')

RegisterCommand('scoreboard', function()
	if opened then
		handleClose()
		sendNuiMessage('setVisible', false)
		return
	end

	opened = true

	CreateThread(function()
		while opened do
			DisablePlayerFiring(cache.playerId, true)
			HudWeaponWheelIgnoreSelection()
			DisableControlAction(0, 1, true)
			DisableControlAction(0, 2, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 200, true)

			Wait(0)
		end
	end)

	setData()

	SetNuiFocus(true, true)
	SetNuiFocusKeepInput(true)

	sendNuiMessage('setVisible', true)
end)

RegisterNUICallback('close', function(_, cb)
	cb(1)
	handleClose()
end)
