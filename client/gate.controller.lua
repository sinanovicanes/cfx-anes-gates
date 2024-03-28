local CONTROLLER_INTERVAL <const> = 100
local CreateThreadNow = Citizen.CreateThreadNow

GateController = {
    threadId = nil,
    gatesInRange = {}
}

function GateController:Add(gate)
    if self.gatesInRange[gate.hash] then return end
    self.gatesInRange[gate.hash] = gate
    self:StartThread()
end

function GateController:Remove(doorHash)
    if not self.gatesInRange[doorHash] then return end
    self.gatesInRange[doorHash] = nil
    self:StopThread()
end

function GateController:StartThread()
    if self.threadId or not next(self.gatesInRange) then return end

    CreateThreadNow(function(threadId)
        self.threadId = threadId

        while self.threadId == threadId do
            for _, gate in pairs(self.gatesInRange) do
                gate:Refresh()
            end

            Wait(CONTROLLER_INTERVAL)
        end
    end)
end

function GateController:StopThread()
    if not self.threadId or next(self.gatesInRange) then return end
    self.threadId = nil
end
