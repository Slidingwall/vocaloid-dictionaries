-- Chn2Esp.lua
-- Mapping of Chinese VSQ(X)'s to Spanish phonetics.

function manifest()
	myManifest = {
		name          = "CHN->ESP",
		comment       = "Convert Chinese VSQX for Spanish libraries.",
		author        = "Slidingwall",
		pluginID      = "{CHINESE0-SILD-INGW-ALL0-00000SPANISH}",
		pluginVersion = "For Bruno&Clara",
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

	local mapping     = {}
	local mapping2    = {}
	local noteEx      = {}
	local noteExList  = {}
	local noteCount
	local retCode
	local idx

	mapping["7"]      = "o"
	mapping["i"]      = "i"
	mapping["u"]      = "u"
	mapping["y"]      = "j u"
	mapping["@`"]     = "a l"
	mapping["i\\"]    = "i"
	mapping["i`"]     = "u"
	mapping["aI"]     = "a I"
	mapping["ei"]     = "e I"
	mapping["AU"]     = "a U"
	mapping["@U"]     = "o U"
	mapping["ia"]     = "j a"
	mapping["iE_r"]   = "j e"
	mapping["ua"]     = "w a"
	mapping["uo"]     = "w o"
	mapping["yE_r"]   = "j u e"
	mapping["iAU"]    = "j a U"
	mapping["i@U"]    = "j o U"
	mapping["uaI"]    = "w a I"
	mapping["uei"]    = "w e I"
	mapping["a_n"]    = "a n"
	mapping["@_n"]    = "e n"
	mapping["i_n"]    = "i n"
	mapping["iE_n"]   = "j e n"
	mapping["ua_n"]   = "w a n"
	mapping["u@_n"]   = "w e n"
	mapping["y_n"]    = "j u n"
	mapping["y{_n"]   = "j u e n"
	mapping["AN"]     = "a n"
	mapping["@N"]     = "o n"
	mapping["iN"]     = "i n"
	mapping["iAN"]    = "j a n"
	mapping["uAN"]    = "w a n"
	mapping["u@N"]    = "w o n"
	mapping["UN"]     = "o U n"
	mapping["iUN"]    = "j o U n"
	mapping["p_h"]    = "p"
	mapping["t_h"]    = "t"
	mapping["n"]      = "n"
	mapping["k"]      = "g"
	mapping["k_h"]    = "k"
	mapping["ts\\"]   = "t s"
	mapping["ts\\_h"] = "tS"
	mapping["s\\"]    = "s"
	mapping["ts`"]    = "tS"
	mapping["ts`_h"]  = "tS"
	mapping["s`"]     = "s"
	mapping["z`"]     = "r"
	mapping["ts"]     = "t s"
	mapping["ts_h"]   = "t s"

	mapping["Sil"]    = "Sil"

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
			if i + 1 <= table.getn(phns) then
				twophn = phns[i] .. " " .. phns[i + 1]
				if mapping2[twophn] then
					phns[i] = mapping2[twophn][1]
					phns[i + 1] = mapping2[twophn][2]
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
