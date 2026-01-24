return function(lyrics, idx, _)
    local lyricList, phonemeList = {}, {}
    if idx == 7 then idx = 4 end
    local rules = {
        { "([aeiou])x([aeiou])", "%1ks%2" },{ "([a-zñüç])", "%1 " },{ "x", "s" },{ "g e", "x e" },{ "g i", "x i" },
        { "g u e", "g e" },{ "g u i", "g i" },{ "q u e", "k e" },{ "q u i", "k i" },{ "ç", "T" },
        { "c e", "T e" },{ "c i", "T i" },{ "c ([^h])", "k %1" },{ "c h", "tS" },{ "j", "x" },
        { "h", "" },{ "l l", "L" },{ "ñ", "J" },{ "r r", "rr" },{ "([ nls]) r", "%1 rr" },
        { "v", "b" },{ "ü", "w" },{ "i ([aeou])", "j %1" },{ "u ([aeio])", "w %1" },{ "z", "T" },
        { "y", "jj" },{ "q", "k" }
    }
    local dipthong = {
        [1]={ --Japanese
            ["([ktm4gdbp]) j"] = "%1'",["n j"] = "J",["h j"] = "C",["p\\ j"] = "p\\'",
            ["([ktm4gdbp]) i"] = "%1' i",["n i"] = "J i",["h i"] = "C i",["p\\ i"] = "p\\' i"
        },
        [2]={["{ i:"]="aI",["e i:"]="eI",["O: i:"]="OI",["{ u:"]="aU",["e u:"]="@U",["O: u:"]="@U"}, --English
        [3]={["j ([aeou])"] = "j%1",["w ([ei])"] = "u%1",["w a"] = "oa",["w o"] = "u7"}, --Korean
        [4]={["j ([aeou])"] = "j%1",["w ([ei])"] = "u%1",["w a"] = "oa",["w o"] = "u7"}, --SeeU
        [5]={ --Chinese
            ["j a"]="ia",["j ei"]="iE_r",["j @U"]="iAU",["j u"]="i@U",
            ["w a"]="ua",["w ei"]="uei",["w i"]="u i",["w @U"]="uo",
            ["a i"]="aI",["ei i"]="ei",["a u"]="AU",["ei u"]="@U",["@U u"]="@U",
            ["w a i"]="uaI",["w ei i"]="uei",["i a u"]="iAU",["i e u"]="i@U",["i @U u"]="i@U"}
    }[idx]
    local dict = { -- Japanese,English,Korean,SeeU,Chinese
        a={"a","{","a","a","a"},b={"b","b","b","b","p"},d={"d","d","d","d","t"},e={"e","e","e","e","ei"},f={"p\\","f","h","f","f"},
        g={"g","g","g","g","k"},i={"i","i:","i","i","i"},j={"j","j","j","j","j"},k={"k","k","k","k","k_h"},l={"4","l0","l","l","l"},
        m={"m","m","m","m","m"},n={"n","n","n","n","n"},J={"J","n j","n j","n j","n j"},o={"o","O:","o","o","@U"},p={"p","p","p","p","p_h"},
        r={"4","r","r","r","l"},s={"s","s","s","s","s"},t={"t","t","t","t","t_h"},T={"ts","T","s","s","ts"},tS={"tS","tS","c","c","ts`"},
        u={"M","u:","u","u","u"},w={"w","w","w","w","w"},x={"h","h","h","h","x"},L={"j","j","j","j","j"},jj={"j","j","j","j","j"},rr={"4","r","r","r","l"},
    }
    lyrics=lyrics:gsub("[ÁÉÍÓÚÑÜÇ]", {["Á"] = "á", ["É"] = "é", ["Í"] = "í", ["Ó"] = "ó", ["Ú"] = "ú",["Ñ"] = "ñ", ["Ü"] = "ü", ["Ç"] = "ç"}):lower()
    for word in lyrics:gmatch("[a-záéíóúñüç%-]+") do
        if word == "-" then table.insert(lyricList, "-"); table.insert(phonemeList, "-")
        else
            local len, pos = #word, 1
            while pos <= len do
                local start, lastCon = pos, nil
                while pos <= len and not "aeiouáéíóúü":find(word:sub(pos,pos), 1, true) and word:sub(pos,pos) ~= "y" do
                    lastCon = word:sub(pos,pos); pos = pos + 1
                end
                if pos <= len then
                    local char = word:sub(pos,pos)
                    if char == "u" and lastCon == "q" then pos = pos + 1
                    elseif char == "u" and lastCon == "g" and pos+1 <= len and "eiéí":find(word:sub(pos+1,pos+1),1,true) then pos = pos + 1
                    elseif char == "ü" and lastCon == "g" then pos = pos + 1 end
                end
                if pos < len and word:sub(pos,pos) == "y" then pos = pos + 1 end
                if pos > len then goto nextSyll end
                local char = word:sub(pos,pos)
                if "aeoáéó":find(char,1,true) then pos = pos + 1
                elseif "iuíúü":find(char,1,true) then pos = pos + 1 end
                local hasH = pos <= len and word:sub(pos,pos) == "h"
                if hasH then pos = pos + 1 end
                if pos <= len then
                    char = word:sub(pos,pos)
                    if "aeoáéó":find(char,1,true) then
                        if "aeoáéó":find(word:sub(pos-1,pos-1),1,true) then pos = hasH and pos-1 or pos; goto endNuc
                        else pos = pos + 1 end
                    elseif "iuíúü":find(char,1,true) then
                        if pos < len-1 and "aeiouáéíóúü":find(word:sub(pos+1,pos+1),1,true) then
                            pos = word:sub(pos-1,pos-1)=="h" and pos-1 or pos; goto endNuc
                        end
                        pos = (char ~= word:sub(pos-1,pos-1)) and pos+1 or pos; goto endNuc
                    end
                end
                if pos <= len and "iu":find(word:sub(pos,pos),1,true) then pos = pos + 1 end
                ::endNuc::
                if pos >= len or "aeiouáéíóúü":find(word:sub(pos,pos),1,true) then goto nextSyll end
                if pos == len-1 then pos = pos + 1; goto nextSyll end
                local char2 = word:sub(pos+1,pos+1)
                if "aeiouáéíóúü":find(char2,1,true) then goto nextSyll end
                local char1 = word:sub(pos,pos)
                if pos < len-2 then
                    local char3 = word:sub(pos+2,pos+2)
                    if not "aeiouáéíóúü":find(char3,1,true) then
                        if pos+3 == len then
                            pos = (char2=="y" and "slrnc":find(char1,1,true)) and pos or (char3=="y" and pos+1 or pos+3); goto nextSyll
                        end
                        if char2 == "y" then pos = "slrnc":find(char1,1,true) and pos or pos+1; goto nextSyll end
                        if "pt ct cn ps mn gn ft pn cz tz ts":find(char2..char3,1,true) then pos = pos+1; goto nextSyll end
                        pos = ("lr":find(char3,1,true) or (char2=='c' and char3=='h') or char3=="y") and pos+1 or pos+2; goto nextSyll
                    else
                        if ("ll ch rr"):find(char1..char2,1,true) or (char1~="sr" and char2=="h") then goto nextSyll end
                        if char2 == "y" then pos = "slrnc":find(char1,1,true) and pos or pos+1; goto nextSyll end
                        if "bvckfgpt":find(char1,1,true) and "lr":find(char2,1,true) then goto nextSyll end
                        pos = pos + 1; goto nextSyll
                    end
                else
                    pos = char2 == "y" and pos or pos+2; goto nextSyll
                end
                ::nextSyll::
                local syllable = word:sub(start, pos - 1)
                table.insert(lyricList, syllable)
                local result=syllable:gsub("[áéíóú]",{["á"] = "a", ["é"] = "e", ["í"] = "i", ["ó"] = "o", ["ú"] = "u"})
                for _, rule in ipairs(rules) do result = result:gsub(rule[1], rule[2]) end
                result = result:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""):gsub("%S+", function(phoneme) return dict[phoneme][idx] or (idx == 2 and "u:" or "a") end)
                for p, r in pairs(dipthong) do result = result:gsub(p, r) end
                table.insert(phonemeList,result)
            end
        end
    end
    return lyricList, phonemeList
end