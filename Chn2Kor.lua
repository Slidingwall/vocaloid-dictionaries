-- Chn2Kor.lua
-- Mapping of Chinese VSQ(X)'s to Korean phonetics.

function manifest()
    myManifest = {
        name          = "Chn2Kor",
        comment       = "Convert Chinese VSQX for Korean voice banks",
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
	
	mapping["y"]	="ju"
	mapping["@`"]	="a rp"
	mapping["i\"]	="i"
	mapping["i`"]	="u"
	mapping["aI"]	="a e i"
	mapping["ei"]	="e i"
	mapping["AU"]	="a u"
	mapping["@U"]	="o u"
	mapping["ia"]	="ja"
	mapping["iE_r"]	="je"
	mapping["ua"]	="oa"
	mapping["uo"]	="u o"
	mapping["yE_r"]	="ju e"
	mapping["iAU"]	="ja u"
	mapping["i@U"]	="jo u"
	mapping["uaI"]	="oa e i"
	mapping["uei"]	="ue i"
	mapping["a_n"]	="a np"
	mapping["@_n"]	="e np"
	mapping["i_n"]	="I np"
	mapping["iE_n"]	="je np"
	mapping["ua_n"]	="ua np"
	mapping["u@_n"]	="ue np"
	mapping["y_n"]	="ju np"
	mapping["y{_n"]	="ju a np"
	mapping["AN"]	="a Np"
	mapping["@N"]	="e Np"
	mapping["iN"]	="I Np"
	mapping["iAN"]	="ja Np"
	mapping["uAN"]	="ua Np"
	mapping["u@N"]	="ue Np"
	mapping["UN"]	="M Np"
	mapping["iUN"]	="ju Np"
	mapping["p"]	="b"
	mapping["p_h"]	="p"
	mapping["t"]	="d"
	mapping["t_h"]	="t"
	mapping["k"]	="g"
	mapping["k_h"]	="k"
	mapping["x"]	="h"
	mapping["ts\"]	="c"
	mapping["ts\_h"]	="ch"
	mapping["s\"]	="sh j"
	mapping["ts`"]	="c'"
	mapping["ts`_h"]	="ch"
	mapping["s`"]	="sh' j"
	mapping["z`"]	="c'"
	mapping["ts"]	="c'"
	mapping["ts_h"]	="s"
	mapping["s"]	="s'"

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