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
    note.phonemes = newPhonemes
    note.phLock = 1
    local ret = VSupdateEx(note)
    return ret == 1
end

function main(processParam, envParam)    
    
    VSDlgSetDialogTitle("Convert Phonemes 替换音素")
    VSDlgAddField({
        name = "find",
        caption = "From 查找",
        initialVal = "a",
        type = 3
    })
    VSDlgAddField({
        name = "replace",
        caption = "To 替换",
        initialVal = "i",
        type = 3
    })
    VSDlgAddField({
        name = "match",
        caption = "Perfect Match 完全匹配",
        initialVal = 0,
        type = 1
    })
    dlgRet = VSDlgDoModal()
    if dlgRet == 2 then return 0 end
    if dlgRet ~= 1 then return 1 end
    end

    _, find  = VSDlgGetStringValue("find")
    _, replace    = VSDlgGetStringValue("replace")
    _, match    = VSDlgGetBoolValue("match")

    VSSeekToBeginNote()
    local notes = {}
    local ret, note = VSGetNextNoteEx()
    while ret == 1 do
        table.insert(notes, note)
        ret, note = VSGetNextNoteEx()
    end
    if #notes == 0 then
        VSMessageBox("No notes to process!", 0)
        return 0
    end

    local convCount = 0
    local status = 0

    for _, note in ipairs(notes) do
        local updated = false
        if match == 0 then
        local newPhonemes, replaceCount = string.gsub(note.phonemes, find, replace)
            if replaceCount > 0 then
                updated = update(note, newPhonemes)
            end
        else
        elseif note.phonemes == find then
                updated = update(note, replace)
            end
        end
        if updated then
            convCount = convCount + 1
        else
            status = 1
            break
        end
    end
    VSMessageBox("Converted " .. convCount .. " note(s)", 0)
    return status
end