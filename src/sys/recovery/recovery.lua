local recovery = {}

-- All quarts require a META table from quartOS v1.0,
recovery.META = {
    "name"          = "System Recovery",      -- Pretty name of Quart.
    "author"        = "Meowcino"        -- Author name.
    "version"       = "0.0.1",          -- Pretty version of Quart.
    "suspendable"   = false,            -- Whether the quart can be suspended via Standby.
}

---	---	---
-- init function is called once when the quart is first ran
function recovery.init()

end

-- update function is repeated every time tick
function recovery.update()

end

return recovery