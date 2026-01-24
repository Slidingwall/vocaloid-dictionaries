return function(idx,lang)
    local res={
        { -- idx==1, Japanese(dynamic): Maika,English,Korean,Spanish,Chinese,SeeU
            M={"u","u:","M","u","u","M"},
            N={"N","N","Np","n","N","Np"},
            ["N'"]={"J","N","Np","J","N","Np"},
            S={"S","S","sh","s j","s\\","sh"},
            z={"z","z","c","s","ts","c"},
            dz={"dz","z","c","D s","ts","c"},
            Z={"Z","Z","c","s","ts\\","c"},
            dZ={"dZ","dZ","c","D s","ts\\","c"},
            ts={"ts","t s","ch","t s","ts_h","ch"},
            tS={"tS","tS","ch","tS","ts\\_h","ch"},
            h={"x","h","h","x","x","h"},
            C={"x j","h j","h j","x j","x j","h j"}
        }, 
        { -- idx==2, English(dynamic): Japanese,Maika,Korean,Spanish,Chinese,SeeU
            ["@"]={"a","@","7","a","@`","7"},
            V={"a","@","7","a","AU","7"},
            Q={"a","Q","7","o","AU","7"},
            U={"M","U","M","u","u","M"},
            ["@r"]={"a 4","@ r\\","7 rp","a r","@`","7 rp"},
            eI={"e i","e I","e i","e I","ei","e i"},
            aI={"a i","a I","a i","a I","aI","a i"},
            OI={"o i","O I","o i","o I","o ei","o i"},
            ["@U"]={"e M","@ U","7 M","o U","@U","7 M"},
            aU={"a M","a U","a M","a U","AU","a M"},
            ["I@"]={"i a 4","I0 r\\","i rp","i r","i @`","i rp"},
            ["e@"]={"e a 4","e r\\","e rp","e r","ei @`","e rp"},
            ["U@"]={"u a 4","u r\\","M rp","u r","u @`","M rp"},
            ["O@"]={"o a 4","O r\\","o rp","o r","o @`","o rp"},
            ["Q@"]={"a 4","Q r\\","a rp","a r","a @`","a rp"},
            dZ={"dZ","dZ","c","D s","ts`","c"},
            v={"b","v","b","B","f","v"},
            D={"dz","D","c","D","ts","c"},
            z={"z","z","c","s","ts","c"},
            Z={"Z","Z","c","D s","ts","c"},
            N={"N","N","Np","n","N","Np"},
            r={"4","r\\","r","r","z`","r"},
            l={"4","l","rp","l","@U","rp"},
            tS={"tS","tS","ch","tS","ts`","ch"},
            S={"S","S","sh","s j","s`","sh"},
            h={"h","x","h","x","x","h"},
            R={"4","rr","r","rr","z`","r"}
        }, 
        { -- idx==3, Korean(dynamic): Japanese,English,Maika,Spanish,Chinese
            ["7"]={"a o","V","Q","a o","AU"},
            j7={"j a o","j V","j Q","j a o","iAU"},
            u7={"w a o","w V","w Q","w a o","uo"},
            M={"M","U","u","u","u i\\"},
            rp={"4","l","r","r","l"},
            v={"b","v","v","B","f"},
            ["@r"]={"a r","@r","@ r\\","a r","@`"}
        }, 
        { -- idx==4, Spanish(dynamic): Japanese,English,Korean,SeeU,Chinese
            Q={"o","Q","7","7","AU"},
            B={"b","v","b","v","f"},
            D={"dz","D","c","c","ts"},
            tS={"tS","tS","ch","ch","ts`"},
            S={"S","S","sh","sh","s`"},
            ts={"ts","t s","ch","ch","ts_h"},
            dz={"dz","d z","c","c","ts"},
            dZ={"dZ","dZ","c","c","ts`"},
            z={"z","z","c","c","ts"}
        }, 
        { -- idx==5, Chinese(dynamic): Japanese,English,Korean,Spanish,Maika,SeeU
            ["7"]={"o","V","7","o","O","7"},
            y={"j u","j u:","ui","j u","j u","ui"},
            ["i\\"]={"M","I","M","u","I0","M"},
            aI={"a j","aI","a i","a I","a I","a i"},
            ei={"e j","eI","e i","e I","e I","e i"},
            AU={"a w","aU","a M","a U","Q U","a M"},
            ["@U"]={"o w","@U","7 M","o U","@ U","7 M"},
            ia={"j a","j {","ja","j a","j a","ja"},
            ua={"w a","w {","oa","w a","w a","oa"},
            iE_r={"j e","j e","je","j e","j E","je"},
            yE_r={"j M e","j u: e","ju e","j u e","j u E","ju e"},
            ["@`"]={"a 4","@r","7 rp","a r","@ r\\","@r"},
            uo={"w o","w O:","u7","w o","w O","u7"},
            iAU={"j a w","j aU","ja M","j a U","j Q U","ja M"},
            ["i@U"]={"j o w","j @U","j7 M","j o U","j @ U","j7 M"},
            uaI={"w a j","w aI","oa i","w a I","w a I","oa i"},
            uei={"w e j","w eI","ue i","w e I","w e I","ue i"},
            a_n={"a n","{ n","a np","a n","a n","a np"},
            AN={"a N","Q N","7 Np","a n","Q N","7 Np"},
            ["@_n"]={"e n","@ n","e np","e n","@ n","e np"},
            ["@N"]={"e N","@ N","e Np","e n","@ N","e Np"},
            i_n={"i n","i: n","i np","i n","i N","i np"},
            iN={"i N","i: N","i Np","i n","i N","i Np"},
            iE_n={"j e n","j e n","je np","j e n","j E n","je np"},
            iAN={"j a N","j Q N","j7 Np","j a n","j Q N","j7 Np"},
            ua_n={"w a n","w { n","oa np","w a n","w a n","oa np"},
            uAN={"w a N","w Q N","u7 Np","w a n","w Q N","u7 Np"},
            ["u@_n"]={"w e n","w @ n","ue np","w e n","w @ n","ue np"},
            ["u@N"]={"w e N","w @ N","ue Np","w e n","w @ N","ue Np"},
            y_n={"j M n","j u: n","ju np","j u n","j u n","ju np"},
            UN={"M N","U N","M Np","o U n","U N","M Np"},
            ["y{_n"]={"j M e n","j u: { n","ju e np","j u e n","j u E n","ju e np"},
            iUN={"j M N","j U N","ju Np","j o U n","j o U N","ju Np"},
            ["ts\\"]={"dZ","dZ","c","d s j","dZ","c"},
            ["z`"]={"Z","Z","c","d s j","Z","c"},
            ts={"dz","dz","d s","d s","dz","z"},
            ["s\\"]={"S","S","sh","s j","S","sh"},
        }  
    }[idx]

    dict={
        {-- idx==1, Japanese(Static)
            s="s", n="n", m="m", ["m'"]="m j", j="j", w="w", a="a", i="i", e="e", 
            o="o", k="k", ["k'"]="k j", g="g", ["g'"]="g j", t="t",["t'"]="t j", d="d", ["d'"]="d j", 
            ["p\\"]="f", ["p\\'"]="f j", p="p", ["p'"]="p j", b="b", ["b'"]="b j", ["4"]="r", ["4'"]="r j", J="n j"
        },
        {-- idx==2, English(Static)
            w="w", j="j", m="m", n="n", s="s", e="e", I="i",
            ["i:"]="i", ["{"]="a", ["O:"]="o", ["u:"]="u", b="b", d="d", g="g",
            l0="l", p="p", t="t", k="k", f="f", T="s", ["4"]="r"
        },
        {-- idx==3, Korean(Static)
            n="n", m="m", s="s", a="a", ja="j a", oa="w a", e="e", je="j e", 
            ue="w e", ui="w i", i="i", o="o", jo="j o", u="u", ju="j u", Mi="u i", 
            k="k", g="g", gp="g", t="t", d="d", dp="d",r="r", l="l", 
            p="p", b="b", bp="b", sh="S", N="N", Np="N", c="dZ", ch="tS", h="h", z="z", f="f"
        },
        {-- idx==4, Spanish(Static)
            j="j", w="w", m="m", n="n", s="s", a="a", e="e", i="i", o="o", u="u",
            I="i", U="M", ["@"]="7", E="e", b="b", d="d", g="g", k="k", p="p", t="t",
            l="l", r="r", J="n j", f="f", T="s", x="h", N="N", ["r\\"]="r", L0="l j"
        },
        {-- idx==5, Chinese(Static)
            m="m", n="n", s="s", a="a", o="o", i="i",
            u="u", p="b", p_h="p", f="f", t="d", t_h="t",
            l="l", k="g", k_h="k", ["ts\\_h"]="tS", x="h", ts_h="t s"
        }
    }[idx]

    rep={
        {-- idx==1, Japanese(replace)
            { J="J" }, --Maika
            { a="V", i="i:", o="O:" }, --English
            { ["p\\"]="h", ["p\\'"]="h j" }, --Korean
            { J="J" }, --Spanish
            { --Chinese
                e="ei", k="k_h", ["k'"]="k_h j", g="k", ["g'"]="k j",
                t="t_h", ["t'"]="t_h j", d="t", ["d'"]="t j", p="p_h",
                ["p'"]="p_h j", b="p", ["b'"]="p j", ["4"]="l", ["4'"]="l j"
            },
            nil --SeeU
        },
        {-- idx==2, English(replace)
            { ["u:"]="M", l0="4", f="p\\", ["4"]="4" }, --Japanese
            { I="I0", ["{"]="E", ["O:"]="O", T="T" }, --Maika
            { f="h" }, --Korean
            { T="T" }, --Spanish
            { e="ei", b="p", d="t", g="k", p="p_h", t="t_h", k="k_h", ["4"]="l" }, --Chinese
            nil --SeeU
        },
        {-- idx==3, Korean(replace)
            { u="M", ju="j M", Mi="M i", r="4", l="4", f="p\\" }, --Japanese
            { --English
                a="{", ja="j {", oa="w {", ui="w i:", i="i:", o="O:",
                jo="j O:", u="u:", ju="j u:", Mi="U i", k="kh", g="gh",
                t="th", d="dh", l="l0", p="ph", b="bh"
            },
            nil, --Maika
            { sh="s j", N="n", Np="n", c="D s", h="x", z="d s" }, --Spanish
            { --Chinese
                ja="ia", oa="ua", e="ei", je="iE_r", ue="uei", ui="y",
                jo="i@U", k="k_h", g="k", gp="k", t="t_h", d="t",
                dp="t", r="l", p="p_h", b="p", bp="p", sh="s`",
                N="n", c="ts`", ch="ts`_h", h="x", z="ts"
            }
        },
        {-- idx==4, Spanish(replace)
            { ["@"]="a", l="4", r="4", J="J", f="p\\", ["r\\"]="4", L0="4'" }, --Japanese
            { --English
                a="{", i="i:", o="O:", u="u:", I="I", U="U",
                ["@"]="@", E="{", l="l0", T="T", L0="l0 j"
            },
            { f="h", N="Np" }, --Korean
            { N="Np" }, --SeeU
            { --Chinese
                e="ei", U="u", E="ei", b="p", d="t", g="k",
                k="k_h", p="p_h", t="t_h", r="z`", x="x", ["r\\"]="@`",
            }
        },
        {-- idx==5, Chinese(replace)
            { f="p\\", l="4", ts_h="ts" }, --Japanese
            { --English
                a="{", o="O:", i="i:", u="u:", p="p", p_h="ph",
                t="t", t_h="th", l="l0", k="k", k_h="kh",
            },
            { f="h", ["ts\\_h"]="ch" }, --Korean
            { x="x" }, --Spanish
            { x="x", ts_h="ts" }, --Maika
            { ["ts\\_h"]="ch" } --SeeU
        }
    }[idx][lang]
    for k,v in pairs(res) do dict[k]=v[lang] end
    if rep then for k,v in pairs(rep) do dict[k]=v end end

    dict=setmetatable(dict,{__index={
        [1]={["N\\"]=dict.N,["h\\"]=dict.h}, --Japanese
        [2]={["e@0"]=dict["e@"],bh=dict.b,dh=dict.d,gh=dict.g,
            ph=dict.p,th=dict.t,kh=dict.k,["@l"]=dict.l,["h\\"]=dict.h}, --English
        [3]={["g'"]=dict.gp,np=dict.n,["d'"]=dict.dp,mp=dict.m,["b'"]=dict.bp,["s'"]=dict.s,
            ["sh'"]=dict.sh,["c'"]=dict.c,["ch'"]=dict.ch,D=dict.Np,C=dict.s}, --Korean
        [4]={["j\\"]=dict.j,L=dict.j,G=dict.g,rr=dict.r,I0=dict.I,O=dict.o,h=dict.x,v=dict.B},  --Spanish
        [5]={["i`"]=dict["i\\"],["ts`"]=dict["ts\\"],["ts`_h"]=dict["ts\\_h"],["s`"]=dict["s\\"]} --Chinese
    }[idx]})

    return dict