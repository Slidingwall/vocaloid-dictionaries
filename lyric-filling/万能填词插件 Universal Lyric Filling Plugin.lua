function manifest()
    return {
        name = "万能填词插件 Universal Lyric Filling Plugin",
        comment = "根据预先配置好的词典进行音标注入，不受语种限制",
        author = "Slidingwall based on 白糖の正义铃",
        pluginID = "{03A591E8-A415-421D-97C5-110709F12345}",
        pluginVersion = "1.0.0.1",
        apiVersion = "3.0.0.1"
    }
end

function update(note, lyric, phonemes)
    note.lyric,note.phonemes, note.phLock = lyric, phonemes, 1
    return VSUpdateNoteEx(note)
end

function split(str, delim)  
    local result = {}  
    for word in string.gmatch(str, '[^' .. delim .. ']+') do  
        table.insert(result, word)  
    end  
    return result  
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
    
    VSDlgSetDialogTitle("字典填词插件")
    local cfg = {{"Japanese","Korean,Spanish,Chinese"},{"English","Japanese,Korean,Spanish,Chinese"},{"Korean","Japanese,Spanish,Chinese"},{"Spanish","Japanese,Korean,Chinese"},{"Chinese","Japanese,Korean,Spanish"},{"Spanish(Maika)","Japanese,Korean,Chinese"},{"Korean(SeeU)","Japanese,Spanish,Chinese"}}
    local idx = (select(2, VSGetMusicalPartSinger())).vBS + 1
    if select(2, VSGetMusicalPartSinger()).compID=="BDKFB7S2KTWKYDC5" then idx = 6 end --MAIKA
    if select(2, VSGetMusicalPartSinger()).compID=="BX77CNBZLBPHZX97" then idx = 7 end --SeeU

    VSDlgAddField{name="singer", caption="歌手语言（自动） Singer Language(Auto)", initialVal=cfg[idx][1], type=3}
    VSDlgAddField{name="number", caption="最大数量（自动） Maximum Number(Auto)", initialVal=#notes, type=0}
    VSDlgAddField{name="language", caption="歌词语言 Lyric Language", initialVal=cfg[idx][2], type=4}
    VSDlgAddField{name="lyrics", caption="歌词 Lyrics", initialVal="", type=3}
    VSDlgAddField{name="flag", caption="按字符隔开（CJK） Separate into Characters(CJK)", initialVal=0, type=1}

    local dlgRet = VSDlgDoModal()
    if dlgRet ~= 1 then return (dlgRet == 2 and 0) or 1 end

    local _, language = VSDlgGetStringValue("language")
    local _, lyrics = VSDlgGetStringValue("lyrics")
    local _, flag = VSDlgGetBoolValue("flag")
    lyrics = lyrics:gsub(".", function(c) return c == "-" and " - " or c:lower() end)
    local g2p = require(language)
    local lyricList,phonemeList = g2p(lyrics, idx, flag)
    
    for i, note in ipairs(notes) do
        if i <= #lyricList and 
        note.posTick >= processParam.beginPosTick and 
        note.posTick + note.durTick <= processParam.endPosTick 
        then
            update(note, lyricList[i], phonemeList[i])
        end
    end
    return 0
end
