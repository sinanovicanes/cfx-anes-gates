local DEFAULT_AUTOMATIC_DISTANCE <const> = Config?.DefaultAutomaticDistance or 1.5
local DEFAULT_AUTOMATIC_RATE <const> = Config?.DefaultAutomaticRate or 1.5
local DoorSystemSetAutomaticDistance = DoorSystemSetAutomaticDistance
local DoorSystemSetAutomaticRate = DoorSystemSetAutomaticRate

Gate = {}
Gate.__index = Gate

function Gate:New(group, coords, gateIndex)
    local onSystem, doorHash = DoorSystemFindExistingDoor(coords.x, coords.y, coords.z, group.model)
    
    if not onSystem then
        doorHash = GetHashKey(("_GATE_%d_CONTROLLER_%d"):format(group.model, gateIndex))
        AddDoorToSystem(doorHash, group.model, coords.x, coords.y, coords.z, false, false, false)
    end

    local this = setmetatable({
        group = group,
        hash = doorHash
    }, self)

    this:Refresh()

    return this
end

function Gate:Refresh()
    DoorSystemSetAutomaticDistance(self.hash, self.group.options.distance or DEFAULT_AUTOMATIC_DISTANCE, false, true)
    DoorSystemSetAutomaticRate(self.hash, self.group.options.rate or DEFAULT_AUTOMATIC_RATE, false, true)
end
