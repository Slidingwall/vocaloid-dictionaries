-- Kor2Eng.lua
-- Mapping of Korean VSQ(X)'s to English phonetics.

function manifest()
    myManifest = {
        name          = "Korean to English",
        comment       = "Convert Korean VSQX for English voice banks",
        author        = "Slidingwall",
        pluginID      = "{A114514-1919-810B-A123-92E54EE5D41T}",
        pluginVersion = "For English Libraries",
        apiVersion    = "3.0.1.0"
    }
    
    return myManifest
end

function main(processParam, envParam)

	-- local beginPosTick = processParam.beginPosTick
	-- local endPosTick   = processParam.endPosTick
	-- local songPosTick  = processParam.songPosTick

	-- local scriptDir  = envParam.scriptDir
	-- local scriptName = envParam.scriptName
	-- local tempDir    = envParam.tempDir
	
	local mapping    = {}
	local mapping2   = {}
	local noteEx     = {}
	local noteExList = {}
	local noteCount
	local retCode
	local idx
	
	mapping["a"]	= "{"
	mapping["ja"]	= "j {"
	mapping["7"]	= "V"
	mapping["j7"]	= "j V"
	mapping["e"]	= "e"
	mapping["je"]	= "j e"
	mapping["o"]	= "O:"
	mapping["oa"]	= "w {"
	mapping["jo"]	= "j O:"
	mapping["u"]	= "u:"
	mapping["ju"]	= "j u:"
	mapping["u7"]	= "w V"
	mapping["ue"]	= "w e"
	mapping["ui"]	= "u: i:"
	mapping["M"]	= "U"
	mapping["Mi"]	= "U i:"
	mapping["i"]	= "i:"

	mapping["h"]	= "h"
	mapping["g"]	= "gh"
	mapping["g'"]	= "g"
	mapping["k"]	= "kh"
	mapping["n"]	= "n"
	mapping["D"]    = "n"
		mapping2["D e"] = {"D", "e"}
	mapping["d"]	= "dh"
	mapping["d'"]	= "d"
	mapping["t"]	= "th"
	mapping["r"]	= "r"
	mapping["l"]	= "l0"
	mapping["m"]	= "m"
	mapping["b"]	= "bh"
	mapping["b'"]	= "b"
	mapping["p"]	= "ph"
	mapping["s"]	= "s"
	mapping["sh"]	= "S"
	mapping["s'"]	= "s"
	mapping["sh'"]	= "S"
	mapping["c"]	= "t s"
	mapping["c'"]	= "t s"
	mapping["ch"]	= "tS"

	mapping["gp"]	= "g"
	mapping["dp"]	= "d"
	mapping["rp"]	= "l"
	mapping["bp"]	= "b"
	mapping["np"]	= "n"
	mapping["mp"]	= "m"
	mapping["Np"]	= "N"


	mapping["@r"]	= "@r"
	mapping["C"]	= "S"
	mapping["z"]	= "z"
	mapping["v"]	= "v"

	mapping["Sil"]	= "Sil"

	-- get list of notes
	VSSeekToBeginNote()
	idx = 1
	retCode, noteEx = VSGetNextNoteEx()
	while (retCode == 1) do
		noteExList[idx] = noteEx
		retCode, noteEx = VSGetNextNoteEx()
		idx = idx + 1
	end

	-- check if empty
	noteCount = table.getn(noteExList)
	if (noteCount == 0) then
		VSMessageBox("No notes to process!", 0)
		return 0
	end
	
	-- check Job Plugin can lock phoneme
	local bPhLock = canPhLock(noteExList[1])
	
	-- transform notes
	for idx = 1, noteCount do
		local updNoteEx = {}
		updNoteEx = noteExList[idx]
		
		-- split on whitespace
		local phns = {}
		for token in string.gmatch(updNoteEx.phonemes, "[^%s]+") do
			 table.insert(phns, token)
		end
		
		-- do phoneme-by-phoneme mapping
		for i = 1, table.getn(phns) do
			-- try exceptions first
			local mapped = false
			if i+1 <= table.getn(phns) then
				twophn = phns[i] .. " " .. phns[i+1]
				if mapping2[twophn] then
					phns[i] = mapping2[twophn][1]
					phns[i+1] = mapping2[twophn][2]
					-- (in this case no need to increment i because mapping2[twophn][2] is always "i", so will map to "i" on next iteration)
					mapped = true -- there's no continue in lua
				end
			end
			
			-- general mapping second
			if not mapped then
				if mapping[phns[i]] then
					phns[i] = mapping[phns[i]]
				end
			end
		end
		
		-- join by space
		updNoteEx.phonemes = table.concat(phns, " ");
		
		-- Do phoneme lock
		if (bPhLock) then
			updNoteEx.phLock = 1
		end		
		
		-- update note
		retCode = VSUpdateNoteEx(updNoteEx);
		if (retCode ~= 1) then
			VSMessageBox("Failed to update note!", 0)
			return 1
		end
	end

	-- Success
	return 0
end

-- Check if note has phLock property (only in newer API, Editor 3.0.5+)
function canPhLock(note)
	local status = false

	for key, val in pairs(note) do
		if (key == "phLock") then
			status = true
			break
		end
	end
	
	return status
end
