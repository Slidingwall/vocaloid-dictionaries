-- Eng2Chn.lua
-- Mapping of English VSQ(X)'s to Chinese phonetics.

function manifest()
    myManifest = {
        name          = "English to Chinese",
        comment       = "Convert English VSQX for Chinese voice banks",
        author        = "Slidingwall",
        pluginID      = "{A114514A-1234-3456-A12F-19198105D41T}",
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

    local mapping     = {}
    local mapping2    = {}
    local noteEx      = {}
    local noteExList  = {}
    local noteCount
    local retCode
    local idx

    mapping["@"]      = "7"
    mapping["V"]      = "7"
    mapping["e"]      = "ei"
    mapping["I"]      = "i"
    mapping["i:"]     = "i"
    mapping["{"]      = "a"
    mapping["O:"]     = "o"
    mapping["Q"]      = "AU"
    mapping["U"]      = "UN"
    mapping["u:"]     = "u"
    mapping["l"]      = "l"
    mapping["r"]      = "z`"
    mapping["@r"]     = "@`"
    mapping["I@"]     = "i @`"
    mapping["e@"]     = "ei @`"
    mapping["U@"]     = "u @`"
    mapping["O@"]     = "o @`"
    mapping["Q@"]     = "AU @`"
    mapping["eI"]     = "ei"
    mapping["aI"]     = "aI"
    mapping["OI"]     = "o i"
    mapping["@U"]     = "@U"
    mapping["aU"]     = "AU"
    mapping["m"]      = "m"
    mapping["n"]      = "n"
    mapping["p"]      = "p_h"
    mapping["t"]      = "t_h"
    mapping["k"]      = "k_h"
    mapping["ph"]     = "p_h"
    mapping["th"]     = "t_h"
    mapping["kh"]     = "k_h"
    mapping["b"]      = "p"
    mapping["d"]      = "t"
    mapping["g"]      = "k"
    mapping["bh"]     = "p"
    mapping["dh"]     = "t"
    mapping["gh"]     = "k"
    mapping["tS"]     = "ts`_h"
    mapping["dZ"]     = "ts`"
    mapping["l0"]     = "l"
    mapping["f"]      = "f"
    mapping["T"]      = "s_0"
    mapping["s"]      = "s"
    mapping["S"]      = "s`"
    mapping["h"]      = "x"
    mapping["v"]      = "p_0"
    mapping["z"]      = "ts"
    mapping["Z"]      = "z`"
    mapping["D"]      = "ts_0"
    mapping["w"]      = "u"
    mapping["e@0"]    = "a"
    mapping["4"]      = "l"
    mapping["R"]      = "l"
    mapping["@l"]     = "@U"
    mapping["h\\"]    = "x"
    mapping["j"]      = "i"

    mapping2["t s"]   = { "ts" }
    mapping2["th s"]  = { "ts_h" }
    mapping2["t S"]   = { "ts`" }
    mapping2["th S"]  = { "ts`_h" }
    mapping2["@ n"]   = { "@_n" }
    mapping2["V n"]   = { "AN" }
    mapping2["e n"]   = { "@_n" }
    mapping2["I n"]   = { "i_n" }
    mapping2["i: n"]  = { "i_n" }
    mapping2["{ n"]   = { "a_n" }
    mapping2["O: n"]  = { "AN" }
    mapping2["Q n"]   = { "AN" }
    mapping2["U n"]   = { "u@_n" }
    mapping2["u: n"]  = { "u@_n" }
    mapping2["eI n"]  = { "@_n" }
    mapping2["aI n"]  = { "a_n" }
    mapping2["OI n"]  = { "UN" }
    mapping2["@U n"]  = { "@N" }
    mapping2["aU n"]  = { "AN" }
    mapping2["@ N"]   = { "@N" }
    mapping2["V N"]   = { "AN" }
    mapping2["e N"]   = { "@N" }
    mapping2["I N"]   = { "iN" }
    mapping2["i: N"]  = { "iN" }
    mapping2["{ N"]   = { "AN" }
    mapping2["O: N"]  = { "AN" }
    mapping2["Q N"]   = { "AN" }
    mapping2["U N"]   = { "UN" }
    mapping2["u N"]   = { "UN" }
    mapping2["eI N"]  = { "@N" }
    mapping2["aI N"]  = { "AN" }
    mapping2["OI N"]  = { "UN" }
    mapping2["@U N"]  = { "@N" }
    mapping2["aU N"]  = { "AN" }
    mapping2["@ l"]   = { "AU" }
    mapping2["V l"]   = { "AU" }
    mapping2["e l"]   = { "ei", "o" }
    mapping2["I l"]   = { "i@U" }
    mapping2["i: l"]  = { "i@U" }
    mapping2["{ l"]   = { "AU" }
    mapping2["O: l"]  = { "AU" }
    mapping2["Q l"]   = { "AU" }
    mapping2["U l"]   = { "UN o" }
    mapping2["u: l"]  = { "u o" }
    mapping2["eI l"]  = { "ei @U" }
    mapping2["aI l"]  = { "aI @U" }
    mapping2["OI l"]  = { "o i@U" }
    mapping2["@U l"]  = { "@U" }
    mapping2["aU l"]  = { "AU" }
    mapping2["j @"]   = { "ia" }
    mapping2["j V"]   = { "ia" }
    mapping2["j e"]   = { "ie" }
    mapping2["j I"]   = { "i" }
    mapping2["j i:"]  = { "i" }
    mapping2["j {"]   = { "ia" }
    mapping2["j O:"]  = { "iAU" }
    mapping2["j Q"]   = { "iAU" }
    mapping2["j U"]   = { "iUN" }
    mapping2["j u:"]  = { "i@U" }
    mapping2["j @r"]  = { "i @`" }
    mapping2["j I@"]  = { "i @`" }
    mapping2["j e@"]  = { "ie @`" }
    mapping2["j U@"]  = { "i@U @`" }
    mapping2["j O@"]  = { "iAU @`" }
    mapping2["j Q@"]  = { "iAU @`" }
    mapping2["j eI"]  = { "ie ei" }
    mapping2["j aI"]  = { "ia aI" }
    mapping2["j OI"]  = { "i@U i" }
    mapping2["j @U"]  = { "i@U" }
    mapping2["j aU"]  = { "iAU" }
    mapping2["w @"]   = { "ua" }
    mapping2["w V"]   = { "ua" }
    mapping2["w e"]   = { "uei" }
    mapping2["w I"]   = { "uei" }
    mapping2["w i:"]  = { "uei" }
    mapping2["w {"]   = { "ua" }
    mapping2["w O:"]  = { "ua AU" }
    mapping2["w Q"]   = { "ua AU" }
    mapping2["w U"]   = { "UN" }
    mapping2["w u:"]  = { "u" }
    mapping2["w @r"]  = { "u @`" }
    mapping2["w I@"]  = { "uei @`" }
    mapping2["w e@"]  = { "uei @`" }
    mapping2["w U@"]  = { "u @`" }
    mapping2["w O@"]  = { "uo @`" }
    mapping2["w Q@"]  = { "ua AU @`" }
    mapping2["w eI"]  = { "uei" }
    mapping2["w aI"]  = { "ua aI" }
    mapping2["w OI"]  = { "uo i" }
    mapping2["w @U"]  = { "uo @U" }
    mapping2["w aU"]  = { "ua AU" }
    mapping2["@ r"]   = { "7 @`" }
    mapping2["V r"]   = { "7 @`" }
    mapping2["e r"]   = { "7 @`" }
    mapping2["I r"]   = { "i @`" }
    mapping2["i: r"]  = { "i @`" }
    mapping2["{ r"]   = { "a @`" }
    mapping2["O: r"]  = { "AU @`" }
    mapping2["Q r"]   = { "AU @`" }
    mapping2["U r"]   = { "UN @`" }
    mapping2["u: r"]  = { "u @`" }
    mapping2["eI r"]  = { "ei @`" }
    mapping2["aI r"]  = { "aI @`" }
    mapping2["OI r"]  = { "o i@`" }
    mapping2["@U r"]  = { "@U @`" }
    mapping2["aU r"]  = { "AU @`" }
    mapping2["V v"]   = { "7 f" }
    mapping2["v @"]   = { "u @U" }
    mapping2["v @U"]  = { "u @U" }
    mapping2["v @r"]  = { "u @`" }
    mapping2["v I"]   = { "u i" }
    mapping2["v I@"]  = { "u i @`" }
    mapping2["v O:"]  = { "uo" }
    mapping2["v O@"]  = { "uo @`" }
    mapping2["v OI"]  = { "uo i" }
    mapping2["v Q"]   = { "ua AU" }
    mapping2["v Q@"]  = { "ua @`" }
    mapping2["v U"]   = { "u" }
    mapping2["v U@"]  = { "u @`" }
    mapping2["v V"]   = { "u 7" }
    mapping2["v aI"]  = { "uaI" }
    mapping2["v aU"]  = { "ua AU" }
    mapping2["v e"]   = { "uei" }
    mapping2["v e@"]  = { "uei @`" }
    mapping2["v eI"]  = { "uei" }
    mapping2["v i:"]  = { "u i" }
    mapping2["v u:"]  = { "u" }
    mapping2["v {"]   = { "ua" }
    mapping2["D r"]   = { "ts`" }
    mapping2["S r"]   = { "s`" }
    mapping2["T r"]   = { "s" }
    mapping2["Z r"]   = { "z`" }
    mapping2["d r"]   = { "ts`" }
    mapping2["dZ r"]  = { "ts` " }
    mapping2["dh r"]  = { "ts`_h" }
    mapping2["l r"]   = { "l" }
    mapping2["l0 r"]  = { "l" }
    mapping2["r r"]   = { "z`" }
    mapping2["s r"]   = { "s`" }
    mapping2["t r"]   = { "ts` " }
    mapping2["tS r"]  = { "ts`_h" }
    mapping2["th r"]  = { "ts`_h" }
    mapping2["z r"]   = { "z`" }
    mapping2["r @r"]  = { "z` 7 @`" }
    mapping2["r I"]   = { "z` i`i" }
    mapping2["r I@"]  = { "z` i`@`" }
    mapping2["r O:"]  = { "z`uo" }
    mapping2["r O@"]  = { "z` uo @`" }
    mapping2["r OI"]  = { "z` uo i" }
    mapping2["r aI"]  = { "z`uai" }
    mapping2["r e"]   = { "z` 7 ei" }
    mapping2["r e@"]  = { "z`7 @`" }
    mapping2["r eI"]  = { "z`7 ei" }
    mapping2["r i:"]  = { "z` i`i" }
    mapping2["r {"]   = { "z` ua" }
    mapping2["D @r"]  = { "ts 7 @`" }
    mapping2["S @r"]  = { "s` 7 @`" }
    mapping2["T @r"]  = { "s 7 @`" }
    mapping2["Z @r"]  = { "z`7 @`" }
    mapping2["b @r"]  = { "p 7 @`" }
    mapping2["bh @r"] = { "p 7 @`" }
    mapping2["d @r"]  = { "t 7 @`" }
    mapping2["dZ @r"] = { "ts` 7 @`" }
    mapping2["dh @r"] = { "t 7 @`" }
    mapping2["f @r"]  = { "f o @`" }
    mapping2["g @r"]  = { "k 7 @`" }
    mapping2["gh @r"] = { "k 7 @`" }
    mapping2["h @r"]  = { "x 7 @`" }
    mapping2["j @r"]  = { "i @`" }
    mapping2["k @r"]  = { "k 7 @`" }
    mapping2["kh @r"] = { "k_h 7 @`" }
    mapping2["l @r"]  = { "l 7 @`" }
    mapping2["l0 @r"] = { "l 7 @`" }
    mapping2["m @r"]  = { "m 7 @`" }
    mapping2["n @r"]  = { "n 7 @`" }
    mapping2["p @r"]  = { "p 7 @`" }
    mapping2["ph @r"] = { "p_h 7 @`" }
    mapping2["r @r"]  = { "z` 7 @`" }
    mapping2["s @r"]  = { "s 7 @`" }
    mapping2["t @r"]  = { "t 7 @`" }
    mapping2["tS @r"] = { "ts`_h 7 @`" }
    mapping2["th @r"] = { "t_h 7 @`" }
    mapping2["v @r"]  = { "u @`" }
    mapping2["w @r"]  = { "u @`" }
    mapping2["z @r"]  = { "ts 7 @`" }
    mapping2["D I"]   = { "ts_0 i\\ i" }
    mapping2["D I@"]  = { "ts_0 i\\ @`" }
    mapping2["D O:"]  = { "ts_0 uo" }
    mapping2["D O@"]  = { "ts_0 uo @`" }
    mapping2["D OI"]  = { "ts_0 uo i" }
    mapping2["D i:"]  = { "ts_0 i\\ i" }
    mapping2["S I"]   = { "s\\ i" }
    mapping2["S I@"]  = { "s\\ i @`" }
    mapping2["S O:"]  = { "s`uo" }
    mapping2["S O@"]  = { "s` uo @`" }
    mapping2["S OI"]  = { "s` uo i" }
    mapping2["S U"]   = { "s`u UN" }
    mapping2["S i:"]  = { "s` i`i" }
    mapping2["T I"]   = { "s_0 i\\ i" }
    mapping2["T O:"]  = { "s_0 uo" }
    mapping2["T O@"]  = { "s_0 uo @`" }
    mapping2["T OI"]  = { "s_0 uo i" }
    mapping2["T i:"]  = { "s_0 i\\ i" }
    mapping2["Z I"]   = { "z`i` i" }
    mapping2["Z I@"]  = { "z`i` @`" }
    mapping2["Z O:"]  = { "z` uo" }
    mapping2["Z O@"]  = { "z`uo @`" }
    mapping2["Z OI"]  = { "z`uo i" }
    mapping2["Z aI"]  = { "z` uaI" }
    mapping2["Z e"]   = { "z`uei" }
    mapping2["Z e@"]  = { "z` uei @`" }
    mapping2["Z eI"]  = { "z` uei" }
    mapping2["Z i:"]  = { "z`i` i" }
    mapping2["Z {"]   = { "z`ua" }
    mapping2["b @"]   = { "p o 7" }
    mapping2["b @U"]  = { "p o @U" }
    mapping2["b U"]   = { "p u UN" }
    mapping2["b V"]   = { "p a 7" }
    mapping2["bh @"]  = { "p o 7" }
    mapping2["bh @U"] = { "p o @U" }
    mapping2["bh U"]  = { "p u UN" }
    mapping2["bh V"]  = { "p a 7" }
    mapping2["d O:"]  = { "t uo" }
    mapping2["d O@"]  = { "t uo @`" }
    mapping2["d OI"]  = { "t uo i" }
    mapping2["dZ I"]  = { "ts\\ i" }
    mapping2["dZ I@"] = { "ts\\ i @`" }
    mapping2["dZ O:"] = { "ts` uo" }
    mapping2["dZ O@"] = { "ts`", "uo @`" }
    mapping2["dZ OI"] = { "ts`uo i" }
    mapping2["dZ i:"] = { "ts\\ i" }
    mapping2["dh O:"] = { "ts` uo" }
    mapping2["dh O@"] = { "ts`uo @`" }
    mapping2["dh OI"] = { "ts`uo i" }
    mapping2["f @"]   = { "f o 7" }
    mapping2["f I"]   = { "f o i" }
    mapping2["f I@"]  = { "f o i @`" }
    mapping2["f Q"]   = { "f a AU" }
    mapping2["f Q@"]  = { "f a @`" }
    mapping2["f U"]   = { "f u UN" }
    mapping2["f V"]   = { "f a 7" }
    mapping2["f aI"]  = { "f a ai" }
    mapping2["f aU"]  = { "f a AU" }
    mapping2["f i:"]  = { "f o i" }
    mapping2["g I"]   = { "k 7 i" }
    mapping2["g I@"]  = { "k 7 i @`" }
    mapping2["g O:"]  = { "k uo" }
    mapping2["g O@"]  = { "k uo @`" }
    mapping2["g OI"]  = { "k uo i" }
    mapping2["g i:"]  = { "k 7 i" }
    mapping2["gh I"]  = { "k 7 i" }
    mapping2["gh I@"] = { "k 7 i @`" }
    mapping2["gh O:"] = { "k uo" }
    mapping2["gh O@"] = { "k uo @`" }
    mapping2["gh OI"] = { "k uo i" }
    mapping2["gh i:"] = { "k 7 i" }
    mapping2["h I"]   = { "x 7 i" }
    mapping2["h I@"]  = { "x 7 i @`" }
    mapping2["h O:"]  = { "x uo" }
    mapping2["h O@"]  = { "x uo @`" }
    mapping2["h OI"]  = { "x uo i" }
    mapping2["h i:"]  = { "x 7 i" }
    mapping2["k I"]   = { "k_h 7 i" }
    mapping2["k I@"]  = { "k_h 7 i @`" }
    mapping2["k O:"]  = { "k_h uo" }
    mapping2["k O@"]  = { "k_h uo @`" }
    mapping2["k OI"]  = { "k_h uo i" }
    mapping2["k i:"]  = { "k_h 7 i" }
    mapping2["kh I"]  = { "k_h 7 i @`" }
    mapping2["kh O:"] = { "k_h uo" }
    mapping2["kh O@"] = { "k_h uo @`" }
    mapping2["kh OI"] = { "k_h uo i" }
    mapping2["kh i:"] = { "k_h 7 i" }
    mapping2["m U"]   = { "m u UN" }
    mapping2["p @"]   = { "p_h o 7" }
    mapping2["p U"]   = { "p_h u UN" }
    mapping2["p V"]   = { "p_h a 7" }
    mapping2["ph @"]  = { "p_h o 7" }
    mapping2["ph U"]  = { "p_h u UN" }
    mapping2["ph V"]  = { "p_h a 7" }
    mapping2["r I"]   = { "z` i`i" }
    mapping2["r I@"]  = { "z` i`@`" }
    mapping2["r O:"]  = { "z`uo" }
    mapping2["r O@"]  = { "z` uo @`" }
    mapping2["r OI"]  = { "z` uo i" }
    mapping2["r aI"]  = { "z`uaI" }
    mapping2["r e"]   = { "z` uei" }
    mapping2["r e@"]  = { "z`uei @`" }
    mapping2["r eI"]  = { "z`uei" }
    mapping2["r i:"]  = { "z` i`i" }
    mapping2["r {"]   = { "z` ua" }
    mapping2["s I"]   = { "s i\\ i" }
    mapping2["s O:"]  = { "s uo" }
    mapping2["s O@"]  = { "s uo @`" }
    mapping2["s OI"]  = { "s uo i" }
    mapping2["s i:"]  = { "s i\\ i" }
    mapping2["t I@"]  = { "s\\ i @`" }
    mapping2["t O:"]  = { "t_h uo" }
    mapping2["t O@"]  = { "t_h uo @`" }
    mapping2["t OI"]  = { "t_h uo i" }
    mapping2["tS I"]  = { "ts\\_h i" }
    mapping2["tS I@"] = { "ts\\_h i @`" }
    mapping2["tS O:"] = { "ts`_h uo" }
    mapping2["tS O@"] = { "ts`_h uo @`" }
    mapping2["tS OI"] = { "ts`_h uo i" }
    mapping2["tS e"]  = { "ts`_h 7" }
    mapping2["tS e@"] = { "ts`_h uei @`" }
    mapping2["tS eI"] = { "ts`_h uei" }
    mapping2["tS i:"] = { "ts\\_h i" }
    mapping2["th O:"] = { "t_h uo" }
    mapping2["th O@"] = { "t_h uo @`" }
    mapping2["th OI"] = { "t_h uo i" }
    mapping2["z I"]   = { "ts i\\ i" }
    mapping2["z I@"]  = { "ts i\\ @`" }
    mapping2["z O:"]  = { "ts uo" }
    mapping2["z O@"]  = { "ts uo @`" }
    mapping2["z OI"]  = { "ts uo i" }
    mapping2["z i:"]  = { "ts i\\ i" }

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
