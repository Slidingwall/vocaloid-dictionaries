function manifest()
    myManifest = {
        name = "通用跨语种插件 General Cross-language Plugin",
        comment = "可自定义跨语种表并选择执行 Allows Customization Dictionaries and Selection for Execution.",
        author = "Slidingwall based on VoctroLabs and 白糖の正义铃 B站ID:180668218",
        pluginID = "{03B591E7-A4C5-421D-9715-110709F933C1}",
        pluginVersion = "1.2.0.0",
        apiVersion = "3.0.0.1"
    }
    return myManifest
end

function split(str, delimiter)  
    local result = {}  
    string.gsub(str, '[^' .. delimiter .. ']+', function(w) table.insert(result, w) end)  
    return result  
end

function loadDicts(file)
    local dicts = {  
        mp1 = {},  
        mp2 = {},  
        mp3 = {},  
        l2 = {},  
        r2 = {},  
        l3 = {},  
        r3 = {}  
    }
    local prefixToDict = {  
        "1" = dicts.mp1,  
        "2" = dicts.mp2,  
        "3" = dicts.mp3,  
        "L2" = dicts.l2,  
        "R2" = dicts.r2,  
        "L3" = dicts.l3,  
        "R3" = dicts.r3  
    } 
    for line in io.lines(file) do  
        local lineData = split(line,",")
        if prefixToDict[lineData[1]] then  
            local dict = prefixToDict[lineData[1]]  
            dict[lineData[2]] = lineData[3]
        end    
    end  

    return   dicts
end  

function splitNote(str,phn,dictphn)  
    local splited = split(string.gsub(str, phn, dictphn),"#")
    return splited[1],splited[2]  
end

function copyNoteEx(src)
    local new = {}
    --Normal Note Properties
    new.posTick = src.posTick
    new.durTick = src.durTick
    new.noteNum = src.noteNum
    new.velocity = src.velocity
    new.phonemes = src.phonemes
    new.lyric = src.lyric
    --Extended Note Properties
    new.bendDepth = src.bendDepth
    new.bendLength = src.bendLength
    new.risePort = src.risePort
    new.fallPort = src.fallPort
    new.decay = src.decay
    new.accent = src.accent
    new.opening = src.opening
    new.vibratoLength = src.vibratoLength
    new.vibratoType = src.vibratoType
    return new
end

function main(processParam, envParam)
    local beginPosTick = processParam.beginPosTick
    local endPosTick = processParam.endPosTick
    local songPosTick = processParam.songPosTick
    
    local scriptDir = envParam.scriptDir
    local scriptName = envParam.scriptName
    local tempDir = envParam.tempDir
    
    local noteEx = {}
    local noteExList = {}
    local noteCount
    local retCode
    local idx
    
    os.execute("CMD /C dir dict /on/b> dictlist.txt")

    local table_file = ""
    for line in io.lines("dictlist.txt") do
        if string.find(line, ".txt") then
            table_file = table_file .. "," .. line
        end
    end
    
    VSDlgSetDialogTitle("通用跨语种插件 General Cross-language Plugin")
    local dlgStatus
    local field = {}
    field.name = "table"
    field.caption = "选择跨语种表 Select Dictionaries\n文件名需为非中文 File name should be English."
    field.initialVal = table_file
    field.type = 4
    dlgStatus = VSDlgAddField(field)
    dlgStatus = VSDlgDoModal()
    if (dlgStatus == 2) then
        return 0
    end
    if ((dlgStatus ~= 1) and (dlgStatus ~= 2)) then
        return 1
    end
    
    local r, chosen_table = VSDlgGetStringValue("table")
    
    local dicts = loadDicts("dict/" .. chosen_table)
    
    VSSeekToBeginNote()
    idx = 1
    retCode, noteEx = VSGetNextNoteEx()
    while (retCode == 1) do
        noteExList[idx] = noteEx
        retCode, noteEx = VSGetNextNoteEx()
        idx = idx + 1
    end
    
    noteCount = #noteExList
    if (noteCount == 0) then
        VSMessageBox("No notes to process!", 0)
        return 0
    end
    
    for idx = 1, noteCount do
        local updNoteEx = noteExList[idx]
        local splNoteEx=copyNoteEx(updNoteEx)
        local phns = {}
        local splphn
        local updphn
        local splitflag = 0
        for token in string.gmatch(updNoteEx.phonemes, "[^%s]+") do
            table.insert(phns, token)
        end
        
        for i = 1, #phns do
            local mapped = false
            if i + 2 <= #phns then
                threephn = phns[i] .. " " .. phns[i + 1] .. " " .. phns[i + 2]
                if dicts.l3[threephn] then
                    splphn,updphn=splitNote(updNoteEx.phonemes,threephn,dicts.l3[threephn]) 
                    splitflag = 1
                    mapped = true
                end
                if not mapped and dicts.r3[threephn] then
                    updphn,splphn=splitNote(updNoteEx.phonemes,threephn,dicts.r3[threephn]) 
                    splitflag = 2
                    mapped = true
                end
                if not mapped and dicts.mp3[threephn] then
                    phns[i] = dicts.mp3[threephn]
                    phns[i + 1] = ""
                    phns[i + 2] = ""
                    mapped = true
                end
            end

            if not mapped and i + 1 <= #phns then
                twophn = phns[i] .. " " .. phns[i + 1] 
                if dicts.l2[twophn] then
                    splphn,updphn=splitNote(updNoteEx.phonemes,twophn,dicts.l2[twophn]) 
                    splitflag = 1
                    mapped = true
                end
                if not mapped and dicts.r2[twophn] then
                    updphn,splphn=splitNote(updNoteEx.phonemes,twophn,dicts.r2[twophn])
                    splitflag = 2
                    mapped = true
                end
                if not mapped and dicts.mp2[twophn] then
                    phns[i] = dicts.mp2[twophn]
                    phns[i + 1] = ""
                    mapped = true
                end
            end

            if not mapped and dicts.mp1[phns[i]] then
                phns[i] = dicts.mp1[phns[i]]
            end
        end
        
        if splitflag == 0 then
            updNoteEx.phonemes = table.concat(phns, " ")
            updNoteEx.phLock = 1
            retCode = VSUpdateNoteEx(updNoteEx)
        elseif splitflag == 1 then
            updNoteEx.phonemes = updphn
            updNoteEx.phLock = 1
            updNoteEx.posTick = splNoteEx.posTick + 30
            updNoteEx.durTick = splNoteEx.durTick - 30
            splNoteEx.phonemes = splphn
            splNoteEx.phLock = 1
            splNoteEx.durTick = 30
            retCode = VSUpdateNoteEx(updNoteEx) and VSInsertNoteEx(splNoteEx)
        elseif splitflag == 2 then
            updNoteEx.phonemes = updphn
            updNoteEx.phLock = 1
            updNoteEx.durTick = splNoteEx.durTick - 30
            splNoteEx.phonemes = splphn
            splNoteEx.phLock = 1
            splNoteEx.posTick = updNoteEx.posTick + updNoteEx.durTick
            splNoteEx.durTick = 30
            retCode = VSUpdateNoteEx(updNoteEx) and VSInsertNoteEx(splNoteEx)
        end
        if (retCode ~= 1) then
            VSMessageBox("Failed to update note!", 0)
            return 1
        end
    end
    
    return 0
end
