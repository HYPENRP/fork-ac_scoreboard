local Config = require 'config'
local Utils = require 'modules.server.utils'
local VisibleSections = Config.visibleSections

local Players = nil
local Groups = nil
local Indicators = nil

SetTimeout(0, function()
    if VisibleSections.players then
        Players = require 'modules.server.sections.players'
    end

    if VisibleSections.groups then
        local framework = Utils.getFramework()

        if framework then
            Groups = require(('modules.server.sections.groups.%s'):format(framework))
        else
            lib.print.warn('No compatible framework found. Group section was automatically disabled.')
        end
    end

    if VisibleSections.statusIndicators then
        Indicators = require 'modules.server.sections.indicators'
    end
end)


local sv_maxclients = GetConvarInt('sv_maxclients', 0)
AddConvarChangeListener('sv_maxclients', function()
    sv_maxclients = GetConvarInt('sv_maxclients', 0)
end)



---@param playerId number
---@param section string
---@return boolean
local function canShowSection(playerId, section)
    local state = VisibleSections[section]
    return state == true or state == 'limited' and IsPlayerAceAllowed(tostring(playerId), ('scoreboard.show.%s'):format(section))
end


---@param playerId number
---@return table
lib.callback.register('ac_scoreboard:getServerData', function(playerId)
    local payload = {}

    if Players and canShowSection(playerId, 'players') then
        payload.players = Players.getPlayers(canShowSection(playerId, 'playerNames'), canShowSection(playerId, 'playerIds'))
    end

    if Groups and canShowSection(playerId, 'groups') then
        payload.groups = canShowSection(playerId, 'groupCount') and Groups.getAllGroupsCounts() or {}
    end

    if Indicators and canShowSection(playerId, 'statusIndicators') then
        payload.statusIndicators = Indicators.getStates()
    end

    if canShowSection(playerId, 'footer') then
        payload.footer = {
            maxPlayers = sv_maxclients,
            playerCount = GetNumPlayerIndices(),
        }
    end

    return payload
end)
