-- Kor2Chn.lua
-- Mapping of Korean VSQ(X)'s to Chinese phonetics.

function manifest()
    myManifest = {
        name          = "Korean to Chinese",
        comment       = "Convert Korean VSQX for Chinese voice banks",
        author        = "Slidingwall",
        pluginID      = "{A114514-1919-810A-A12F-92E54EE5D41T}",
        pluginVersion = "For Chinese Libraries",
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
	
	mapping["a"]	= "a"
	mapping["ja"]	= "ia"
	mapping["7"]	= "AU"
	mapping["j7"]	= "iAU"
	mapping["e"]	= "ei"
	mapping["je"]	= "i ei"
	mapping["o"]	= "o"
	mapping["oa"]	= "ua"
	mapping["jo"]	= "i@U"
	mapping["u"]	= "u"
	mapping["ju"]	= "y"
	mapping["u7"]	= "uo"
	mapping["ue"]	= "uei"
	mapping["ui"]	= "u i"
	mapping["M"]	= "u"
	mapping["Mi"]	= "u i"
	mapping["i"]	= "i"

	mapping["h"]	= "x"
		mapping2["h i"] = {"x", "7 i i i"}
		mapping2["h ja"] = {"x", "7 ia a"}
		mapping2["h j7"] = {"x", "7 ia AU"}
		mapping2["h je"] = {"x", "7 iE_r ei"}
		mapping2["h jo"] = {"x", "7 i@U"}
		mapping2["h ju"] = {"x", "7 y"}
	mapping["g"]	= "k"
		mapping2["g i"] = {"k", "7 i i i"}
		mapping2["g ja"] = {"k", "7 ia a"}
		mapping2["g j7"] = {"k", "7 ia AU"}
		mapping2["g je"] = {"k", "7 iE_r ei"}
		mapping2["g jo"] = {"k", "7 i@U"}
		mapping2["g ju"] = {"k", "7 y"}
	mapping["g'"]	= "k"
		mapping2["g' i"] = {"k", "7 i i i"}
		mapping2["g' ja"] = {"k", "7 ia a"}
		mapping2["g' j7"] = {"k", "7 ia AU"}
		mapping2["g' je"] = {"k", "7 iE_r ei"}
		mapping2["g' jo"] = {"k", "7 i@U"}
		mapping2["g' ju"] = {"k", "7 y"}
	mapping["k"]	= "k"
		mapping2["k i"] = {"k", "7 i i i"}
		mapping2["k ja"] = {"k", "7 ia a"}
		mapping2["k j7"] = {"k", "7 ia AU"}
		mapping2["k je"] = {"k", "7 iE_r ei"}
		mapping2["k jo"] = {"k", "7 i@U"}
		mapping2["k ju"] = {"k", "7 y"}
	mapping["n"]	= "n"
	mapping["D"]    = "n"
	mapping["d"]	= "t"
	mapping["d'"]	= "t"
	mapping["t"]	= "t_h"
	mapping["r"]	= "z`"
		mapping2["r i"] = {"z`", "i` i i i"}
		mapping2["r ja"] = {"l", "ia"}
		mapping2["r j7"] = {"l", "iAU"}
		mapping2["r je"] = {"l", "i ei"}
		mapping2["r jo"] = {"l", "i@U"}
		mapping2["r ju"] = {"l", "y"}
	mapping["l"]	= "l"
	mapping["m"]	= "m"
	mapping["b"]	= "p"
	mapping["b'"]	= "p"
	mapping["p"]	= "p"
	mapping["s"]	= "ts_h"
	mapping["sh"]	= "ts\\_h"
	mapping["s'"]	= "ts"
	mapping["sh'"]	= "ts\\"
	mapping["c"]	= "ts"
	mapping["c'"]	= "ts"
	mapping["ch"]	= "ts`_h"

	mapping["gp"]	= "k ?"
	mapping["dp"]	= "t ?"
	mapping["rp"]	= "l ?"
	mapping["bp"]	= "p ?"
		mapping2["a np"] = {"", "a_n"}
		mapping2["ja np"] = {"ia", "a_n"}
		mapping2["7 np"] = {"", "AN"}
		mapping2["j7 np"] = {"", "iAN"}
		mapping2["e np"] = {"", "@_n"}
		mapping2["je np"] = {"", "iE_n"}
		mapping2["o np"] = {"", "UN"}
		mapping2["oa np"] = {"", "ua_n"}
		mapping2["jo np"] = {"", "iUN"}
		mapping2["u np"] = {"", "UN"}
		mapping2["ju np"] = {"", "y{_n"}
		mapping2["u7 np"] = {"", "uAN"}
		mapping2["ue np"] = {"", "u@_n"}
		mapping2["ui np"] = {"u", "i_n"}
		mapping2["M np"] = {"", "u@_n"}
		mapping2["Mi np"] = {"u", "i_n"}
		mapping2["i np"] = {"", "i_n"}
		mapping2["a mp"] = {"", "a_n"}
		mapping2["ja mp"] = {"ia", "a_n"}
		mapping2["7 mp"] = {"", "AN"}
		mapping2["j7 mp"] = {"", "iAN"}
		mapping2["e mp"] = {"", "@_n"}
		mapping2["je mp"] = {"", "iE_n"}
		mapping2["o mp"] = {"", "UN"}
		mapping2["oa mp"] = {"", "ua_n"}
		mapping2["jo mp"] = {"", "iUN"}
		mapping2["u mp"] = {"", "UN"}
		mapping2["ju mp"] = {"", "y{_n"}
		mapping2["u7 mp"] = {"", "uAN"}
		mapping2["ue mp"] = {"", "u@_n"}
		mapping2["ui mp"] = {"u", "i_n"}
		mapping2["M mp"] = {"", "u@_n"}
		mapping2["Mi mp"] = {"u", "i_n"}
		mapping2["i mp"] = {"", "i_n"}
		mapping2["a Np"] = {"", "AN"}
		mapping2["ja Np"] = {"", "iAN"}
		mapping2["7 Np"] = {"", "AN"}
		mapping2["j7 Np"] = {"", "iAN"}
		mapping2["e Np"] = {"", "@N"}
		mapping2["je Np"] = {"", "iE_n"}
		mapping2["o Np"] = {"", "UN"}
		mapping2["oa Np"] = {"", "uAN"}
		mapping2["jo Np"] = {"", "iUN"}
		mapping2["u Np"] = {"", "UN"}
		mapping2["ju Np"] = {"y{_n", "@N"}
		mapping2["u7 Np"] = {"", "uAN"}
		mapping2["ue Np"] = {"", "u@_n"}
		mapping2["ui Np"] = {"u", "iN"}
		mapping2["M Np"] = {"", "UN"}
		mapping2["Mi Np"] = {"u", "iN"}
		mapping2["i Np"] = {"", "iN"}

	mapping["@r"]	= "@`"
	mapping["C"]	= "ts"
	mapping["z"]	= "ts"
	mapping["v"]	= "u"

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