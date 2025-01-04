local manual = {}

-- All quarts require a META table from quartOS v1.0,
manual.META = {
    "name"          = "Out of Box Experience",      -- Pretty name of Quart.
    "author"        = "Meowcino"        -- Author name.
    "version"       = "0.0.1",          -- Pretty version of Quart.
    "suspendable"   = false,            -- Whether the quart can be suspended via Standby.
}

---	---	---
-- init function is called once when the quart is first ran
function manual.init()

end

-- update function is repeated every time tick
function manual.update()

end

return manual