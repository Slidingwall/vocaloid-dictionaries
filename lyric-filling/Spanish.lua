return function(lyrics, idx, _)
    local strong = {a=true, e=true, o=true, ["á"]=true, ["é"]=true, ["ó"]=true}
    local vowels = setmetatable({i=true, u=true, ["í"]=true, ["ú"]=true, ["ü"]=true},{__index = strong})
    local voiced = {b=true, v=true, g=true, p=true, d=true, c=true, k=true, f=true, t=true}
    local consonants = setmetatable({h=true, j=true, l=true, m=true, n=true, q=true, r=true, s=true, w=true, x=true, y=true, z=true},{__index = voiced})
    local clusters = {pt=true, ct=true, cn=true, ps=true, mn=true, gn=true, ft=true, pn=true, cz=true, tz=true, ts=true}
    local special = {s=true, l=true, r=true, n=true, c=true}
    local replace = {["á"] = "a", ["é"] = "e", ["í"] = "i", ["ó"] = "o", ["ú"] = "u"}
    local lyricList, phonemeList = {}, {}
    local def = idx == 2 and "u:" or "a"
    if idx == 7 then idx = 4 end
    local rules = {
        { "([aeiou])x([aeiou])", "%1ks%2" },
        { "([a-zñü])", "%1 " },
        { "x", "s" },
        { "g e", "x e" },
        { "g i", "x i" },
        { "g u e", "g e" },
        { "g u i", "g i" },
        { "q u e", "k e" },
        { "q u i", "k i" },
        { "c e", "T e" },
        { "c i", "T i" },
        { "c ([^h])", "k %1" },
        { "c h", "tS" },
        { "j", "x" },
        { "h", "" },
        { "l l", "L" },
        { "ñ", "J" },
        { "r r", "rr" },
        { "([ nls]) r", "%1 rr" },
        { "v", "b" },
        { "ü", "w" },
        { "i ([aeou])", "j %1" },
        { "u ([aeio])", "w %1" },
        { "z", "T" },  
        { "y", "jj" }, 
        { "q", "k" }
    }
    local dipthong = {
        [1]={["k j"]="k'",["t j"]="t'",["n j"]="J",["h j"]="C",
            ["m j"]="m'",["4 j"]="4'",["g j"]="g'",["d j"]="d'",
            ["b j"]="b'",["p j"]="p'",["p\\ j"]="p\\'",
            ["k i"]="k' i",["t i"]="t' i",["n i"]="J i",["h i"]="C i",
            ["m i"]="m' i",["4 i"]="4' i",["g i"]="g' i",["d i"]="d' i",
            ["b i"]="b' i",["p i"]="p' i",["p\\ i"]="p\\' i"},
        [2]={["{ i:"]="aI",["e i:"]="eI",["O: i:"]="OI",["{ u:"]="aU",["e u:"]="@U",["O: u:"]="@U"},
        [3]={["j a"]="ja",["j e"]="je",["j o"]="jo",["j u"]="ju",["w a"]="oa",["w e"]="ue",["w i"]="ui",["w o"]="u7"},
        [5]={
            ["j a"]="ia",["j ei"]="iE_r",["j @U"]="iAU",["j u"]="i@U",
            ["w a"]="ua",["w ei"]="uei",["w i"]="u i",["w @U"]="uo",
            ["a i"]="aI",["ei i"]="ei",["a u"]="AU",["ei u"]="@U",["@U u"]="@U",
            ["w a i"]="uaI",["w ei i"]="uei",["i a u"]="iAU",["i eu u"]="i@U",["i @U u"]="i@U"}
    }
    dipthong[4]=dipthong[3]
    local dict = { -- Japanese,English,Korean,SeeU,Chinese
        a={"a","{","a","a","a"},
        b={"b","b","b","b","p"},
        d={"d","d","d","d","t"},
        e={"e","e","e","e","ei"},
        f={"p\\","f","h","f","f"},
        g={"g","g","g","g","k"},
        i={"i","i:","i","i","i"},
        j={"j","j","j","j","j"},
        k={"k","k","k","k","k_h"},
        l={"4","l0","l","l","l"},
        m={"m","m","m","m","m"},
        n={"n","n","n","n","n"},
        J={"J","n j","n j","n j","n j"},
        o={"o","O:","o","o","@U"},
        p={"p","p","p","p","p_h"},
        r={"4","r","r","r","l"},
        s={"s","s","s","s","s"},
        t={"t","t","t","t","t_h"},
        T={"ts","T","s","s","ts"},
        tS={"tS","tS","c","c","ts`"},
        u={"M","u:","u","u","u"},
        w={"w","w","w","w","w"},
        x={"h","h","h","h","x"}
    }
    dict=setmetatable(dict,{__index={
        L=dict.j,jj=dict.j,rr=dict.r
    }})
    for word in lyrics:gmatch("[a-záéíóúñüç%-]+") do
        if word == "-" then
            table.insert(lyricList, "-")
            table.insert(phonemeList, "-")
        else
            local pos = 1
            while pos <= #word do
                local syllableStart = pos
                local lastConsonant = ""
                while pos <= #word and consonants[word:sub(pos, pos)] and word:sub(pos, pos) ~= "y" do
                    lastConsonant = word:sub(pos, pos)
                    pos = pos + 1
                end
                if pos <= #word - 1 then
                    if word:sub(pos, pos) == "u" then
                        if lastConsonant == "q" or (lastConsonant == "g" and (word:sub(pos+1, pos+1) == "e" or word:sub(pos+1, pos+1) == "é" or word:sub(pos+1, pos+1) == "i" or word:sub(pos+1, pos+1) == "í")) then
                            pos = pos + 1
                        end
                    elseif word:sub(pos, pos) == "ü" and lastConsonant == "g" then
                        pos = pos + 1
                    end
                end
                if pos <= #word and vowels[word:sub(pos, pos)] then
                    local isStrong = strong[word:sub(pos, pos)]
                    pos = pos + 1
                    if pos <= #word and word:sub(pos, pos) == "h" then
                        pos = pos + 1
                    end
                    if pos <= #word and vowels[word:sub(pos, pos)] then
                        local nextIsStrong = strong[word:sub(pos, pos)]
                        if nextIsStrong and isStrong then break else pos = pos + 1 end
                    end
                    if pos <= #word and (word:sub(pos, pos) == "i" or word:sub(pos, pos) == "u") then
                        pos = pos + 1
                    end
                end
                if pos <= #word and consonants[word:sub(pos, pos)] then
                    if pos == #word then
                        pos = pos + 1
                    elseif not consonants[word:sub(pos+1, pos+1)] then
                        break
                    else
                        local c1, c2 = word:sub(pos, pos), word:sub(pos+1, pos+1)
                        if pos < #word - 2 then
                            local c3 = word:sub(pos+2, pos+2)
                            if not vowels[c3] then
                                pos = pos + (pos + 3 == #word + 1 and (c2 == "y" and (special[c1] and 0 or 1) or 3) or (c2 == "y" and (special[c1] and 0 or 1) or (clusters[c2..c3] and 1 or 2)))
                            else
                                local paic1..c2
                                pos = pos + ((pair == "ll" or pair == "ch" or pair == "rr" or (c2 == "h" and not (c1 == "s" or c1 == "r")) or (c2 == "y" and special[c1]) or (voiced[c1] and (c2 == "l" or c2 == "r"))) and 0 or 1)
                            end
                        else
                            pos = pos + 2
                        end
                    end
                end
                table.insert(lyricList, word:sub(syllableStart, pos - 1))
                result=word:sub(syllableStart, pos - 1):gsub("[áéíóú]",replace)
                for _, rule in ipairs(rules) do
                    result = result:gsub(rule[1], rule[2])
                end
                result = result:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""):gsub("%S+", function(phoneme) return dict[phoneme][idx] end)
                for p, r in pairs(dipthong[idx]) do result = result:gsub(p, r) end
                table.insert(phonemeList,result)
            end
        end
    end
    return lyricList, phonemeList
end