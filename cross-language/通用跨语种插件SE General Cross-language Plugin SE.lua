function manifest()
    myManifest = {
        name = "通用跨语种插件SE General Cross-language Plugin Second Edition",
        comment = "可自定义跨语种表并选择执行 Allows Customization Dictionaries and Selection for Execution.",
        author = "Slidingwall based on VoctroLabs and 白糖の正义铃 B站ID:180668218",
        pluginID = "{03B591E7-A4C5-421D-9715-110709F933C1}",
        pluginVersion = "2.0.0.0",
        apiVersion = "3.0.0.1"
    }
    return myManifest
end

function comp(idx)
    local rules={
        { --Japanese
            ["t s"] = "ts", ["w M"] = "M", ["j i"] = "i",["h j"] = "C", ["h\\ j"] = "C", 
            ["h i"] = "C i", ["h\\ i"] = "C i", ["p\\ j"] = "p\\'", ["p\\ i"] = "p\\' i",
            ["([kgtdbm4]) j"] = "%1'", ["([kgtdbm4]) i"] = "%1' i",
            ["s j"] = "S", ["z j"] = "Z", ["dz j"] = "dZ", ["ts j"] = "tS", ["n j"] = "J",
            ["s i"] = "S i", ["z i"] = "Z i", ["dz i"] = "dZ i", ["ts i"] = "tS i", ["n i"] = "J i"
        },
        nil, --English
        { --Korean
            ["j i"] = "i", ["w a"] = "oa", ["M i"] = "Mi",
            ["w ([ouM])"] = "%1", ["w ([7ei])"] = "u%1",
            ["j ([a7eou])"] = "j%1", ["sh ([a7eou])"] = "sh j%1", ["s j([a7eou])"] = "sh j%1"
        },
        { ["g j i"]="g i", ["g j"]="G j", ["j i"]="i", ["w u"]="u" }, --Spanish
        { --Chinese
            ["([aiy]) n"] = "%1_%2",["w a ([iI])"] = "uai",["w e ?i"] = "uei",["j ([ae]) n"] = "iE_n",["y ([ae]) n"] = "y{_n",
            ["a i"] = "aI",["e i"] = "ei",["a u"] = "AU",["e u"] = "@U",["j a"] = "ia",["w a"] = "ua",["j e"] = "iE_r",["y e"] = "yE_r",["w o"] = "uo",
            ["j a u"] = "iAU",["j e u"] = "i@U",["j AU"] = "iAU",["j @U"] = "i@U",["a N"] = "AN",["e n"] = "@_n",["e N"] = "@N",["i N"] = "iN",
            ["j a N"] = "iAN",["w a n"] = "ua_n",["w a N"] = "uAN",["w e n"] = "u@_n",["w e N"] = "u@N",["iE_r n"] = "iE_n",["ia N"] = "iAN",["iAU N"] = "iAN",
            ["ua n"] = "ua_n",["ua N"] = "uAN",["uei n"] = "u@_n",["uei N"] = "u@N",["u N"] = "UN",["j u N"] = "iUN",["yE_r n"] = "y{_n",["i@U N"] = "iUN"
        }
    }
    return rules[idx]
end

function split(str, delim)  
    local result = {}  
    for word in string.gmatch(str, '[^' .. delim .. ']+') do  
        table.insert(result, word)  
    end  
    return result  
end

--function splitNote(str,phn,dictphn)  
--    local splited = split(string.gsub(str, phn, dictphn),"#")
--    return splited[1],splited[2]  
--end

function copyNoteEx(src)
    local new = {}
    for key, value in pairs(src) do
        new[key] = value
    end
    return new
end

function main(processParam, envParam)    
    VSSeekToBeginNote()
    local notes = {}
    local ret, note = VSGetNextNoteEx()
    while ret == 1 do
        table.insert(notes, note)
        ret, note = VSGetNextNoteEx()
    end
    if #notes == 0 then
        VSMessageBox("你需要选择一个音符 No notes to process!", 0)
        return 0
    end

    VSDlgSetDialogTitle("通用跨语种插件 General Cross-language Plugin")
    local cfg={{"Japanese","English,Korean,Spanish,Chinese,Korean(SeeU),Spanish(Maika)"},{"English","Japanese,Korean,Spanish,Chinese,Korean(SeeU),Spanish(Maika)"},{"Korean","Japanese,English,Spanish,Chinese,Spanish(Maika)"},{"Spanish","Japanese,English,Korean,Chinese,Korean(SeeU)"},{"Chinese","Japanese,English,Korean,Spanish,Korean(SeeU),Spanish(Maika)"}}
    local idx = (select(2, VSGetMusicalPartSinger())).vBS + 1

    VSDlgAddField{name="singer", caption="源语言（自动） Original Language(Auto)", initialVal=cfg[idx][1], type=3}
    VSDlgAddField{name="language", caption="目标语言 Target Language", initialVal=cfg[idx][2], type=4}
    local dlgRet = VSDlgDoModal()
    if dlgRet ~= 1 then return (dlgRet == 2 and 0) or 1 end
    
    local langTable={Japanese=1,English=2,Korean=3,Spanish=4,Chinese=5,["Korean(SeeU)"]=function(idx) return idx == 4 and 4 or 6 end,["Spanish(Maika)"]=idx}
    local lang = langTable[select(2, VSDlgGetStringValue("language"))]
    if type(lang) == "function" then lang = lang(idx) end
    local dicts = require("dict")(idx,lang) 
    local rules = comp(idx)

    for _, updNoteEx in ipairs(notes) do
--        local splphn, updphn
--        local splitflag = 0
        local phns = split(updNoteEx.phonemes, " ")
        
        for i = 1, #phns do
            if dicts[phns[i]] then
                phns[i] = dicts[phns[i]]
            end
        end
        
--        if splitflag == 0 then
            updNoteEx.phonemes = table.concat(phns, " ")
            if rules then 
                for find,replace in pairs(rules) do
                    local newPhonemes, replaceCount = string.gsub(updNoteEx.phonemes, find, replace)
                    if replaceCount > 0 then updNoteEx.phonemes = newPhonemes end
                end
            end
            updNoteEx.phLock = 1
            ret = VSUpdateNoteEx(updNoteEx)
--        elseif splitflag == 1 then
--            local splNoteEx=copyNoteEx(updNoteEx)
--            updNoteEx.phonemes = updphn
--            updNoteEx.phLock = 1
--            updNoteEx.posTick = splNoteEx.posTick + 30
--            updNoteEx.durTick = splNoteEx.durTick - 30
--            splNoteEx.phonemes = splphn
--            splNoteEx.phLock = 1
--            splNoteEx.durTick = 30
--            ret = VSUpdateNoteEx(updNoteEx) and VSInsertNoteEx(splNoteEx)
--        elseif splitflag == 2 then
--            local splNoteEx=copyNoteEx(updNoteEx)
--            updNoteEx.phonemes = updphn
--            updNoteEx.phLock = 1
--            updNoteEx.durTick = splNoteEx.durTick - 30
--            splNoteEx.phonemes = splphn
--            splNoteEx.phLock = 1
--            splNoteEx.posTick = updNoteEx.posTick + updNoteEx.durTick
--            splNoteEx.durTick = 30
--            ret = VSUpdateNoteEx(updNoteEx) and VSInsertNoteEx(splNoteEx)
--        end
        if (ret ~= 1) then
            VSMessageBox("Failed to update note!", 0)
            return 1
        end
    end
    
    return 0
end