-- Chn2Maika.lua
-- Mapping of Chinese VSQ(X)'s to extended Spanish phonetics to be used with Maika voice bank.

function manifest()
    myManifest = {
        name          = "Chn2Maika",
        comment       = "Convert Chinese VSQX for use with MAIKA voice bank",
        author        = "Slidingwall",
        pluginID      = "{A03FEF7A-4524-4446-A12F-92E54EE5D41T}",
        pluginVersion = "1.0.0.0",
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
	
	mapping["7"]	= "@"
	mapping["y"]	= "j u"
	mapping["@`"]	= "@ r\"
	mapping["i\"]	= "I0"
	mapping["i`"]	= "u"
	mapping["aI"]	= "a I"
	mapping["ei"]	= "e I"
	mapping["AU"]	= "a U"
	mapping["@U"]	= "o U"
	mapping["ia"]	= "j a"
	mapping["iE_r"]	= "j E"
	mapping["ua"]	= "w a"
	mapping["uo"]	= "w o"
	mapping["yE_r"]	= "j u E"
	mapping["iAU"]	= "j a U"
	mapping["i@U"]	= "j o U"
	mapping["uaI"]	= "w a I"
	mapping["uei"]	= "w e I"
	mapping["a_n"]	= "a n"
	mapping["@_n"]	= "@ n"
	mapping["i_n"]	= "i n"
	mapping["iE_n"]	= "j E n"
	mapping["ua_n"]	= "w a n"
	mapping["u@_n"]	= "w @ n"
	mapping["y_n"]	= "j u n"
	mapping["y{_n"]	= "j u E n"
	mapping["AN"]	= "a N"
	mapping["@N"]	= "@ N"
	mapping["iN"]	= "I N"
	mapping["iAN"]	= "j a N"
	mapping["uAN"]	= "w a N"
	mapping["u@N"]	= "w @ N"
	mapping["UN"]	= "U N"
	mapping["iUN"]	= "j U N"
	mapping["p_h"]	= "p h"
	mapping["m"]	= "m"
	mapping["t_h"]	= "T"
	mapping["k"]	= "g"
	mapping["k_h"]	= "k"
	mapping["ts\"]	= "dZ"
	mapping["ts\_h"]	= "tS"
	mapping["s\"]	= "S"
	mapping["ts`"]	= "dZ"
	mapping["ts`_h"]	= "tS"
	mapping["s`"]	= "S"
	mapping["z`"]	= "Z"
	mapping["ts_h"]	= "t s"

	mapping["Sil"]	= "Sil"

	VSSeekToBeginNote()
	idx = 1
	retCode, noteEx = VSGetNextNoteEx()
	while (retCode == 1) do
		noteExList[idx] = noteEx
		retCode, noteEx = VSGetNextNoteEx()
		idx = idx + 1
	end

	noteCount = table.getn(noteExList)
	if (noteCount == 0) then
		VSMessageBox("No notes to process!", 0)
		return 0
	end
	
	for idx = 1, noteCount do
		local updNoteEx = {}
		updNoteEx = noteExList[idx]
		
		local phns = {}
		for token in string.gmatch(updNoteEx.phonemes, "[^%s]+") do
			 table.insert(phns, token)
		end
		
		for i = 1, table.getn(phns) do
			local mapped = false
			if i+1 <= table.getn(phns) then
				twophn = phns[i] .. " " .. phns[i+1]
				if mapping2[twophn] then
					phns[i] = mapping2[twophn][1]
					phns[i+1] = mapping2[twophn][2]

					mapped = true -- there's no continue in lua
				end
			end
			
			if not mapped then
				if mapping[phns[i]] then
					phns[i] = mapping[phns[i]]
				end
			end
		end
		
		updNoteEx.phonemes = table.concat(phns, " ");
		
		retCode = VSUpdateNoteEx(updNoteEx);
		if (retCode ~= 1) then
			VSMessageBox("Failed to update note!", 0)
			return 1
		end
	end

	return 0
end