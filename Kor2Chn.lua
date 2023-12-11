-- Kor2Chn.lua
-- Mapping of Korean VSQ(X)'s to Chinese phonetics.

function manifest()
	myManifest = {
		name          = "KOR->CHN",
		comment       = "Convert Korean VSQX for Chinese Libraries.",
		author        = "Slidingwall",
		pluginID      = "{KOREAN00-SILD-INGW-ALL0-00000CHINESE}",
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

	local mapping         = {}
	local mapping2        = {}
	local mapping2a       = {}
	local mapping3        = {}
	local noteEx          = {}
	local noteExList      = {}
	local noteCount
	local retCode
	local idx

	mapping3["t ja Np"]   = "t_h ia AN"
	mapping3["t j7 Np"]   = "t_h ia AN"
	mapping3["t j7 np"]   = "t_h ia AN"
	mapping3["t j7 mp"]   = "t_h ia AN m"
	mapping3["t i np"]    = "t_h 7_0 i_n"
	mapping3["t i mp"]    = "t_h 7_0 i_n m"
	mapping3["sh' ui Np"] = "s\\ y_n"
	mapping3["sh' ui np"] = "s\\ y_n"
	mapping3["sh ui Np"]  = "s\\ y_n"
	mapping3["sh ui np"]  = "s\\ y_n"
	mapping3["sh' ui mp"] = "s\\ y_n m"
	mapping3["sh ui mp"]  = "s\\ y_n m"
	mapping3["sh' ju Np"] = "s\\ iUN"
	mapping3["sh' ju np"] = "s\\ iUN"
	mapping3["sh' ju np"] = "s\\ iUN m"
	mapping3["sh ju Np"]  = "s\\ iUN"
	mapping3["sh ju np"]  = "s\\ iUN"
	mapping3["sh ju np"]  = "s\\ iUN m"
	mapping3["sh' jo Np"] = "s\\ iUN"
	mapping3["sh' jo np"] = "s\\ iUN"
	mapping3["sh' jo np"] = "s\\ iUN m"
	mapping3["sh jo Np"]  = "s\\ iUN"
	mapping3["sh jo np"]  = "s\\ iUN"
	mapping3["sh jo np"]  = "s\\ iUN m"
	mapping3["p ue np"]   = "p_h u @_n"
	mapping3["p ue mp"]   = "p_h u @_n m"
	mapping3["p u Np"]    = "p_h u UN"
	mapping3["p u np"]    = "p_h u UN"
	mapping3["p u mp"]    = "p_h u UN m"
	mapping3["p oa np"]   = "p_h ua_n"
	mapping3["p oa mp"]   = "p_h ua_n m"
	mapping3["p o Np"]    = "p_h o UN"
	mapping3["p o np"]    = "p_h o UN"
	mapping3["p o mp"]    = "p_h o UN m"
	mapping3["p M Np"]    = "p_h u UN"
	mapping3["p M np"]    = "p_h u UN"
	mapping3["p M mp"]    = "p_h u UN m"
	mapping3["p ja Np"]   = "p_h i AN"
	mapping3["p j7 Np"]   = "p_h i AN"
	mapping3["p j7 np"]   = "p_h i AN"
	mapping3["p j7 mp"]   = "p_h i AN m"
	mapping3["n ue np"]   = "n u @_n"
	mapping3["n ue mp"]   = "n u @_n m"
	mapping3["m ue np"]   = "m u @_n"
	mapping3["m ue mp"]   = "m u @_n m"
	mapping3["m u Np"]    = "m u UN"
	mapping3["m u np"]    = "m u UN"
	mapping3["m u mp"]    = "m u UN m"
	mapping3["m oa np"]   = "m ua_n"
	mapping3["m oa mp"]   = "m ua_n m"
	mapping3["m o Np"]    = "m o UN"
	mapping3["m o np"]    = "m o UN"
	mapping3["m o mp"]    = "m o UN m"
	mapping3["m M Np"]    = "m u UN"
	mapping3["m M np"]    = "m u UN"
	mapping3["m M mp"]    = "m u UN m"
	mapping3["m ja Np"]   = "m i AN"
	mapping3["m j7 Np"]   = "m i AN"
	mapping3["m j7 np"]   = "m i AN"
	mapping3["m j7 mp"]   = "m i AN m"
	mapping3["k u7 Np"]   = "k_h uAN"
	mapping3["k u7 np"]   = "k_h uAN"
	mapping3["k u7 mp"]   = "k_h uAN m"
	mapping3["k oa Np"]   = "k_h uAN"
	mapping3["k ju Np"]   = "k_h 7_0 iUN"
	mapping3["k ju np"]   = "k_h 7_0 iUN"
	mapping3["k ju np"]   = "k_h 7_0 iUN m"
	mapping3["k jo Np"]   = "k_h 7_0 iUN"
	mapping3["k jo np"]   = "k_h 7_0 iUN"
	mapping3["k jo np"]   = "k_h 7_0 iUN m"
	mapping3["k je Np"]   = "k_h 7_0 iE_r @N"
	mapping3["k je np"]   = "k_h 7_0 iE_n"
	mapping3["k je mp"]   = "k_h 7_0 iE_n m"
	mapping3["k ja np"]   = "k_h 7_0 iE_r @_n"
	mapping3["k ja Np"]   = "k_h 7_0 iAN"
	mapping3["k ja mp"]   = "k_h 7_0 iE_r @_n m"
	mapping3["k j7 Np"]   = "k_h 7_0 iAN"
	mapping3["k j7 np"]   = "k_h 7_0 iAN"
	mapping3["k j7 mp"]   = "k_h 7_0 iAN m"
	mapping3["k i Np"]    = "k_h 7_0 iN"
	mapping3["k i np"]    = "k_h 7_0 i_n"
	mapping3["k i mp"]    = "k_h 7_0 i_n m"
	mapping3["h u7 Np"]   = "x uAN"
	mapping3["h u7 np"]   = "x uAN"
	mapping3["h u7 mp"]   = "x uAN m"
	mapping3["h oa Np"]   = "x uAN"
	mapping3["h ju Np"]   = "x 7_0 iUN"
	mapping3["h ju np"]   = "x 7_0 iUN"
	mapping3["h ju np"]   = "x 7_0 iUN m"
	mapping3["h jo Np"]   = "x 7_0 iUN"
	mapping3["h jo np"]   = "x 7_0 iUN"
	mapping3["h jo np"]   = "x 7_0 iUN m"
	mapping3["h je Np"]   = "x 7_0 iE_r @N"
	mapping3["h je np"]   = "x 7_0 iE_n"
	mapping3["h je mp"]   = "x 7_0 iE_n m"
	mapping3["h ja np"]   = "x 7_0 iE_r @_n"
	mapping3["h ja Np"]   = "x 7_0 iAN"
	mapping3["h ja mp"]   = "x 7_0 iE_r @_n m"
	mapping3["h j7 Np"]   = "x 7_0 iAN"
	mapping3["h j7 np"]   = "x 7_0 iAN"
	mapping3["h j7 mp"]   = "x 7_0 iAN m"
	mapping3["h i Np"]    = "x 7_0 iN"
	mapping3["h i np"]    = "x 7_0 i_n"
	mapping3["h i mp"]    = "x 7_0 i_n m"
	mapping3["g' u7 Np"]  = "k uAN"
	mapping3["g' u7 np"]  = "k uAN"
	mapping3["g u7 Np"]   = "k uAN"
	mapping3["g u7 np"]   = "k uAN"
	mapping3["g' u7 mp"]  = "k uAN m"
	mapping3["g u7 mp"]   = "k uAN m"
	mapping3["g' oa Np"]  = "k uAN"
	mapping3["g oa Np"]   = "k uAN"
	mapping3["g' ju Np"]  = "k 7_0 iUN"
	mapping3["g' ju np"]  = "k 7_0 iUN"
	mapping3["g' ju np"]  = "k 7_0 iUN m"
	mapping3["g ju Np"]   = "k 7_0 iUN"
	mapping3["g ju np"]   = "k 7_0 iUN"
	mapping3["g ju np"]   = "k 7_0 iUN m"
	mapping3["g' jo Np"]  = "k 7_0 iUN"
	mapping3["g' jo np"]  = "k 7_0 iUN"
	mapping3["g' jo np"]  = "k 7_0 iUN m"
	mapping3["g jo Np"]   = "k 7_0 iUN"
	mapping3["g jo np"]   = "k 7_0 iUN"
	mapping3["g jo np"]   = "k 7_0 iUN m"
	mapping3["g' je Np"]  = "k 7_0 iE_r @N"
	mapping3["g' je np"]  = "k 7_0 iE_n"
	mapping3["g je Np"]   = "k 7_0 iE_r @N"
	mapping3["g je np"]   = "k 7_0 iE_n"
	mapping3["g' je mp"]  = "k 7_0 iE_n m"
	mapping3["g je mp"]   = "k 7_0 iE_n m"
	mapping3["g' ja np"]  = "k 7_0 iE_r @_n"
	mapping3["g' ja Np"]  = "k 7_0 iAN"
	mapping3["g ja np"]   = "k 7_0 iE_r @_n"
	mapping3["g ja Np"]   = "k 7_0 iAN"
	mapping3["g' ja mp"]  = "k 7_0 iE_r @_n m"
	mapping3["g ja mp"]   = "k 7_0 iE_r @_n m"
	mapping3["g' j7 Np"]  = "k 7_0 iAN"
	mapping3["g' j7 np"]  = "k 7_0 iAN"
	mapping3["g j7 Np"]   = "k 7_0 iAN"
	mapping3["g j7 np"]   = "k 7_0 iAN"
	mapping3["g' j7 mp"]  = "k 7_0 iAN m"
	mapping3["g j7 mp"]   = "k 7_0 iAN m"
	mapping3["g' i Np"]   = "k 7_0 iN"
	mapping3["g' i np"]   = "k 7_0 i_n"
	mapping3["g i Np"]    = "k 7_0 iN"
	mapping3["g i np"]    = "k 7_0 i_n"
	mapping3["g' i mp"]   = "k 7_0 i_n m"
	mapping3["g i mp"]    = "k 7_0 i_n m"
	mapping3["d' ja Np"]  = "t ia AN"
	mapping3["d ja Np"]   = "t ia AN"
	mapping3["d' j7 Np"]  = "t ia AN"
	mapping3["d' j7 np"]  = "t ia AN"
	mapping3["d j7 Np"]   = "t ia AN"
	mapping3["d j7 np"]   = "t ia AN"
	mapping3["d' j7 mp"]  = "t ia AN m"
	mapping3["d j7 mp"]   = "t ia AN m"
	mapping3["d' i np"]   = "d 7_0 i_n"
	mapping3["d i np"]    = "d 7_0 i_n"
	mapping3["d' i mp"]   = "d 7_0 i_n m"
	mapping3["d i mp"]    = "d 7_0 i_n m"
	mapping3["ch ui Np"]  = "ts\\_h y_n"
	mapping3["ch ui np"]  = "ts\\_h y_n"
	mapping3["ch ui mp"]  = "ts\\_h y_n m"
	mapping3["ch ju Np"]  = "ts\\_h iUN"
	mapping3["ch ju np"]  = "ts\\_h iUN"
	mapping3["ch ju np"]  = "ts\\_h iUN m"
	mapping3["ch jo Np"]  = "ts\\_h iUN"
	mapping3["ch jo np"]  = "ts\\_h iUN"
	mapping3["ch jo np"]  = "ts\\_h iUN m"
	mapping3["c' ui Np"]  = "ts\\ y_n"
	mapping3["c' ui np"]  = "ts\\ y_n"
	mapping3["c ui Np"]   = "ts\\ y_n"
	mapping3["c ui np"]   = "ts\\ y_n"
	mapping3["c' ui mp"]  = "ts\\ y_n m"
	mapping3["c ui mp"]   = "ts\\ y_n m"
	mapping3["c' ju Np"]  = "ts\\ iUN"
	mapping3["c' ju np"]  = "ts\\ iUN"
	mapping3["c' ju np"]  = "ts\\ iUN m"
	mapping3["c ju Np"]   = "ts\\ iUN"
	mapping3["c ju np"]   = "ts\\ iUN"
	mapping3["c ju np"]   = "ts\\ iUN m"
	mapping3["c' jo Np"]  = "ts\\ iUN"
	mapping3["c' jo np"]  = "ts\\ iUN"
	mapping3["c' jo np"]  = "ts\\ iUN m"
	mapping3["c jo Np"]   = "ts\\ iUN"
	mapping3["c jo np"]   = "ts\\ iUN"
	mapping3["c jo np"]   = "ts\\ iUN m"
	mapping3["b' ue np"]  = "p u @_n"
	mapping3["b ue np"]   = "p u @_n"
	mapping3["b' ue mp"]  = "p u @_n m"
	mapping3["b ue mp"]   = "p u @_n m"
	mapping3["b' u Np"]   = "p u UN"
	mapping3["b' u np"]   = "p u UN"
	mapping3["b u Np"]    = "p u UN"
	mapping3["b u np"]    = "p u UN"
	mapping3["b' u mp"]   = "p u UN m"
	mapping3["b u mp"]    = "p u UN m"
	mapping3["b' oa np"]  = "p ua_n"
	mapping3["b oa np"]   = "p ua_n"
	mapping3["b' oa mp"]  = "p ua_n m"
	mapping3["b oa mp"]   = "p ua_n m"
	mapping3["b' o Np"]   = "p o UN"
	mapping3["b' o np"]   = "p o UN"
	mapping3["b o Np"]    = "p o UN"
	mapping3["b o np"]    = "p o UN"
	mapping3["b' o mp"]   = "p o UN m"
	mapping3["b o mp"]    = "p o UN m"
	mapping3["b' M Np"]   = "p u UN"
	mapping3["b' M np"]   = "p u UN"
	mapping3["b M Np"]    = "p u UN"
	mapping3["b M np"]    = "p u UN"
	mapping3["b' M mp"]   = "p u UN m"
	mapping3["b M mp"]    = "p u UN m"
	mapping3["b' ja Np"]  = "p i AN"
	mapping3["b ja Np"]   = "p i AN"
	mapping3["b' j7 Np"]  = "p i AN"
	mapping3["b' j7 np"]  = "p i AN"
	mapping3["b j7 Np"]   = "p i AN"
	mapping3["b j7 np"]   = "p i AN"
	mapping3["b' j7 mp"]  = "p i AN m"
	mapping3["b j7 mp"]   = "p i AN m"
	mapping2["ui Np"]     = "u iN"
	mapping2["ui np"]     = "u i_n"
	mapping2["ui np"]     = "u i_n m"
	mapping2["ue np"]     = "u@_n"
	mapping2["ue Np"]     = "u @N"
	mapping2["ue mp"]     = "u@_n m"
	mapping2["u7 Np"]     = "u AN"
	mapping2["u7 np"]     = "u AN"
	mapping2["u7 mp"]     = "u AN  m"
	mapping2["u Np"]      = "UN"
	mapping2["u np"]      = "UN"
	mapping2["u mp"]      = "UN m"
	mapping2["t jo"]      = "t_h 7_0 i@U"
	mapping2["t e np"]    = "t_h 7 @_n"
	mapping2["sh' ui"]    = "s\\ y"
	mapping2["sh ui"]     = "s\\ y"
	mapping2["sh' ja"]    = "s\\ ia"
	mapping2["sh ja"]     = "s\\ ia"
	mapping2["r ue"]      = "l u ei"
	mapping2["r ja"]      = "l ia"
	mapping2["r e np"]    = "l 7 @_n"
	mapping2["p ue"]      = "p_h u ei"
	mapping2["p jo"]      = "p_h 7_0 i@U"
	mapping2["oa np"]     = "UN"
	mapping2["oa Np"]     = "u AN"
	mapping2["oa mp"]     = "ua_n"
	mapping2["o Np"]      = "UN"
	mapping2["o np"]      = "UN"
	mapping2["o mp"]      = "UN m"
	mapping2["n ue"]      = "n u ei"
	mapping2["m ue"]      = "m u ei"
	mapping2["m o"]       = "m o"
	mapping2["M Np"]      = "UN"
	mapping2["M np"]      = "UN"
	mapping2["M mp"]      = "UN m"
	mapping2["l ue"]      = "l u ei"
	mapping2["l ja"]      = "l ia"
	mapping2["l e np"]    = "l 7 @_n"
	mapping2["k oa"]      = "k_h ua"
	mapping2["k ju"]      = "k_h 7_0 y"
	mapping2["k jo"]      = "k_h 7_0 i@U"
	mapping2["k je"]      = "k_h 7_0 iE_r"
	mapping2["k ja"]      = "k_h 7_0 ia"
	mapping2["k j7"]      = "k_h 7_0 iAU"
	mapping2["k i"]       = "k_h 7_0 i"
	mapping2["ju Np"]     = "i iUN"
	mapping2["ju np"]     = "i iUN"
	mapping2["ju np"]     = "i iUN m"
	mapping2["jo Np"]     = "i iUN"
	mapping2["jo np"]     = "i iUN"
	mapping2["jo np"]     = "i iUN m"
	mapping2["je Np"]     = "iE_r @N"
	mapping2["je np"]     = "iE_n"
	mapping2["je mp"]     = "iE_n m"
	mapping2["ja np"]     = "iE_r @_n"
	mapping2["ja Np"]     = "iAN"
	mapping2["ja mp"]     = "iE_r @_n m"
	mapping2["j7 Np"]     = "iAN"
	mapping2["j7 np"]     = "iAN"
	mapping2["j7 mp"]     = "iAN m"
	mapping2["i Np"]      = "iN"
	mapping2["i np"]      = "i_n"
	mapping2["i mp"]      = "i_n m"
	mapping2["h oa"]      = "x ua"
	mapping2["h ju"]      = "x 7_0 y"
	mapping2["h jo"]      = "x 7_0 i@U"
	mapping2["h je"]      = "x 7_0 iE_r"
	mapping2["h ja"]      = "x 7_0 ia"
	mapping2["h j7"]      = "x 7_0 iAU"
	mapping2["h i"]       = "x 7_0 i"
	mapping2["g' oa"]     = "k ua"
	mapping2["g oa"]      = "k ua"
	mapping2["g' ju"]     = "k 7_0 y"
	mapping2["g ju"]      = "k 7_0 y"
	mapping2["g' jo"]     = "k 7_0 i@U"
	mapping2["g jo"]      = "k 7_0 i@U"
	mapping2["g' je"]     = "k 7_0 iE_r"
	mapping2["g je"]      = "k 7_0 iE_r"
	mapping2["g' ja"]     = "k 7_0 ia"
	mapping2["g ja"]      = "k 7_0 ia"
	mapping2["g' j7"]     = "k 7_0 iAU"
	mapping2["g j7"]      = "k 7_0 iAU"
	mapping2["g' i"]      = "k 7_0 i"
	mapping2["g i"]       = "k 7_0 i"
	mapping2["e Np"]      = "@N"
	mapping2["e np"]      = "@_n"
	mapping2["d' ja"]     = "t ia"
	mapping2["d ja"]      = "t ia"
	mapping2["ch jo"]     = "ts\\_h i@U"
	mapping2["ch je"]     = "ts\\_h iE_r"
	mapping2["ch ja"]     = "ts\\_h ia"
	mapping2["ch j7"]     = "ts\\_h iAU"
	mapping2["ch i"]      = "ts\\_h i"
	mapping2["ch e"]      = "ts_h 7 ei"
	mapping2["c' jo"]     = "ts\\ i@U"
	mapping2["c jo"]      = "ts\\ i@U"
	mapping2["c' je"]     = "ts\\ iE_r"
	mapping2["c je"]      = "ts\\ iE_r"
	mapping2["c' ja"]     = "ts\\ ia"
	mapping2["c ja"]      = "ts\\ ia"
	mapping2["c' j7"]     = "ts\\ iAU"
	mapping2["c j7"]      = "ts\\ iAU"
	mapping2["c' i"]      = "ts\\ i"
	mapping2["c i"]       = "ts\\ i"
	mapping2["b' ue"]     = "p u ei"
	mapping2["b ue"]      = "p u ei"
	mapping2["b' o"]      = "p o"
	mapping2["b' o"]      = "p o"
	mapping2["b o"]       = "p o"
	mapping2["b o"]       = "p o"
	mapping2["b' jo"]     = "p 7_0 i@U"
	mapping2["b jo"]      = "p 7_0 i@U"
	mapping2["a Np"]      = "AN"
	mapping2["a np"]      = "a_n"
	mapping2["a mp"]      = "a_n m"
	mapping2["7 Np"]      = "AN"
	mapping2["7 np"]      = "AN"
	mapping2["7 mp"]      = "AN m"
	mapping["z"]          = "ts"
	mapping["v"]          = "u"
	mapping["ui"]         = "u i"
	mapping["ue"]         = "uei"
	mapping["u7"]         = "uo"
	mapping["t"]          = "t_h"
	mapping["Sil"]        = "Sil"
	mapping["sh'"]        = "s\\"
	mapping["sh"]         = "s\\"
	mapping["s'"]         = "s"
	mapping["s"]          = "s"
	mapping["rp"]         = "l"
	mapping["r"]          = "l"
	mapping["p"]          = "p_h"
	mapping["oa"]         = "u a"
	mapping["o"]          = "@U"
	mapping["n"]          = "n"
	mapping["Mi"]         = "u i"
	mapping["M"]          = "u"
	mapping["m"]          = "m"
	mapping["l"]          = "l"
	mapping["k"]          = "k_h"
	mapping["ju"]         = "i u"
	mapping["jo"]         = "i@U"
	mapping["je"]         = "iE_r"
	mapping["ja"]         = "i a"
	mapping["j7"]         = "iAU"
	mapping["h"]          = "x"
	mapping["gp"]         = "k"
	mapping["g'"]         = "k"
	mapping["g"]          = "k"
	mapping["e"]          = "ei"
	mapping["dp"]         = "t"
	mapping["d'"]         = "t"
	mapping["d"]          = "t"
	mapping["D"]          = "n"
	mapping["ch"]         = "ts_h"
	mapping["c'"]         = "ts"
	mapping["c"]          = "ts"
	mapping["C"]          = "ts"
	mapping["bp"]         = "p"
	mapping["b'"]         = "p"
	mapping["b"]          = "p"
	mapping["7"]          = "AU"
	mapping["@r"]         = "@`"


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
			if i + 2 <= table.getn(phns) then
				threephn = phns[i] .. " " .. phns[i + 1] .. " " .. phns[i + 2]
				if mapping3[threephn] then
					phns[i] = mapping3[threephn]
					phns[i + 1] = ""
					phns[i + 2] = ""
					mapped = true
				end
			end

			if not mapped then
				if i + 1 <= table.getn(phns) then
					twophn = phns[i] .. " " .. phns[i + 1]
					if mapping2[twophn] then
						phns[i] = mapping2[twophn]
						phns[i + 1] = ""
						-- (in this case no need to increment i because mapping2[twophn][2] is always "i", so will map to "i" on next iteration)
						mapped = true -- there's no continue in lua
					end
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
