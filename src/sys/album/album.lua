local album = {}

-- All quarts require a META table from quartOS v1.0,
album.META = {
    "name"          = "Photo Album",      -- Pretty name of Quart.
    "author"        = "Meowcino"        -- Author name.
    "version"       = "0.0.1",          -- Pretty version of Quart.
    "suspendable"   = true,            -- Whether the quart can be suspended via Standby.
}

---	---	---
-- init function is called once when the quart is first ran
function album.init()

end

-- update function is repeated every time tick
function album.update()

end

return album