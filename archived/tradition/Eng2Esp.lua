-- Eng2Esp.lua
-- Mapping of English VSQ(X)'s to Spanish phonetics.

function manifest()
    myManifest = {
        name          = "ENG->ESP",
        comment       = "Convert English VSQX for Spanish Libraries",
        author        = "Slidingwall",
        pluginID      = "{ENGLISH0-SILD-INGW-ALL0-00000SPANISH}",
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

    local mapping    = {}
    local mapping2   = {}
    local noteEx     = {}
    local noteExList = {}
    local noteCount
    local retCode
    local idx

    mapping["@"]     = "a"
    mapping["V"]     = "a"
    mapping["e"]     = "e"
    mapping["I"]     = "i"
    mapping["i:"]    = "i"
    mapping["{"]     = "e"
    mapping["O:"]    = "o"
    mapping["Q"]     = "o"
    mapping["U"]     = "u"
    mapping["u:"]    = "u"
    mapping["@r"]    = "a r"
    mapping["I@"]    = "i r"
    mapping["e@"]    = "e r"
    mapping["U@"]    = "u r"
    mapping["O@"]    = "o r"
    mapping["Q@"]    = "o r"
    mapping["eI"]    = "e I"
    mapping["aI"]    = "a I"
    mapping["OI"]    = "o I"
    mapping["@U"]    = "o U"
    mapping["aU"]    = "a U"
    mapping["m"]     = "m"
    mapping["n"]     = "n"
    mapping["N"]     = "n"
    mapping["w"]     = "w"
    mapping2["w @"]  = { "w", "a" }
    mapping2["w V"]  = { "w", "a" }
    mapping2["w e"]  = { "w", "e" }
    mapping2["w I"]  = { "w", "i" }
    mapping2["w i:"] = { "w", "i" }
    mapping2["w O:"] = { "w", "o" }
    mapping2["w Q"]  = { "w", "o" }
    mapping2["w {"]  = { "w", "e" }
    mapping2["w @r"] = { "w", "a r" }
    mapping2["w I@"] = { "w", "i r" }
    mapping2["w e@"] = { "w", "e r" }
    mapping2["w O@"] = { "w", "o r" }
    mapping2["w Q@"] = { "w", "a r" }
    mapping2["w eI"] = { "w", "e I" }
    mapping2["w aI"] = { "w", "a I" }
    mapping2["w OI"] = { "w", "o I r" }
    mapping2["w @U"] = { "w", "o U r" }
    mapping2["w aU"] = { "w", "a U r" }
    mapping["j"]     = "j"
    mapping2["j @"]  = { "j", "a" }
    mapping2["j V"]  = { "j", "a" }
    mapping2["j e"]  = { "j", "e" }
    mapping2["j {"]  = { "j", "e" }
    mapping2["j I"]  = { "j", "i" }
    mapping2["j i:"] = { "j", "i" }
    mapping2["j O:"] = { "j", "o" }
    mapping2["j Q"]  = { "j", "o" }
    mapping2["j u:"] = { "j", "u" }
    mapping2["j U"]  = { "j", "u" }
    mapping2["j @r"] = { "j", "a r" }
    mapping2["j I@"] = { "j", "i r" }
    mapping2["j e@"] = { "j", "e r" }
    mapping2["j O@"] = { "j", "o r" }
    mapping2["j Q@"] = { "j", "a r" }
    mapping2["j eI"] = { "j", "e I" }
    mapping2["j aI"] = { "j", "a I" }
    mapping2["j OI"] = { "j", "o I r" }
    mapping2["j @U"] = { "j", "o U r" }
    mapping2["j aU"] = { "j", "a U r" }
    mapping["r"]     = "r"
    mapping["l"]     = "l"
    mapping["l0"]    = "l"
    mapping["p"]     = "p"
    mapping["t"]     = "t"
    mapping["k"]     = "k"
    mapping["ph"]    = "p"
    mapping["gh"]    = "G"
    mapping["th"]    = "t"
    mapping["kh"]    = "k"
    mapping["bh"]    = "B"
    mapping["dh"]    = "D"
    mapping["b"]     = "b"
    mapping["d"]     = "d"
    mapping["g"]     = "g"
    mapping["tS"]    = "tS"
    mapping["dZ"]    = "d s"
    mapping["f"]     = "f"
    mapping["T"]     = "T"
    mapping["s"]     = "s"
    mapping["S"]     = "s"
    mapping["h"]     = "x"
    mapping["v"]     = "B"
    mapping["z"]     = "d s"
    mapping["Z"]     = "L"
    mapping["D"]     = "D"
    mapping["R"]     = "rr"

    mapping["Sil"]   = "Sil"

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
