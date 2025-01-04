local memtest = {}

--[[
[!] Do not edit/remove this comment, you'll need this information. 

[+] BIOS Memory Test (memtest.qrt)
-- Description --
Ensures flashmemory is valid and provides memory data to the BIOS.

-- Version Metadata --
Quart Ver: 0.9
qOS Ver: 0.9

-- Notes -- 
RTM Version.

-- [!] Warning [!] -- 
Only install this quart when:
1. It's part of an overall qOS system update. 
2. It's a patch intended for the version of qOS you are using. 

Failing to follow these instructions can cause problems, and 
even corrupt Quartet's onboard flash memory.

]]--

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

-- update function is repeated every time tick
function memtest.update()
	--gfx:DrawSprite(vec2(108, 12), HSPR,4,1,color.white, color.clear)
    print("MEMTEST")
end

return memtest