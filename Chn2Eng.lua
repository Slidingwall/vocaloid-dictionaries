-- Chn2Eng.lua
-- Mapping of Chinese VSQ(X)'s to English phonetics.

function manifest()
    myManifest = {
        name          = "Chn2Eng",
        comment       = "Convert Chinese VSQX for English voice banks",
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
	
	mapping["a"]	= "{"
	mapping["o"]	= "O:"
	mapping["7"]	= "V"
	mapping["i"]	= "i:"
	mapping["u"]	= "u:"
	mapping["y"]	= "j u:"
	mapping["@`"]	= "@r"
	mapping["i\"]	= "I"
	mapping["i`"]	= "u:"
	mapping["aI"]	= "aI"
	mapping["ei"]	= "eI"
	mapping["AU"]	= "aU"
	mapping["@U"]	= "@U"
	mapping["ia"]	= "j {"
	mapping["iE_r"]	= "j e"
	mapping["ua"]	= "w {"
	mapping["uo"]	= "w O:"
	mapping["yE_r"]	= "j u: e"
	mapping["iAU"]	= "j aU"
	mapping["i@U"]	= "j @U"
	mapping["uaI"]	= "w aI"
	mapping["uei"]	= "w eI"
	mapping["a_n"]	= "{ n"
	mapping["@_n"]	= "@ n"
	mapping["i_n"]	= "i: n"
	mapping["iE_n"]	= "i: e n"
	mapping["ua_n"]	= "w { n"
	mapping["u@_n"]	= "w @ n"
	mapping["y_n"]	= "j u: n"
	mapping["y{_n"]	= "j u: { n"
	mapping["AN"]	= "{ N"
	mapping["@N"]	= "@ N"
	mapping["iN"]	= "i: N"
	mapping["iAN"]	= "j { N"
	mapping["uAN"]	= "w { N"
	mapping["u@N"]	= "w @ N"
	mapping["UN"]	= "U N"
	mapping["iUN"]	= "j U N"
	mapping["p_h"]	= "ph"
	mapping["t_h"]	= "th"
	mapping["k_h"]	= "kh"
	mapping["x"]	= "h"
	mapping["ts\"]	= "dZ"
	mapping["ts\_h"]	= "tS"
	mapping["s\"]	= "S"
	mapping["ts`"]	= "dZ"
	mapping["ts`_h"]	= "tS"
	mapping["s`"]	= "S"
	mapping["z`"]	= "Z"
	mapping["ts"]	= "z"
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