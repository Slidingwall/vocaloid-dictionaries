--
-- Manifest
--
function manifest()
	myManifest = {
		name          = "心华发音调整",
		comment       = "调整心华发音",
		author        = "Slidingwall",
		pluginID      = "{XINHUA00-0210-0210-0210-SLIDINGWALL}",
		pluginVersion = "1.0.0.1",
		apiVersion    = "3.0.0.1"
	}

	return myManifest
end

--
-- Main
--
function main(processParam, envParam)
	-- Process parameters
	local beginPosTick      = processParam.beginPosTick -- begin of time range to apply Job to (in ticks)
	local endPosTick        = processParam.endPosTick -- end of time range to apply Job to (in ticks)
	local songPosTick       = processParam.songPosTick -- onset of song (in ticks)

	-- Environment parameters
	local scriptDir         = envParam.scriptDir -- script folder
	local scriptName        = envParam.scriptName -- script name
	local tempDir           = envParam.tempDir -- temporary folder

	local mapping           = {}
	local mapping2          = {} -- exceptions to general rules using two phoneme input string
	local noteEx            = {}
	local noteExList        = {}
	local noteCount
	local retCode
	local idx

	mapping["uAN"]          = "uAN @N"
	mapping2["t uAN"]       = { "t", "uAN @N" }
	mapping2["t_h uAN"]     = { "t_h", "uAN @N" }
	mapping2["k AN"]        = { "k", "AN @N" }
	mapping2["k_h AN"]      = { "k_h", "AN @N" }
	mapping2["k uAN"]       = { "k", "uAN @N" }
	mapping2["k_h uAN"]     = { "k_h", "uAN @N" }

	mapping2["l iAN"]       = { "l", "ia @N n ?" }
	mapping2["s\\ iAN"]     = { "s\\ ", "ia @N n ?" }
	mapping2["ts\\ iAN"]    = { "ts\\ ", "ia @N n ?" }
	mapping2["ts\\_h iAN"]  = { "ts\\_h", "ia @N n ?" }
	mapping2["l iAN"]       = { "l", "ia @N n ?" }
	mapping["iAN"]          = "ia @N n ?"

	mapping["ua_n"]         = "u a_n"
	mapping2["n ua_n"]      = { "n", "u a_n" }
	mapping2["l ua_n"]      = { "l", "u a_n" }
	mapping2["s ua_n"]      = { "s", "u a_n" }
	mapping2["ts ua_n"]     = { "ts", "u a_n" }
	mapping2["ts\\_h ua_n"] = { "ts\\_h", "u a_n" }
	mapping2["ts`_h ua_n"]  = { "ts`_h", "u a_n" }
	mapping2["t ua_n"]      = { "t", "u a_n" }
	mapping2["t_h ua_n"]    = { "t_h", "u a_n" }
	mapping2["k ua_n"]      = { "k", "u a_n" }
	mapping2["k_h ua_n"]    = { "k_h", "u a_n" }

	mapping["iN"]           = "iN @N"
	mapping["u@_n"]         = "u @_n"
	mapping["uo"]           = "u o"
	mapping["iUN"]          = "i@U UN"
	mapping2["p @N"]        = { "p", "7 @N" }
	mapping2["ts_h @N"]     = { "ts_h", "7 @N" }
	mapping2["ts`_h @N"]    = { "ts`_h", "7 @N" }
	mapping2["t @N"]        = { "t", "7 @N" }
	mapping2["k @N"]        = { "k", "7 @N" }
	mapping2["x @N"]        = { "x", "7 @N" }
	mapping2["k_h @N"]      = { "k_h", "7 @N" }
	mapping2["l @N"]        = { "l", "7 @N" }
	mapping2["m @N"]        = { "m", "7 @N" }
	mapping2["n @N"]        = { "n", "7 @N" }
	mapping2["p_h @N"]      = { "p_h", "7 @N" }
	mapping2["z` @N"]       = { "z`", "7 @N" }
	mapping2["s @N"]        = { "s", "7 @N" }
	mapping2["s` @N"]       = { "s`", "7 @N" }
	mapping2["t_h @N"]      = { "t_h", "7 @N" }
	mapping2["ts @N"]       = { "ts", "7 @N" }
	mapping2["ts` @N"]      = { "ts`", "7 @N" }

	-- 主程序开始
	-- get list of notes
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
		VSMessageBox("Error: No notes are found.", 0)
		return 0
	end


	-- transform notes
	for idx = 1, noteCount do
		local updNoteEx = {}
		updNoteEx = noteExList[idx]

		if ((beginPosTick <= updNoteEx.posTick) and (updNoteEx.posTick + updNoteEx.durTick <= endPosTick)) then
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
						--if (phns[i+1] == "iAN") then
						--	local orgPosTick = updNoteEx.posTick
						--	local orgDurTick = updNoteEx.durTick
						--	local noteDur = orgDurTick-orgPosTick
						--	if noteDur<100 then break end
						--end
						phns[i] = mapping2[twophn][1]
						phns[i + 1] = mapping2[twophn][2]
						-- (in this case no need to increment i because mapping2[twophn][2] is always "i", so will map to "i" on next iteration)
						mapped = true -- there's no continue in lua
						updNoteEx.phLock = 1
					end
				end

				-- general mapping second
				if not mapped then
					if mapping[phns[i]] then
						phns[i] = mapping[phns[i]]
						updNoteEx.phLock = 1
					end
				end
			end

			-- join by space
			updNoteEx.phonemes = table.concat(phns, " ");
		end
		-- update note
		retCode = VSUpdateNoteEx(updNoteEx);
		if (retCode ~= 1) then
			VSMessageBox("发生错误，无法运行。", 0)
			return 1
		end
	end

	-- Success
	return 0
end
