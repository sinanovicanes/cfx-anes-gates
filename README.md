# CFX-FiveM Gates

A FiveM resource to fix gate bugs.

# Installation

> Add line below to your server.cfg

```cfg
ensure cfx-anes-gates
```

[![Preview](https://img.youtube.com/vi/oCpvvmFc7fA/0.jpg)](https://www.youtube.com/watch?v=oCpvvmFc7fA)

[Preview](https://www.youtube.com/watch?v=oCpvvmFc7fA)

# How to add gates?

You can add as many gates you want from `cfx-anes-gates/config/client.lua`.

- Make sure you're adding a correct door model. E.g. prop_sec_barier_02a looks like a door but it doesn't function as a door, instead prop_sec_barrier_ld_02a is a door.
- You can get all the locations by model using [CodeWalker](https://github.com/dexyfex/CodeWalker).

```lua
Config = {
    Gates = {
        -- Gate Model
        [`prop_sec_barrier_ld_01a`] = {
            -- Can be nil
            options = {
                -- Can be nil
                -- Automatic distance
                distance = 1.0,
                -- Can be nil
                -- Automatic rate
                -- It should be minimum 1.5 or sometimes game doesn't recognize the automatic distance
                rate = 1.5,
                -- Can be nil
                -- Some gates lose their automatic distance on first set.
                -- If you're adding a new gate, set this to false and try the gate again and again. Keep this true if you see problems.
                physicsController = true
            },
            -- Gate locations. You can get all the locations by model using CodeWalker.
            locations = {
                vector3(63.6296539, -625.4576, 31.71),
                vector3(63.05773, -625.950256, 31.71),
                vector3(206.5274, -803.479736, 30.95),
                vector3(230.921814, -816.152954, 30.16),
                vector3(224.1468, -740.1342, 34.23),
                vector3(1167.28149, -1332.47632, 34.76),
                vector3(-999.3287, -2419.30933, 13.95),
                vector3(-961.235, -2796.27515, 13.95),
                vector3(-967.0093, -2802.44971, 13.95),
                vector3(-1051.40186, -474.6847, 36.61),
                vector3(-1049.28528, -476.637573, 36.75),
                vector3(2574.63, -300.641479, 92.84),
                vector3(1278.45044, -281.149231, 82.19),
                vector3(-1705.39893, 3005.64771, 32.76),
                vector3(-1705.65576, 3004.819, 32.76),
                vector3(-1588.26709, 2794.21265, 16.84),
                vector3(-1589.58264, 2793.67065, 16.85),
                vector3(-2418.97632, 3006.539, 32.71),
                vector3(2567.343, 2713.79785, 42.12),
                vector3(1896.738, 2606.179, 45.70),
                vector3(1905.11743, 2604.783, 45.78)
            }
        }
    }
}
```

# For developers

- Basically if you add gate to the door system using `AddDoorToSystem` and setting automatic rate by using `DoorSystemSetAutomaticRate` door starts to functioning. If you don't use `DoorSystemSetAutomaticRate` and set the rate higher than 1.5 game doesn't care what you set with `DoorSystemSetAutomaticDistance` (IDK WHY).
- Some gates lose their AutomaticDistance when their physics are not loaded or even if it's loaded, so you need to keep refreshing the gate.

## Why are locations statically typed?

If you want to make a dynamic approach (which was my first try) you can't check is the object is a map object. If you don't care and you still want to make it dynamic there is a second problem. Players can break the barriers and game will create a new entity with same model for broken part. So you will be targeting this broken part (Assuming you will find the gates by their models). So you will start adding bunch of invalid gates to the system. And you need to keep controlling the gate entities to remove the doors from the system when they are no longer exist. Basically you can still do it but is it worth it for a few gates?

TL;DR:
You can make it dynamic but you need to do too many checks to make it right. So it's not worth it for a few gates.

## Contributing

- You can add other gate models or edit some stuff in the code.
- PR's are welcomed as long as you know what you're doing and don't break things.

## Notes

- Gates rarely works like before but I spent too much time for this and I'm not planning to spend more.
