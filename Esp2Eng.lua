-- Esp2Chn.lua
-- Mapping of Spanish VSQ(X)'s to English phonetics.

function manifest()
    myManifest = {
        name          = "ESP->ENG",
        comment       = "Convert Spanish VSQX for English Libraries.",
        author        = "Slidingwall",
        pluginID      = "{SPANISH-SILD-INGW-ALL0-00000ENGLISH}",
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

    local mapping       = {}
    local mapping2      = {}
    local mapping3      = {}
    local noteEx        = {}
    local noteExList    = {}
    local noteCount
    local retCode
    local idx

    mapping2["e I"]     = "eI"
    mapping2["a I"]     = "aI"
    mapping2["o I"]     = "OI"
    mapping2["a U"]     = "aU"
    mapping2["o U"]     = "@U"
    mapping["a"]     = "{"
    mapping["i"]     = "i:"
    mapping["o"]     = "O:"
    mapping["u"]     = "u:"
    mapping["B"]     = "v"
    mapping["G"]     = "gh"
    mapping["x"]     = "h"
    mapping["J"]     = "ny"
    mapping["l"]     = "l0"
    mapping["rr"]     = "r"
    mapping["L"]     = "j"
    mapping["j\\"]     = "j"
    mapping["O"]     = "O:"
    mapping["E"]     = "e"
    mapping["I0"]     = "I"
    mapping["r\\"]     = "r"
    mapping["L0"]     = "l"
    mapping["ts"]     = "t s"
    mapping["dz"]     = "d z"

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
