-- Chn2Eng.lua
-- Mapping of Chinese VSQ(X)'s to English phonetics.

function manifest()
	myManifest = {
		name          = "CHN->ENG",
		comment       = "Convert Chinese VSQX for English Libraries",
		author        = "Slidingwall",
		pluginID      = "{CHINESE0-SILD-INGW-ALL0-00000ENGLISH}",
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

	local mapping     = {}
	local mapping2    = {}
	local noteEx      = {}
	local noteExList  = {}
	local noteCount
	local retCode
	local idx

	mapping["a"]      = "{"
	mapping["o"]      = "O:"
	mapping["7"]      = "V"
	mapping["i"]      = "i:"
	mapping["u"]      = "u:"
	mapping["y"]      = "j u:"
	mapping["@`"]     = "@r"
	mapping["i\\"]    = "I"
	mapping["i`"]     = "u:"
	mapping["aI"]     = "aI"
	mapping["ei"]     = "eI"
	mapping["AU"]     = "aU"
	mapping["@U"]     = "@U"
	mapping["ia"]     = "j {"
	mapping["iE_r"]   = "j e"
	mapping["ua"]     = "w {"
	mapping["uo"]     = "w O:"
	mapping["yE_r"]   = "j u: e"
	mapping["iAU"]    = "j aU"
	mapping["i@U"]    = "j @U"
	mapping["uaI"]    = "w aI"
	mapping["uei"]    = "w eI"
	mapping["a_n"]    = "{ n"
	mapping["@_n"]    = "@ n"
	mapping["i_n"]    = "i: n"
	mapping["iE_n"]   = "i: e n"
	mapping["ua_n"]   = "w { n"
	mapping["u@_n"]   = "w @ n"
	mapping["y_n"]    = "j u: n"
	mapping["y{_n"]   = "j u: { n"
	mapping["AN"]     = "Q N"
	mapping["@N"]     = "@ N"
	mapping["iN"]     = "i: N"
	mapping["iAN"]    = "j Q N"
	mapping["uAN"]    = "w Q N"
	mapping["u@N"]    = "w @ N"
	mapping["UN"]     = "U N"
	mapping["iUN"]    = "j U N"
	mapping["p_h"]    = "ph"
	mapping["t_h"]    = "th"
	mapping["k_h"]    = "kh"
	mapping["x"]      = "h"
	mapping["ts\\"]   = "dZ"
	mapping["ts\\_h"] = "tS"
	mapping["s\\"]    = "S"
	mapping["ts`"]    = "dZ"
	mapping["ts`_h"]  = "tS"
	mapping["s`"]     = "S"
	mapping["z`"]     = "Z"
	mapping["ts"]     = "z"
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
