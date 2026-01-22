function manifest()
    myManifest = {
        name = "Find & Replace Phonemes 音素查找与替换",
        comment = "替换发音记号",
        author = "Slidingwall based on Yamaha Corporation",
        pluginID = "{6632FDB5-0784-4134-A4FA-AACD30F99D30}",
        pluginVersion = "1.0.0.2",
        apiVersion    = "3.0.1.0"
    }
    return myManifest
end

local function update(note, newPhonemes)
    note.phonemes, note.phLock = newPhonemes, 1
    return VSUpdateNote(note)
end

function main(processParam, envParam)    
    
    VSDlgSetDialogTitle("Convert Phonemes 替换音素")
    VSDlgAddField({name="find", caption="From 查找", initialVal="a", type=3})
    VSDlgAddField({name="replace", caption="To 替换", initialVal="i", type=3})
    VSDlgAddField({name="match", caption="Perfect Match 完全匹配", initialVal=0, type=1})
    dlgRet = VSDlgDoModal()
    if dlgRet ~= 1 then return (dlgRet == 2 and 0) or 1 end

    local _, find = VSDlgGetStringValue("find")
    local _, replace = VSDlgGetStringValue("replace")
    local _, match = VSDlgGetBoolValue("match")

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

    local convCount = 0
    for _, note in ipairs(notes) do
        local newPhonemes = match == 0 and string.gsub(note.phonemes, find, replace) or (note.phonemes == find and replace or note.phonemes)
        if newPhonemes ~= note.phonemes and update(note, newPhonemes) then
            convCount = convCount + 1
        end
    end
    VSMessageBox("Converted " .. convCount .. " note(s)", 0)
    return convCount > 0 and 0 or 1
end