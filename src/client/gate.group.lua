local PHYSICS_CONTROLLER_INTERVAL <const> = 2000
local DoorSystemGetIsPhysicsLoaded = DoorSystemGetIsPhysicsLoaded

GateGroup = {}
GateGroup.__index = GateGroup

function GateGroup:New(model, locations, options)
    local this = setmetatable({
        model = model,
        gates = {},
        options = options or {}
    }, self)

    this:InitGates(locations)
    this:StartPhysicsController()

    return this
end

function GateGroup:InitGates(locations)
    for i, coords in pairs(locations) do
        self.gates[i] = Gate:New(self, coords, i)
    end
end

function GateGroup:StartPhysicsController()
    if not self.options.physicsController then return end
    self.options.physicsController = nil

    CreateThread(function()
        while true do
            for _, gate in ipairs(self.gates) do
                if DoorSystemGetIsPhysicsLoaded(gate.hash) then
                    GateController:Add(gate)
                else
                    GateController:Remove(gate.hash)
                end
            end

            Wait(PHYSICS_CONTROLLER_INTERVAL)
        end
    end)
end
