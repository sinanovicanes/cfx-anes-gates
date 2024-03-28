local gates = Config?.Gates or {}

for model, gate in pairs(gates) do
    GateGroup:New(model, gate.locations, gate.options)
end

gates = nil
Config = nil
collectgarbage()
