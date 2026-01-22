return function(lyrics, idx, f)
    local lyricList, cacheList={}, phonemeList = {}, {}
    local def = idx == 2 and "u:" or "a"
    if idx == 6 then idx = 3 end
    local initials = {"g", "gg", "n", "d", "dd", "r", "m", "b", "bb", "s", "ss", "0", "j", "jj", "ch", "k", "t", "p", "h"}
    local medials = {"a", "ae", "ya", "yae", "eo", "e", "yeo", "ye", "o", "wa", "wae", "oe", "yo", "u", "wo", "we", "wi", "yu", "eu", "ui", "i"}
    local finals = {"", "g", "gg", {"g", "s"}, "n", {"n", "j"}, {"n", "h"}, "d", "l", {"r", "g"}, {"r", "m"}, {"r", "b"}, {"r", "s"}, {"r", "t"}, {"r", "p"}, {"r", "h"}, "m", "b", {"b", "s"}, "s", "ss", "ng", "j", "ch", "k", "t", "p", "h"}
    local voiceless = {g="k",d="t",b="p",j="ch"}
    local toTense = {s="ss",g="gg",d="dd",b="bb",j="jj"}
    local doubleTense = {s=true,t=true}
    local doubleSecond = setmetatable({j=true,h=true,m=true,p=true,b=true},{__index=doubleTense})
    local tFinals = setmetatable({ss=true,j=true,ch=true,d=true},{__index=doubleTense})
    local tensingNext = setmetatable({g=true,bb=true,jj=true,dd=true,gg=true,k=true,p=true},{__index=tFinals})
    local doubleFirst = {g=true,n=true,r=true,b=true}
    local consonants = {s=true,ss=true,j=true,jj=true,ch=true,d=true,g=true,gg=true,k=true,m=true,n=true,r=true,h=true}
    if f == 0 then
        for v in lyrics:gmatch("%S+") do
            if v == "-" then lyricList[#lyricList+1] = v ; cacheList[#cacheList+1] = {v}
            elseif v:find("^[a-z]+$") then
            lyricList[#lyricList+1] = v 
            local initial, medial, final = v:match("^([^aeiouwy]*)([aeiouwy]+)([^aeiouwy]*)$")
            cacheList[#cacheList+1] = {initial, medial, final}
            end
        end
    else
        for i = 1, #lyrics do
            local v = lyrics:sub(i, i)
            if v ~= " " then
                if v == "-" then lyricList[#lyricList+1] = v ; phonemeList[#phonemeList+1] = {v}
                elseif v:find("^[\uac00-\ud7af]$") then
                lyricList[#lyricList+1] = v
                local u = v:byte(1, -1) - 0xAC00
                local initial, medial, final = initials[math.floor(u / 588) + 1], medials[math.floor(u / 28) % 21 + 1], finals[u % 28 + 1]
                cacheList[#cacheList+1] = {initial, medial, final}
                end
            end
        end
    end

    

    return lyricList, phonemeList
end