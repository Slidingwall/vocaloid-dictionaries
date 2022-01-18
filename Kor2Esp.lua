--
-- Kor2Esp.lua
-- Mapping of Korean VSQ(X)'s to Spanish phonetics to be used with Spanish voice bank.
--
function manifest()
    myManifest = {
        name          = "Korean to Spanish",
        comment       = "Convert Korean VSQX for Spanish voice bank",
        author        = "Slidingwall",
        pluginID      = "{1385A759-3A16-46df-8078-1145143829CE}",
        pluginVersion = "For Bruno&Clara",
        apiVersion    = "3.0.1.0"
    }
    
    return myManifest
end


--
-- Main
--
function main(processParam, envParam)
	-- -- Process parameters
	-- local beginPosTick = processParam.beginPosTick	-- begin of time range to apply Job to (in ticks)
	-- local endPosTick   = processParam.endPosTick		-- end of time range to apply Job to (in ticks)
	-- local songPosTick  = processParam.songPosTick	-- onset of song (in ticks)

	-- -- Environment parameters
	-- local scriptDir  = envParam.scriptDir	-- script folder
	-- local scriptName = envParam.scriptName	-- script name
	-- local tempDir    = envParam.tempDir		-- temporary folder
	
	local mapping    = {}
	local mapping2   = {} -- exceptions to general rules using two phoneme input string
	local noteEx     = {}
	local noteExList = {}
	local noteCount
	local retCode
	local idx
	
	-- define japanese-to-korean phoneme mapping
	mapping["ja"]	= "j a"
	mapping["7"]	= "a o"
	mapping["j7"]	= "j a o"
	mapping["jo"]	= "j o"
	mapping["ju"]	= "j u"
	mapping["M"]	= "U"
	mapping["je"]	= "j e"
	mapping["oa"]	= "w a"
	mapping["u7"]	= "w o"
	mapping["ue"]	= "w e"
	mapping["ui"]	= "u i"
	mapping["Mi"]	= "U i"

	mapping["h"]	= "x"
	mapping["g'"]	= "g"
	mapping["d'"]	= "d"
	mapping["b'"]	= "b"
	mapping["p"]	= "p"
	mapping["sh"]	= "s"
	mapping["s'"]	= "s"
	mapping["sh'"]	= "tS"
	mapping["c"]	= "t s"
	mapping["c'"]	= "t s"
	mapping["ch"]	= "tS"

	mapping["gp"]	= "g"
	mapping["dp"]	= "d"
	mapping["rp"]	= "l"
	mapping["bp"]	= "b"
	mapping["np"]	= "n"
	mapping["mp"]	= "m"
	mapping["Np"]	= "n"
	mapping["N"]	= "n"

	mapping["@r"]	= "a l"
	mapping["C"]	= "s"
	mapping["z"]	= "t s"
	mapping["v"]	= "w"

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
