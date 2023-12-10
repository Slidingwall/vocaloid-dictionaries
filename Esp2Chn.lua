-- Esp2Chn.lua
-- Mapping of Spanish VSQ(X)'s to Chinese phonetics.

function manifest()
    myManifest = {
        name          = "Spanish to Chinese",
        comment       = "Convert Spanish VSQX for Chinese voice banks",
        author        = "Slidingwall",
        pluginID      = "{ABDXFHE-1919-810A-A12F-92E541234567}",
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

    local mapping       = {}
    local mapping2      = {}
    local mapping2a     = {}
    local mapping3      = {}
    local noteEx        = {}
    local noteExList    = {}
    local noteCount
    local retCode
    local idx

    mapping3["j a I"]   = { "ia aI" }
    mapping3["j e I"]   = { "iE_r ei" }
    mapping3["w a I"]   = { "uaI" }
    mapping3["w e I"]   = { "uei" }

    mapping["L"]        = "i"
    mapping["j\\"]      = "i"
    mapping2["L a"]     = { "ia" }
    mapping2["L e"]     = { "iE_r" }
    mapping2["L i"]     = { "i" }
    mapping2["L o"]     = { "iAU" }
    mapping2["L u"]     = { "i@U" }
    mapping2["j\\ a"]   = { "ia" }
    mapping2["j\\ e"]   = { "iE_r" }
    mapping2["j\\ i"]   = { "i" }
    mapping2["j\\ o"]   = { "iAU" }
    mapping2["j\\ u"]   = { "i@U" }
    mapping3["L a I"]   = { "ia aI" }
    mapping3["L e I"]   = { "iE_r ei" }
    mapping3["L o I"]   = { "iAU i" }
    mapping3["j\\ a I"] = { "ia aI" }
    mapping3["j\\ e I"] = { "iE_r ei" }
    mapping3["j\\ o I"] = { "iAU i" }
    mapping3["L a U"]   = { "iAU" }
    mapping3["L e U"]   = { "i@U" }
    mapping3["L o U"]   = { "i@U" }
    mapping3["j\\ a U"] = { "iAU" }
    mapping3["j\\ e U"] = { "i@U" }
    mapping3["j\\ o U"] = { "i@U" }
    mapping3["L w a"]   = { "i ua" }
    mapping3["L w e"]   = { "i uei" }
    mapping3["L w i"]   = { "y" }
    mapping3["L w o"]   = { "i uo" }
    mapping3["j\\ w a"] = { "i ua" }
    mapping3["j\\ w e"] = { "iE_r" }
    mapping3["j\\ w i"] = { "y" }
    mapping3["j\\ w o"] = { "i uo" }
    mapping["g"]        = "k"
    mapping["k"]        = "k_h"
    mapping["l"]        = "l"
    mapping["r"]        = "l"
    mapping["rr"]       = "l"
    mapping["J"]        = "n i"
    mapping2["J a"]     = { "n ia" }
    mapping2["J e"]     = { "n iE_r" }
    mapping2["J i"]     = { "n i" }
    mapping2["J o"]     = { "n iAU" }
    mapping2["J u"]     = { "n i@U" }
    mapping3["J a I"]   = { "n ia aI" }
    mapping3["J e I"]   = { "n iE_r ei" }
    mapping3["J o I"]   = { "n iAU i" }
    mapping3["J a U"]   = { "n iAU" }
    mapping3["J e U"]   = { "n i@U" }
    mapping3["J o U"]   = { "n i@U" }
    mapping3["J w a"]   = { "n i ua" }
    mapping3["J w e"]   = { "n i uei" }
    mapping3["J w i"]   = { "n y" }
    mapping3["J w o"]   = { "n i uo" }
    mapping["b"]        = "p"
    mapping["p"]        = "p_h"
    mapping["D"]        = "s"
    mapping2["s i"]     = { "s\\ i" }
    mapping2["D i"]     = { "s\\ i" }
    mapping3["s j a"]   = { "s\\ ia" }
    mapping3["D j a"]   = { "s\\ ia" }
    mapping3["s j e"]   = { "s\\ iE_r" }
    mapping3["D j e"]   = { "s\\ iE_r" }
    mapping3["s j o"]   = { "s\\ iAU" }
    mapping3["D j o"]   = { "s\\ iAU" }
    mapping3["s j u"]   = { "s\\ i@U" }
    mapping3["D j u"]   = { "s\\ i@U" }
    mapping["d"]        = "t"
    mapping["t"]        = "t_h"
    mapping["T"]        = "ts"
    mapping["tS"]       = "ts`"
    mapping2["tS i"]    = { "ts\\ i" }
    mapping2["T i"]     = { "ts\\ i" }
    mapping3["tS j a"]  = { "ts\\ ia" }
    mapping3["T j a"]   = { "ts\\ ia" }
    mapping3["tS j e"]  = { "ts\\ iE_r" }
    mapping3["T j e"]   = { "ts\\ iE_r" }
    mapping3["tS j o"]  = { "ts\\ iAU" }
    mapping3["T j o"]   = { "ts\\ iAU" }
    mapping3["tS j u"]  = { "ts\\ i@U" }
    mapping3["T j u"]   = { "ts\\ i@U" }
    mapping["B"]        = "u"
    mapping2["B a"]     = { "ua" }
    mapping2["B e"]     = { "uei" }
    mapping2["B i"]     = { "u i" }
    mapping2["B o"]     = { "uo" }
    mapping2["B u"]     = { "u" }
    mapping3["B a I"]   = { "uaI" }
    mapping3["B e I"]   = { "uei" }
    mapping3["B o I"]   = { "uo i" }
    mapping3["B a U"]   = { "u AU" }
    mapping3["B e U"]   = { "u @U" }
    mapping3["B o U"]   = { "u @U" }
    mapping3["B j a"]   = { "u ia" }
    mapping3["B j e"]   = { "u iE_r" }
    mapping3["B j o"]   = { "u iAU" }
    mapping3["B j u"]   = { "u i@U" }
    mapping3["B w a"]   = { "ua" }
    mapping3["B w e"]   = { "uei" }
    mapping3["B w i"]   = { "u i" }
    mapping3["B w o"]   = { "uo" }
    mapping["G"]        = "x"


    mapping["e"]       = "ei"
    mapping2["k i"]    = { "k_h 7_0 i" }
    mapping2["g i"]    = { "k 7_0 i" }
    mapping2["f i"]    = { "f o_0 i" }
    mapping2["x i"]    = { "x 7_0 i" }
    mapping2["G i"]    = { "x 7_0 i" }
    mapping["o"]       = "@U"
    mapping2["p o"]    = { "p_h o" }
    mapping2["b o"]    = { "p o" }
    mapping2["f o"]    = { "f o" }
    mapping2["m o"]    = { "m o" }
    mapping2["l o"]    = { "l o" }
    mapping2["r o"]    = { "l o" }
    mapping2["rr o"]   = { "l o" }
    mapping2["a I"]    = { "aI" }
    mapping3["f a I"]  = { "f a ai" }
    mapping2["e I"]    = { "ei" }
    mapping2["o I"]    = { "@U i" }
    mapping3["p o I"]  = { "p_h o i" }
    mapping3["b o I"]  = { "p o i" }
    mapping3["f o I"]  = { "f o i" }
    mapping3["m o I"]  = { "m o i" }
    mapping3["l o I"]  = { "l o i" }
    mapping3["r o I"]  = { "l o i" }
    mapping3["rr o I"] = { "l o i" }
    mapping2["a U"]    = { "AU" }
    mapping3["f a U"]  = { "f a AU" }
    mapping2["e U"]    = { "@U" }
    mapping2["o U"]    = { "@U" }
    mapping2["j a"]    = { "ia" }
    mapping3["k j a"]  = { "k_h 7_0 ia" }
    mapping3["f j a"]  = { "f o_0 ia" }
    mapping3["x j a"]  = { "x 7_0 ia" }
    mapping3["G j a"]  = { "x 7_0 ia" }
    mapping3["p j a"]  = { "p_h i a" }
    mapping3["t j a"]  = { "t_h i a" }
    mapping3["b j a"]  = { "p i a" }
    mapping2["j e"]    = { "iE_r" }
    mapping3["k j e"]  = { "k_h 7_0 iE_r" }
    mapping3["f j e"]  = { "f o_0 iE_r" }
    mapping3["x j e"]  = { "x 7_0 iE_r" }
    mapping3["G j e"]  = { "x 7_0 iE_r" }
    mapping2["j o"]    = { "iAU" }
    mapping3["k j o"]  = { "k_h 7_0 iAU" }
    mapping3["f j o"]  = { "f o_0 iAU" }
    mapping3["x j o"]  = { "x 7_0 iAU" }
    mapping3["G j o"]  = { "x 7_0 iAU" }
    mapping2["j u"]    = { "i@U" }
    mapping3["k j u"]  = { "k_h 7_0 i@U" }
    mapping3["f j u"]  = { "f o_0 i@U" }
    mapping3["x j u"]  = { "x 7_0 i@U" }
    mapping3["G j u"]  = { "x 7_0 i@U" }
    mapping3["p j u"]  = { "p_h i @U" }
    mapping3["t j u"]  = { "t_h i @U" }
    mapping3["b j u"]  = { "p i @U" }
    mapping2["w a"]    = { "u a" }
    mapping3["k w a"]  = { "k_h ua" }
    mapping3["g w a"]  = { "k ua" }
    mapping3["x w a"]  = { "x ua" }
    mapping3["G w a"]  = { "x ua" }
    mapping2["w e"]    = { "uei" }
    mapping3["p w e"]  = { "p_h u ei" }
    mapping3["b w e"]  = { "p u ei" }
    mapping3["f w e"]  = { "f u ei" }
    mapping3["n w e"]  = { "n u ei" }
    mapping3["m w e"]  = { "m u ei" }
    mapping3["l w e"]  = { "l u ei" }
    mapping3["r w e"]  = { "l u ei" }
    mapping3["rr w e"] = { "l u ei" }
    mapping2["w o"]    = { "uo" }
    mapping3["p w o"]  = { "p_h uo" }
    mapping3["b w o"]  = { "p uo" }
    mapping3["f w o"]  = { "f uo" }
    mapping3["m w o"]  = { "m uo" }
    mapping2["w i"]    = { "u i" }

    mapping["Sil"]     = "Sil"

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
                    phns[i] = mapping3[threephn][1]
                    phns[i + 1] = mapping3[threephn][2]
                    phns[i + 2] = mapping3[threephn][3]
                    mapped = true
                end
            end

            if not mapped then
                if i + 1 <= table.getn(phns) then
                    twophn = phns[i] .. " " .. phns[i + 1]
                    if mapping2a[twophn] then
                        phns[i] = mapping2a[twophn][1]
                        phns[i + 1] = mapping2a[twophn][2]
                        -- (in this case no need to increment i because mapping2[twophn][2] is always "i", so will map to "i" on next iteration)
                        mapped = true -- there's no continue in lua
                    end
                end
            end

            if not mapped then
                if i + 1 <= table.getn(phns) then
                    twophn = phns[i] .. " " .. phns[i + 1]
                    if mapping2[twophn] then
                        phns[i] = mapping2[twophn][1]
                        phns[i + 1] = mapping2[twophn][2]
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
