local memtest = {}

-- All quarts require a META table from quartOS v1.0,
memtest.META = {
    "name"          = "Memory Test",    -- Pretty name of Quart.
    "author"        = "Meowcino"        -- Author name.
    "version"       = "0.0.1",          -- Pretty version of Quart.
    "suspendable"   = false,            -- Whether the quart can be suspended via Standby.
}

---	---	---
memtest.memory_table = {}

function memtest.getFlashMemoryTable()
    log("Inspecting memory, please wait...")
    local totalMem = 0
    local memoryWall = false
    local memID = 1
    while memoryWall do
        local memoryComponent = gdt["FlashMemory" .. memID]
        if memoryComponent == nil then
            log("Memory inspected.") 
            memoryWall = false
        else
            memtest.memory_table[memID] = memoryComponent
            totalMem += memoryComponent.Size
            memID += 1
        end
    end
    print("There are " .. (memID-1) .. " memory blocks.")
    print("Total capacity: " .. totalMem/1024 .. "KB.")
end

function memtest.getAvailMem()
	local avail = 0
	local FM	= memtest.memory_table
	
	for MEM in FM do
			avail += (FM[MEM].Size - FM[MEM].Usage)
			--print(avail)
	end
	avail = math.ceil(avail/1024)
	return avail
end

-- init function is called once when the quart is first ran
function memtest.init()

end

-- update function is repeated every time tick
function memtest.update()
	--gfx:DrawSprite(vec2(108, 12), HSPR,4,1,color.white, color.clear)
    print("MEMTEST")
end

return memtest