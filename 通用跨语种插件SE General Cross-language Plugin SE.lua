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

function split(str, delim)  
    local result = {}  
    for word in string.gmatch(str, '[^' .. delim .. ']+') do  
        table.insert(result, word)  
    end  
    return result  
end

function loadDicts(file)
    local dicts = {  
        mp1 = {},  
        mp2 = {},  
        mp3 = {},  
    }
    local prefixToDict = {  
        ["1"] = dicts.mp1,  
        ["2"] = dicts.mp2,  
        ["3"] = dicts.mp3,   
    } 
    for line in io.lines(file) do  
        local lineData = split(line,",")
        if prefixToDict[lineData[1]] then  
            prefixToDict[lineData[1]][lineData[2]] = lineData[3]
        end    
    end  
    return dicts
end  

function splitNote(str,phn,dictphn)  
    local splited = split(string.gsub(str, phn, dictphn),"#")
    return splited[1],splited[2]  
end

function copyNoteEx(src)
    local new = {}
    for key, value in pairs(src) do
        new[key] = value
    end
    return new
end

function main(processParam, envParam)    
    os.execute("CMD /C dir dict /on/b> dictlist.txt")
    local lines = {}
    for line in io.lines("dictlist.txt") do
        if string.find(line, "%.txt$") then
            table.insert(lines, line)
        end
    end
    local table_file = table.concat(lines, ",")
    
    VSDlgSetDialogTitle("通用跨语种插件 General Cross-language Plugin")
    local dlgStatus = VSDlgAddField({
        name = "table",
        caption = "选择跨语种表 Select Dictionaries\n文件名需为非中文 File name should be English.",
        initialVal = table_file,
        type = 4
    })
    dlgStatus = VSDlgDoModal()
    if (dlgStatus == 2) then
        return 0
    elseif ((dlgStatus ~= 1) and (dlgStatus ~= 2)) then
        return 1
    end
    
    local _, chosen_table = VSDlgGetStringValue("table")
    local dicts = loadDicts("dict/" .. chosen_table)
    
    VSSeekToBeginNote()
    local noteExList = {}
    local retCode, noteEx = VSGetNextNoteEx()
    while retCode == 1 do
        table.insert(noteExList, noteEx)
        retCode, noteEx = VSGetNextNoteEx()
    end
    if #noteExList == 0 then
        VSMessageBox("No notes to process!", 0)
        return 0
    end

    for _, updNoteEx in ipairs(noteExList) do
        local splphn, updphn
        local splitflag = 0
        local phns = split(updNoteEx.phonemes, " ")
        
        for i = 1, #phns do
            if i + 2 <= #phns then
                local threephn = table.concat(phns, " ",i,i+2)
                if dicts.mp3[threephn] then
                    phns[i] = dicts.mp3[threephn]
                    phns[i + 1] = ""
                    phns[i + 2] = ""
                end
            elseif i + 1 <= #phns then
                local twophn = table.concat(phns, " ",i,i+1)
                if dicts.mp2[twophn] then
                    phns[i] = dicts.mp2[twophn]
                    phns[i + 1] = ""
                end
            elseif dicts.mp1[phns[i]] then
                phns[i] = dicts.mp1[phns[i]]
            end
        end
        
        local newPhonemes, replaceCount = string.gsub(note.phonemes, find, replace)
            if replaceCount > 0 then
                note.phonemes = newPhonemes
                note.phLock = 1
                retCode = VSUpdateNoteEx(note)
                if (retCode == 0) then
					endStatus = 1
					break
                end
            end

        if splitflag == 0 then
            updNoteEx.phonemes = table.concat(phns, " ")
            updNoteEx.phLock = 1
            retCode = VSUpdateNoteEx(updNoteEx)
        elseif splitflag == 1 then
            local splNoteEx=copyNoteEx(updNoteEx)
            updNoteEx.phonemes = updphn
            updNoteEx.phLock = 1
            updNoteEx.posTick = splNoteEx.posTick + 30
            updNoteEx.durTick = splNoteEx.durTick - 30
            splNoteEx.phonemes = splphn
            splNoteEx.phLock = 1
            splNoteEx.durTick = 30
            retCode = VSUpdateNoteEx(updNoteEx) and VSInsertNoteEx(splNoteEx)
        elseif splitflag == 2 then
            local splNoteEx=copyNoteEx(updNoteEx)
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