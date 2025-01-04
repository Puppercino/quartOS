qrt = {}
process = {}

---	---	---

bios.osVer = 0
bios.osVerString = "0.5.0"

-- BOOT UP 
-- BARE MINIMUM COMPONENTS
gfx = gdt.VideoChip0
FNT = gdt.ROM.System.SpriteSheets["StandardFont"]

-- System memory is for storing settings and user data only.
bios.sysmem = gdt.FlashMemory0

-- changeProcess: Switch the current running program over.
function changeProcess(newProc)
	process = newProc 
	process.init()
end

function boot()
	-- Display check.
	print("MAIN DISP: ", gfx.Width, "x", gfx.Height)

	-- Load boot screen.
	gfx:Clear(Color(168,132,243))
	local boot_scrn	= gdt.ROM.User.SpriteSheets["boot_scrn"]
	gfx:DrawSprite(vec2(20,18),boot_scrn, 0, 0, color.white, color.clear)

	-- Check system preferences.
	bios.PREF = bios.sysmem:Load()
	print("lastVer: "..tostring(bios.PREF.lastVer))

	if bios.PREF.lastVer == nil then
		logWarning("No Preference data, begin OOBE.")
		bios.PREF = {
			lastVer = 1,
			music = false,
			wipeAllData = false
		}
		if bios.sysmem:Save(bios.PREF) then
			print("OwO!")
		else
			print("oopsy")
		end
	end

	-- WebCam violation
	NoCam_Indicator = false

	-- Is Camera allowed?
	bios.AllowCam = false
	CAM = gdt.Webcam
	if bios.InManual then
		-- INHOME MODE
		bios.InHome = false
	else
		bios.InHome = true
	end

	-- BIOS FONT
	TXTCol 	= Color(0,0,0)
	TXTBg 	= Color(255,255,255)
	LineCol = Color(46,34,47)
	LineShadow = Color(98,85,101)
	
	-- Connect Components
	msx = gdt.AudioChip0
	rom = gdt.ROM
	CPU = gdt.CPU0
	RC = gdt.RealityChip0
	bios.but_O = gdt.LedButton0
	bios.but_X = gdt.LedButton1
	
	-- AUDIO SAMPLES
	snd_select 	= rom.User.AudioSamples["select.wav"]
	snd_denied 	= rom.User.AudioSamples["denied.wav"]
	--snd_music		= rom.User.AudioSamples["theme_loop.mp3"]
	snd_shutter	= rom.User.AudioSamples["shutter.mp3"]
	--if bios.PREF.music then
		--msx:PlayLoop(snd_music, 1)
	--end
	
	-- For No Camera Permitted Indicator
	HSPR = rom.User.SpriteSheets["HOME_SPR"]
	ICON = rom.User.SpriteSheets["SYMBOL_SET"]


	-- INIT APPS
	local test = require("memtest.lua")
	process = qrt.memtest
end

--[[

	Once the BIOS handles, begin passing control over to the quart.

]]--

function update()
	process.render()

	-- Show sprite if No Camera is permitted
	if NoCam_Indicator then
		gfx:DrawSprite(vec2(108, 12), HSPR,4,1,color.white, color.clear)
	end
end

--[[

	Event Channel Assignments

]]--

-- DPad.
function eventChannel1(sender:DPad, arg)
	process.eventChannel1(arg)
end

-- O button.
function eventChannel2(sender:LedButtonEvent, arg)
	process.eventChannel2(arg)
end

-- X button.
function eventChannel3(sender:LedButtonEvent, arg)
	process.eventChannel3(arg)
end

-- C (capture) button.
function eventChannel4(sender:LedButtonEvent, arg)
	-- Check if the process is permitting the camera button.
	if arg["ButtonDown"] and not bios.AllowCam then
		NoCam_Indicator = true
		msx:Play(snd_denied, 2)
	else 
		NoCam_Indicator = false
	end
	process.eventChannel4(arg)
end

-- Wifi channel.
function eventChannel64(sender, response)
	log(response.Text)
end

boot()