-- Kor2Chn.lua
-- Mapping of Korean VSQ(X)'s to Chinese phonetics.

function manifest()
    myManifest = {
        name          = "Korean to Chinese",
        comment       = "Convert Korean VSQX for Chinese voice banks",
        author        = "Slidingwall",
        pluginID      = "{A114514-1919-810A-A12F-92E54EE5D41T}",
        pluginVersion = "For Chinese Libraries",
        apiVersion    = "3.0.1.0"
    }
    
    return myManifest
end

function main(processParam, envParam)

	-- local beginPosTick = processParam.beginPosTick
	-- local endPosTick   = processParam.endPosTick
	-- local songPosTick  = processParam.songPosTick

	-- local scriptDir  = envParam.scriptDir
	-- local scriptName = envParam.scriptName
	-- local tempDir    = envParam.tempDir
	
	local mapping    = {}
	local mapping2   = {}
	local mapping2a   = {}
	local mapping3   = {}
	local noteEx     = {}
	local noteExList = {}
	local noteCount
	local retCode
	local idx
	
	mapping["ja"]	= "ia"
		mapping2["b ja"]	= {"p","i a"}
		mapping2["b' ja"]	= {"p","i a"}
		mapping2["p ja"]	= {"p_h","i a"}
		mapping2["m ja"]	= {"m","i a"}
		mapping2["t ja"]	= {"t_h","i a"}
		mapping2["n ja"]	= {"n","i a"}
		mapping2["D ja"]	= {"n","i a"}
	mapping["7"]	= "AU o"
	mapping["j7"]	= "iAU o"
	mapping["o"]	= "o"
		mapping2["d o"] = {"t","@U o"}
		mapping2["d' o"]= {"t","@U o"}
		mapping3["d o np"]={"t","UN"}
		mapping3["d' o np"]={"t","UN"}
		mapping3["d o mp"]={"t","UN"}
		mapping3["d' o mp"]={"t","UN"}
		mapping3["d o Np"]={"t","UN"}
		mapping3["d' o Np"]={"t","UN"}
		mapping2["n o"] = {"n","@U o"}
		mapping2["D o"]= {"n","@U o"}
		mapping3["n o np"]={"n","UN"}
		mapping3["D o np"]={"n","UN"}
		mapping3["n o mp"]={"n","UN"}
		mapping3["D o mp"]={"n","UN"}
		mapping3["n o Np"]={"n","UN"}
		mapping3["D o Np"]={"n","UN"}
		mapping2["r o"] = {"l","@U o"}
		mapping2["l o"]= {"l","@U o"}
		mapping3["r o np"]={"l","UN"}
		mapping3["l o np"]={"l","UN"}
		mapping3["r o mp"]={"l","UN"}
		mapping3["l o mp"]={"l","UN"}
		mapping3["r o Np"]={"l","UN"}
		mapping3["l o Np"]={"l","UN"}
		mapping2["c o"] = {"ts","@U o"}
		mapping2["c' o"]= {"ts","@U o"}
		mapping3["c o np"]={"ts","UN"}
		mapping3["c' o np"]={"ts","UN"}
		mapping3["c o mp"]={"ts","UN"}
		mapping3["c' o mp"]={"ts","UN"}
		mapping3["c o Np"]={"ts","UN"}
		mapping3["c' o Np"]={"ts","UN"}
		mapping2["t o"] = {"t_h","@U o"}
		mapping3["t o np"]={"t_h","UN"}
		mapping3["t o mp"]={"t_h","UN"}
		mapping3["t o Np"]={"t_h","UN"}
		mapping2["s o"] = {"ts_h","@U o"}
		mapping3["s o np"]={"ts_h","UN"}
		mapping3["s o mp"]={"ts_h","UN"}
		mapping3["s o Np"]={"ts_h","UN"}
		mapping2["g o"] = {"k","@U o"}
		mapping2["g' o"]= {"k","@U o"}
		mapping3["g o np"]={"k","UN"}
		mapping3["g' o np"]={"k","UN"}
		mapping3["g o mp"]={"k","UN"}
		mapping3["g' o mp"]={"k","UN"}
		mapping3["g o Np"]={"k","UN"}
		mapping3["g' o Np"]={"k","UN"}
		mapping2["k o"] = {"k_h","@U o"}
		mapping3["k o np"]={"k_h","UN"}
		mapping3["k o mp"]={"k_h","UN"}
		mapping3["k o Np"]={"k_h","UN"}
		mapping2["ch o"] = {"ts","@U o"}
		mapping3["ch o np"]={"ts","UN"}
		mapping3["ch o mp"]={"ts","UN"}
		mapping3["ch o Np"]={"ts","UN"}
		mapping2["h o"] = {"x","@U o"}
		mapping3["h o np"]={"x","UN"}
		mapping3["h o mp"]={"x","UN"}
		mapping3["h o Np"]={"x","UN"}
	mapping["jo"]	= "i@U"
		mapping2["b jo"]	= {"p","i @U"}
		mapping2["b' jo"]	= {"p","i @U"}
		mapping2["p jo"]	= {"p_h","i @U"}
		mapping2["t jo"]	= {"t_h","i @U"}
	mapping["ju"]	= "y"
		mapping2["b ju"]	= {"p","i @U"}
		mapping2["b' ju"]	= {"p","i @U"}
		mapping2["p ju"]	= {"p_h","i @U"}
		mapping2["m ju"]	= {"m","i@U"}
		mapping2["d ju"]	= {"t","i@U"}
		mapping2["d' ju"]	= {"t","i@U"}
		mapping2["t ju"]	= {"t_h","i @U"}
	mapping["M"]	= "u"
	mapping["e"]	= "ei"
		mapping2["t e"]	= {"t_h","7 ei"}
		mapping2["s e"]	= {"ts_h","7 ei"}
	mapping["je"]	= "iE_r"
	mapping["oa"]	= "ua"
		mapping2["b oa"]	= {"p","u a"}
		mapping2["b' oa"]	= {"p","u a"}
		mapping2["p oa"]	= {"p_h","u a"}
		mapping2["m oa"]	= {"m","u a"}
		mapping2["d oa"]	= {"t","u a"}
		mapping2["d' oa"]	= {"t","u a"}
		mapping2["t oa"]	= {"t_h","u a"}
		mapping2["n oa"]	= {"n","u a"}
		mapping2["D oa"]	= {"n","u a"}
		mapping2["r oa"]	= {"l","u a"}
		mapping2["l oa"]	= {"l","u a"}
		mapping2["s oa"]	= {"ts_h","u a"}
		mapping2["c oa"]	= {"ts","u a"}
		mapping2["c' oa"]	= {"ts","u a"}
		mapping2["ch oa"]	= {"ts","u a"}
	mapping["u7"]	= "uo"
		mapping2["b u7"]	= {"p","o"}
		mapping2["b' u7"]	= {"p","o"}
		mapping2["p u7"]	= {"p_h","o"}
		mapping2["m u7"]	= {"m","o"}
	mapping["ue"]	= "uei"
		mapping2["b ue"]	= {"p","u ei"}
		mapping2["b' ue"]	= {"p","u ei"}
		mapping2["p ue"]	= {"p_h","u ei"}
		mapping2["m ue"]	= {"m","u ei"}
		mapping2["n ue"]	= {"n","u ei"}
		mapping2["D ue"]	= {"n","u ei"}
		mapping2["r ue"]	= {"l","u ei"}
		mapping2["l ue"]	= {"l","u ei"}
	mapping["ui"]	= "u i"
		mapping2["sh ui"]	= {"ts\\_h","i"}
		mapping2["sh' ui"]	= {"ts\\","i"}
	mapping["Mi"]	= "u i"

	mapping["h"]	= "x"
		mapping2["h i"] = {"x", "7_0 i i i"}
		mapping2["h ja"] = {"x", "7_0 ia a a a"}
		mapping2["h j7"] = {"x", "7_0 ia AU AU"}
		mapping2["h je"] = {"x", "7_0 iE_r ei"}
		mapping2["h jo"] = {"x", "7_0 i@U o o"}
		mapping2["h ju"] = {"x", "7_0 y y y"}
			mapping3["h i np"]	=	{"x 7_0","i i","i_n"} 
			mapping3["h i mp"]	=	{"x 7_0","i i","i_n"}
			mapping3["h i Np"]	=	{"x 7_0","i i","iN"}
			mapping3["h j7 np"] = {"x 7_0","i ia","AN"}
			mapping3["h j7 mp"] = {"x 7_0","i ia","AN"}
			mapping3["h j7 Np"] = {"x 7_0","i ia","AN"}
			mapping3["h ja Np"] = {"x 7_0","i ia","AN"}
			mapping3["h ja np"]	= {"x 7_0","i ia","a_n"}
			mapping3["h ja mp"]	= {"x 7_0","i ia","a_n"}
			mapping3["h je np"]	= {"x 7_0","iE_n","@_n"}
			mapping3["h je mp"]	= {"x 7_0","iE_n","@_n"}
			mapping3["h je Np"] = {"x 7_0","i iE_n","@N"}
			mapping3["h jo np"] = {"x 7_0","i i@U","UN"}
			mapping3["h jo mp"] = {"x 7_0","i i@U","UN"}
			mapping3["h jo Np"] = {"x 7_0","i i@U","UN"}
			mapping3["h ju np"] = {"x 7_0","y y","y_n"}
			mapping3["h ju mp"] = {"x 7_0","y y","y_n"}
			mapping3["h ju mp"] = {"x 7_0","y y_n","@N"}
	mapping["g"]	= "k"
		mapping2["g i"] = {"k", "7_0 i i i"}
		mapping2["g ja"] = {"k", "7_0 ia a a a"}
		mapping2["g j7"] = {"k", "7_0 ia AU AU"}
		mapping2["g je"] = {"k", "7_0 iE_r ei"}
		mapping2["g jo"] = {"k", "7_0 i@U o o"}
		mapping2["g ju"] = {"k", "7_0 y y y"}
			mapping3["g i np"]	=	{"k 7_0","i i","i_n"} 
			mapping3["g i mp"]	=	{"k 7_0","i i","i_n"}
			mapping3["g i Np"]	=	{"k 7_0","i i","iN"}
			mapping3["g j7 np"] = {"k 7_0","i ia","AN"}
			mapping3["g j7 mp"] = {"k 7_0","i ia","AN"}
			mapping3["g j7 Np"] = {"k 7_0","i ia","AN"}
			mapping3["g ja Np"] = {"k 7_0","i ia","AN"}
			mapping3["g ja np"]	= {"k 7_0","i ia","a_n"}
			mapping3["g ja mp"]	= {"k 7_0","i ia","a_n"}
			mapping3["g je np"]	= {"k 7_0","iE_n","@_n"}
			mapping3["g je mp"]	= {"k 7_0","iE_n","@_n"}
			mapping3["g je Np"] = {"k 7_0","i iE_n","@N"}
			mapping3["g jo np"] = {"k 7_0","i i@U","UN"}
			mapping3["g jo mp"] = {"k 7_0","i i@U","UN"}
			mapping3["g jo Np"] = {"k 7_0","i i@U","UN"}
			mapping3["g ju np"] = {"k 7_0","y y","y_n"}
			mapping3["g ju mp"] = {"k 7_0","y y","y_n"}
			mapping3["g ju mp"] = {"k 7_0","y y_n","@N"}
	mapping["g'"]	= "k"
		mapping2["g' i"] = {"k", "7_0 i i i"}
		mapping2["g' ja"] = {"k", "7_0 ia a a a"}
		mapping2["g' j7"] = {"k", "7_0 ia AU AU"}
		mapping2["g' je"] = {"k", "7_0 iE_r ei"}
		mapping2["g' jo"] = {"k", "7_0 i@U o o"}
		mapping2["g' ju"] = {"k", "7_0 y y y"}
			mapping3["g' i np"]	=	{"k 7_0","i i","i_n"} 
			mapping3["g' i mp"]	=	{"k 7_0","i i","i_n"}
			mapping3["g' i Np"]	=	{"k 7_0","i i","iN"}
			mapping3["g' j7 np"] = {"k 7_0","i ia","AN"}
			mapping3["g' j7 mp"] = {"k 7_0","i ia","AN"}
			mapping3["g' j7 Np"] = {"k 7_0","i ia","AN"}
			mapping3["g' ja Np"] = {"k 7_0","i ia","AN"}
			mapping3["g' ja np"]	= {"k 7_0","i ia","a_n"}
			mapping3["g' ja mp"]	= {"k 7_0","i ia","a_n"}
			mapping3["g' je np"]	= {"k 7_0","iE_n","@_n"}
			mapping3["g' je mp"]	= {"k 7_0","iE_n","@_n"}
			mapping3["g' je Np"] = {"k 7_0","i iE_n","@N"}
			mapping3["g' jo np"] = {"k 7_0","i i@U","UN"}
			mapping3["g' jo mp"] = {"k 7_0","i i@U","UN"}
			mapping3["g' jo Np"] = {"k 7_0","i i@U","UN"}
			mapping3["g' ju np"] = {"k 7_0","y y","y_n"}
			mapping3["g' ju mp"] = {"k 7_0","y y","y_n"}
			mapping3["g' ju mp"] = {"k 7_0","y y_n","@N"}
	mapping["k"]	= "k_h"
		mapping2["k i"] = {"k_h", "7_0 i i i"}
		mapping2["k ja"] = {"k_h", "7_0 ia a a a"}
		mapping2["k j7"] = {"k_h", "7_0 ia AU AU"}
		mapping2["k je"] = {"k_h", "7_0 iE_r ei"}
		mapping2["k jo"] = {"k_h", "7_0 i@U o o"}
		mapping2["k ju"] = {"k_h", "7_0 y y y"}
			mapping3["k i np"]	=	{"k_h 7_0","i i","i_n"} 
			mapping3["k i mp"]	=	{"k_h 7_0","i i","i_n"}
			mapping3["k i Np"]	=	{"k_h 7_0","i i","iN"}
			mapping3["k j7 np"] = {"k_h 7_0","i ia","AN"}
			mapping3["k j7 mp"] = {"k_h 7_0","i ia","AN"}
			mapping3["k j7 Np"] = {"k_h 7_0","i ia","AN"}
			mapping3["k ja Np"] = {"k_h 7_0","i ia","AN"}
			mapping3["k ja np"]	= {"k_h 7_0","i ia","a_n"}
			mapping3["k ja mp"]	= {"k_h 7_0","i ia","a_n"}
			mapping3["k je np"]	= {"k_h 7_0","iE_n","@_n"}
			mapping3["k je mp"]	= {"k_h 7_0","iE_n","@_n"}
			mapping3["k je Np"] = {"k_h 7_0","i iE_n","@N"}
			mapping3["k jo np"] = {"k_h 7_0","i i@U","UN"}
			mapping3["k jo mp"] = {"k_h 7_0","i i@U","UN"}
			mapping3["k jo Np"] = {"k_h 7_0","i i@U","UN"}
			mapping3["k ju np"] = {"k_h 7_0","y y","y_n"}
			mapping3["k ju mp"] = {"k_h 7_0","y y","y_n"}
			mapping3["k ju mp"] = {"k_h 7_0","y y_n","@N"}
	mapping["D"]    = "n"
	mapping["d"]	= "t"
	mapping["d'"]	= "t"
	mapping["t"]	= "t_h"
	mapping["r"]	= "l"
	mapping["b"]	= "p"
	mapping["b'"]	= "p"
	mapping["p"]	= "p_h"
	mapping["s"]	= "ts_h"
	mapping["sh"]	= "ts\\_h"
	mapping["s'"]	= "s"
	mapping["sh'"]	= "ts\\"
	mapping["c"]	= "ts"
	mapping["c'"]	= "ts"
	mapping["ch"]	= "ts"
		mapping2["c i"]		= {"ts\\","i"}
		mapping2["c' i"]	= {"ts\\","i"}
		mapping2["ch i"]	= {"ts\\","i"}
		mapping2["c j7"]	= {"ts\\","iAU o"}
		mapping2["c' j7"]	= {"ts\\","iAU o"}
		mapping2["ch j7"]	= {"ts\\","iAU o"}
		mapping2["c ja"]	= {"ts`","ia"}
		mapping2["c' ja"]	= {"ts`","ia"}
		mapping2["ch ja"]	= {"ts`","ia"}
		mapping2["c je"]	= {"ts\\","iE_r"}
		mapping2["c' je"]	= {"ts\\","iE_r"}
		mapping2["ch je"]	= {"ts\\","iE_r"}
		mapping2["c jo"]	= {"ts\\","i@U"}
		mapping2["c' jo"]	= {"ts\\","i@U"}
		mapping2["ch jo"]	= {"ts\\","i@U"}
		mapping2["c ju"]	= {"ts\\","y"}
		mapping2["c' ju"]	= {"ts\\","y"}
		mapping2["ch ju"]	= {"ts\\","y"}


	mapping["gp"]	= "k ?"
	mapping["dp"]	= "t ?"
	mapping["rp"]	= "l ?"
	mapping["bp"]	= "p ?"

		mapping2a["7 np"]	=	{"AN"}
		mapping2a["7 mp"]	=	{"AN"} 
		mapping2a["a np"]	=	{"a_n"} 
		mapping2a["a mp"]	=	{"a_n"} 
		mapping2a["e np"]	=	{"@_n"} 
		mapping2a["e mp"]	=	{"@_n"}
			mapping3["t e np"]	=	{"t_h","7","@_n"} 
			mapping3["t e mp"]	=	{"t_h","7","@_n"}
			mapping3["r e np"]	=	{"l","7","@_n"} 
			mapping3["r e mp"]	=	{"l","7","@_n"}
			mapping3["l e np"]	=	{"l","7","@_n"} 
			mapping3["l e mp"]	=	{"l","7","@_n"}
		mapping2a["i np"]	=	{"i_n"} 
		mapping2a["i mp"]	=	{"i_n"} 
			mapping3["d i np"]	=	{"t","i","i_n"} 
			mapping3["d i mp"]	=	{"t","i","i_n"} 
			mapping3["d' i np"]	=	{"t","i","i_n"} 
			mapping3["d' i mp"]	=	{"t","i","i_n"} 
			mapping3["t i np"]	=	{"t_h","i","i_n"} 
			mapping3["t i mp"]	=	{"t_h","i","i_n"}
			mapping3["c i np"]	= {"ts\\","i_n"}
			mapping3["c' i np"]	= {"ts\\","i_n"}
			mapping3["ch i np"]	= {"ts\\","i_n"}
			mapping3["c i mp"]	= {"ts\\","i_n"}
			mapping3["c' i mp"]	= {"ts\\","i_n"}
			mapping3["ch i mp"]	= {"ts\\","i_n"}
		mapping2a["j7 np"]	=	{"iAN"} 
		mapping2a["j7 mp"]	=	{"iAN"}
			mapping3["b j7 np"] = {"p","i","AN"}
			mapping3["b' j7 np"] = {"p","i","AN"}
			mapping3["p j7 np"] = {"p_h","i","AN"}
			mapping3["m j7 np"] = {"m","i","AN"}
			mapping3["d j7 np"] = {"t","i","AN"}
			mapping3["d' j7 np"] = {"t","i","AN"}
			mapping3["t j7 np"] = {"t_h","i","AN"}
			mapping3["b j7 mp"] = {"p","i","AN"}
			mapping3["b' j7 mp"] = {"p","i","AN"}
			mapping3["p j7 mp"] = {"p_h","i","AN"}
			mapping3["m j7 mp"] = {"m","i","AN"}
			mapping3["d j7 mp"] = {"t","i","AN"}
			mapping3["d' j7 mp"] = {"t","i","AN"}
			mapping3["t j7 mp"] = {"t_h","i","AN"}
			mapping3["c j7 np"] = {"ts\\","i","AN"}
			mapping3["c' j7 np"] = {"ts\\","i","AN"}
			mapping3["ch j7 np"] = {"ts\\","i","AN"}
			mapping3["c j7 mp"] = {"ts\\","i","AN"}
			mapping3["c' j7 mp"] = {"ts\\","i","AN"}
			mapping3["ch j7 mp"] = {"ts\\","i","AN"}
		mapping2a["ja np"]	=	{"ia","a_n"} 
		mapping2a["ja mp"]	=	{"ia","a_n"}
			mapping3["b ja np"]	= {"p","i","a_n"}
			mapping3["b' ja np"]	= {"p","i","a_n"}
			mapping3["p ja np"]	= {"p_h","i","a_n"}
			mapping3["m ja np"]	= {"m","i","a_n"}
			mapping3["t ja np"]	= {"t_h","i","a_n"}
			mapping3["n ja np"]	= {"n","i","a_n"}
			mapping3["D ja np"]	= {"n","i","a_n"}
			mapping3["b ja mp"]	= {"p","i","a_n"}
			mapping3["b' ja mp"]	= {"p","i","a_n"}
			mapping3["p ja mp"]	= {"p_h","i","a_n"}
			mapping3["m ja mp"]	= {"m","i","a_n"}
			mapping3["t ja mp"]	= {"t_h","i","a_n"}
			mapping3["n ja mp"]	= {"n","i","a_n"}
			mapping3["D ja mp"]	= {"n","i","a_n"}
		mapping2a["je np"]	=	{"iE_n"} 
		mapping2a["je mp"]	=	{"iE_n"} 
			mapping3["c je np"]	= {"ts\\","iE_n"}
			mapping3["c' je np"]	= {"ts\\","iE_n"}
			mapping3["ch je np"]	= {"ts\\","iE_n"}
			mapping3["c je mp"]	= {"ts\\","iE_n"}
			mapping3["c' je mp"]	= {"ts\\","iE_n"}
			mapping3["ch je mp"]	= {"ts\\","iE_n"}
		mapping2a["jo np"]	=	{"iUN"} 
		mapping2a["jo mp"]	=	{"iUN"} 
			mapping3["b jo np"] = {"p","i","iUN"}
			mapping3["b' jo np"] = {"p","i","iUN"}
			mapping3["p jo np"] = {"p_h","i","iUN"}
			mapping3["m jo np"] = {"m","i","iUN"}
			mapping3["d jo np"] = {"t","i","iUN"}
			mapping3["d' jo np"] = {"t","i","iUN"}
			mapping3["t jo np"] = {"t_h","i","iUN"}
			mapping3["n jo np"] = {"n","i","iUN"}
			mapping3["D jo np"] = {"n","i","iUN"}
			mapping3["r jo np"] = {"l","i","iUN"}
			mapping3["l jo np"] = {"l","i","iUN"}
			mapping3["c jo np"] = {"ts\\","i","iUN"}
			mapping3["c' jo np"] = {"ts\\","i","iUN"}
			mapping3["ch jo np"] = {"ts\\","i","iUN"}
			mapping3["b jo mp"] = {"p","i","iUN"}
			mapping3["b' jo mp"] = {"p","i","iUN"}
			mapping3["p jo mp"] = {"p_h","i","iUN"}
			mapping3["m jo mp"] = {"m","i","iUN"}
			mapping3["d jo mp"] = {"t","i","iUN"}
			mapping3["d' jo mp"] = {"t","i","iUN"}
			mapping3["t jo mp"] = {"t_h","i","iUN"}
			mapping3["n jo mp"] = {"n","i","iUN"}
			mapping3["r jo mp"] = {"l","i","iUN"}
			mapping3["l jo mp"] = {"l","i","iUN"}
			mapping3["c jo mp"] = {"ts\\","i","iUN"}
			mapping3["c' jo mp"] = {"ts\\","i","iUN"}
			mapping3["ch jo mp"] = {"ts\\","i","iUN"}
		mapping2a["ju np"]	=	{"y_n"} 
		mapping2a["ju mp"]	=	{"y_n"} 
			mapping3["b ju np"] = {"p","i","iUN"}
			mapping3["b' ju np"] = {"p","i","iUN"}
			mapping3["p ju np"] = {"p_h","i","iUN"}
			mapping3["m ju np"] = {"m","i","iUN"}
			mapping3["d ju np"] = {"t","i","iUN"}
			mapping3["d' ju np"] = {"t","i","iUN"}
			mapping3["t ju np"] = {"t_h","i","iUN"}
			mapping3["n ju np"] = {"n","y","y_n"}
			mapping3["D ju np"] = {"n","y","y_n"}
			mapping3["r ju np"] = {"l","y","y_n"}
			mapping3["l ju np"] = {"l","y","y_n"}
			mapping3["c ju np"] = {"ts\\","y_n"}
			mapping3["c' ju np"] = {"ts\\","y_n"}
			mapping3["ch ju np"] = {"ts\\","y_n"}
			mapping3["b ju mp"] = {"p","i","iUN"}
			mapping3["b' ju mp"] = {"p","i","iUN"}
			mapping3["p ju mp"] = {"p_h","i","iUN"}
			mapping3["m ju mp"] = {"m","i","iUN"}
			mapping3["d ju mp"] = {"t","i","iUN"}
			mapping3["d' ju mp"] = {"t","i","iUN"}
			mapping3["t ju mp"] = {"t_h","i","iUN"}
			mapping3["n ju mp"] = {"n","y","y_n"}
			mapping3["D ju mp"] = {"n","y","y_n"}
			mapping3["r ju mp"] = {"l","y","y_n"}
			mapping3["l ju mp"] = {"l","y","y_n"}
			mapping3["c ju mp"] = {"ts\\","y_n"}
			mapping3["c' ju mp"] = {"ts\\","y_n"}
			mapping3["ch ju mp"] = {"ts\\","y_n"}
		mapping2a["M np"]	=	{"u@_n"} 
		mapping2a["M mp"]	=	{"u@_n"}
		mapping2a["ue np"]	=	{"u@_n"}
		mapping2a["ue mp"]	=	{"u@_n"}
			mapping3["b M np"]	=	{"p","u","@_n"}
			mapping3["b M mp"]	=	{"p","u","@_n"}
			mapping3["b' M np"]	=	{"p","u","@_n"}
			mapping3["b' M mp"]	=	{"p","u","@_n"}
			mapping3["p M np"]	=	{"p_h","u","@_n"}
			mapping3["p M mp"]	=	{"p_h","u","@_n"}
			mapping3["m M np"]	=	{"m","u","@_n"}
			mapping3["m M mp"]	=	{"m","u","@_n"}
			mapping3["n M np"]	=	{"n","u","@_n"}
			mapping3["n M mp"]	=	{"n","u","@_n"}
			mapping3["D M np"]	=	{"n","u","@_n"}
			mapping3["D M mp"]	=	{"n","u","@_n"}
			mapping3["b ue np"]	=	{"p","u","@_n"}
			mapping3["b ue mp"]	=	{"p","u","@_n"}
			mapping3["b' ue np"]	=	{"p","u","@_n"}
			mapping3["b' ue mp"]	=	{"p","u","@_n"}
			mapping3["p ue np"]	=	{"p_h","u","@_n"}
			mapping3["p ue mp"]	=	{"p_h","u","@_n"}
			mapping3["m ue np"]	=	{"m","u","@_n"}
			mapping3["m ue mp"]	=	{"m","u","@_n"}
			mapping3["n ue np"]	=	{"n","u","@_n"}
			mapping3["n ue mp"]	=	{"n","u","@_n"}
			mapping3["D ue np"]	=	{"n","u","@_n"}
			mapping3["D ue mp"]	=	{"n","u","@_n"}
		mapping2a["o np"]	=	{"UN"}
		mapping2a["o mp"]	=	{"UN"}
		mapping2a["u np"]	=	{"UN"}
		mapping2a["u mp"]	=	{"UN"}
			mapping3["b o np"]	=	{"p","u","UN"}
			mapping3["b o mp"]	=	{"p","u","UN"}
			mapping3["b u np"]	=	{"p","u","UN"}
			mapping3["b u mp"]	=	{"p","u","UN"}
			mapping3["b' o np"]	=	{"p","u","UN"}
			mapping3["b' o mp"]	=	{"p","u","UN"}
			mapping3["b' u np"]	=	{"p","u","UN"}
			mapping3["b' u mp"]	=	{"p","u","UN"}
			mapping3["p o np"]	=	{"p_h","u","UN"}
			mapping3["p o mp"]	=	{"p_h","u","UN"}
			mapping3["p u np"]	=	{"p_h","u","UN"}
			mapping3["p u mp"]	=	{"p_h","u","UN"}
			mapping3["m o np"]	=	{"m","u","UN"}
			mapping3["m o mp"]	=	{"m","u","UN"}
			mapping3["m u np"]	=	{"m","u","UN"}
			mapping3["m u mp"]	=	{"m","u","UN"}
		mapping2a["oa np"]	=	{"ua_n"}
		mapping2a["oa mp"]	=	{"ua_n"}
			mapping3["b oa np"]	=	{"p","u","a_n"}
			mapping3["b oa mp"]	=	{"p","u","a_n"}
			mapping3["b' oa np"]	=	{"p","u","a_n"}
			mapping3["b' oa mp"]	=	{"p","u","a_n"}
			mapping3["p oa np"]	=	{"p_h","u","a_n"}
			mapping3["p oa mp"]	=	{"p_h","u","a_n"}
			mapping3["m oa np"]	=	{"m","u","a_n"}
			mapping3["m oa mp"]	=	{"m","u","a_n"}
		mapping2a["u7 np"]	=	{"uAN"}
		mapping2a["u7 mp"]	=	{"uAN"}
			mapping3["b u7 np"] = {"p","u","AN"}
			mapping3["b' u7 np"] = {"p","u","AN"}
			mapping3["p u7 np"] = {"p_h","u","AN"}
			mapping3["m u7 np"] = {"m","u","AN"}
			mapping3["d u7 np"] = {"t","u","AN"}
			mapping3["d' u7 np"] = {"t","u","AN"}
			mapping3["t u7 np"] = {"t_h","u","AN"}
			mapping3["n u7 np"] = {"n","u","AN"}
			mapping3["D u7 np"] = {"n","u","AN"}
			mapping3["r u7 np"] = {"l","u","AN"}
			mapping3["l u7 np"] = {"l","u","AN"}
			mapping3["s u7 np"] = {"ts_h","u","AN"}
			mapping3["s' u7 np"] = {"ts","u","AN"}
			mapping3["c u7 np"] = {"ts","u","AN"}
			mapping3["c' u7 np"] = {"ts","u","AN"}
			mapping3["ch u7 np"] = {"ts","u","AN"}
			mapping3["b u7 mp"] = {"p","u","AN"}
			mapping3["b' u7 mp"] = {"p","u","AN"}
			mapping3["p u7 mp"] = {"p_h","u","AN"}
			mapping3["m u7 mp"] = {"m","u","AN"}
			mapping3["d u7 mp"] = {"t","u","AN"}
			mapping3["d' u7 mp"] = {"t","u","AN"}
			mapping3["t u7 mp"] = {"t_h","u","AN"}
			mapping3["n u7 mp"] = {"n","u","AN"}
			mapping3["D u7 mp"] = {"n","u","AN"}
			mapping3["r u7 mp"] = {"l","u","AN"}
			mapping3["l u7 mp"] = {"l","u","AN"}
			mapping3["s u7 mp"] = {"ts_h","u","AN"}
			mapping3["s' u7 mp"] = {"ts","u","AN"}
			mapping3["c u7 mp"] = {"ts","u","AN"}
			mapping3["c' u7 mp"] = {"ts","u","AN"}
			mapping3["ch u7 mp"] = {"ts","u","AN"}
		mapping2a["Mi np"]	=	{"u","i_n"}
		mapping2a["Mi mp"]	=	{"u","i_n"}
		mapping2a["ui np"]	=	{"u","i_n"}
		mapping2a["ui mp"]	=	{"u","i_n"}
			mapping3["sh ui np"]	=	{"ts\\_h","i_n"}
			mapping3["sh ui mp"]	=	{"ts\\_h","i_n"}
			mapping3["sh' ui np"]	=	{"ts\\","i_n"}
			mapping3["sh' ui mp"]	=	{"ts\\","i_n"}
		
	mapping["N"]	= "n"
		mapping2a["a Np"] = {"AN"}
		mapping2a["7 Np"] = {"AN"}
		mapping2a["ja Np"] = {"iAN"}
		mapping2a["j7 Np"] = {"iAN"}
			mapping3["b ja Np"] = {"p","i","AN"}
			mapping3["b' ja Np"] = {"p","i","AN"}
			mapping3["p ja Np"] = {"p_h","i","AN"}
			mapping3["m ja Np"] = {"m","i","AN"}
			mapping3["d ja Np"] = {"t","i","AN"}
			mapping3["d' ja Np"] = {"t","i","AN"}
			mapping3["t ja Np"] = {"t_h","i","AN"}
			mapping3["b j7 Np"] = {"p","i","AN"}
			mapping3["b' j7 Np"] = {"p","i","AN"}
			mapping3["p j7 Np"] = {"p_h","i","AN"}
			mapping3["m j7 Np"] = {"m","i","AN"}
			mapping3["d j7 Np"] = {"t","i","AN"}
			mapping3["d' j7 Np"] = {"t","i","AN"}
			mapping3["t j7 Np"] = {"t_h","i","AN"}
			mapping3["c ja Np"] = {"ts\\","i","AN"}
			mapping3["c' ja Np"] = {"ts\\","i","AN"}
			mapping3["ch ja Np"] = {"ts\\","i","AN"}
			mapping3["c j7 Np"] = {"ts\\","i","AN"}
			mapping3["c' j7 Np"] = {"ts\\","i","AN"}
			mapping3["ch j7 Np"] = {"ts\\","i","AN"}
		mapping2a["e Np"] = {"@N"}
		mapping2a["je Np"] = {"iE_n"}
		mapping2a["o Np"] = {"UN"}
		mapping2a["u Np"] = {"UN"}
		mapping2a["M Np"] = {"UN"}
			mapping3["b o Np"]	=	{"p","u","UN"}
			mapping3["b u Np"]	=	{"p","u","UN"}
			mapping3["b M Np"]	=	{"p","u","UN"}
			mapping3["b' o Np"]	=	{"p","u","UN"}
			mapping3["b' u Np"]	=	{"p","u","UN"}
			mapping3["b' M Np"]	=	{"p","u","UN"}
			mapping3["p o Np"]	=	{"p_h","u","UN"}
			mapping3["p u Np"]	=	{"p_h","u","UN"}
			mapping3["p M Np"]	=	{"p_h","u","UN"}
			mapping3["m o Np"]	=	{"m","u","UN"}
			mapping3["m u Np"]	=	{"m","u","UN"}
			mapping3["m M Np"]	=	{"m","u","UN"}
		mapping2a["oa Np"] = {"uAN"}
			mapping3["b oa Np"] = {"p","u","AN"}
			mapping3["b' oa Np"] = {"p","u","AN"}
			mapping3["p oa Np"] = {"p_h","u","AN"}
			mapping3["m oa Np"] = {"m","u","AN"}
			mapping3["d oa Np"] = {"t","u","AN"}
			mapping3["d' oa Np"] = {"t","u","AN"}
			mapping3["t oa Np"] = {"t_h","u","AN"}
			mapping3["n oa Np"] = {"n","u","AN"}
			mapping3["D oa Np"] = {"n","u","AN"}
			mapping3["r oa Np"] = {"l","u","AN"}
			mapping3["l oa Np"] = {"l","u","AN"}
			mapping3["s oa Np"] = {"ts_h","u","AN"}
			mapping3["s' oa Np"] = {"ts","u","AN"}
			mapping3["c oa Np"] = {"ts","u","AN"}
			mapping3["c' oa Np"] = {"ts","u","AN"}
			mapping3["ch oa Np"] = {"ts","u","AN"}
		mapping2a["jo Np"] = {"iUN"}
			mapping3["b jo Np"] = {"p","i","iUN"}
			mapping3["b' jo Np"] = {"p","i","iUN"}
			mapping3["p jo Np"] = {"p_h","i","iUN"}
			mapping3["m jo Np"] = {"m","i","iUN"}
			mapping3["d jo Np"] = {"t","i","iUN"}
			mapping3["d' jo Np"] = {"t","i","iUN"}
			mapping3["t jo Np"] = {"t_h","i","iUN"}
			mapping3["n jo Np"] = {"n","i","iUN"}
			mapping3["D jo Np"] = {"n","i","iUN"}
			mapping3["r jo Np"] = {"l","i","iUN"}
			mapping3["l jo Np"] = {"l","i","iUN"}
			mapping3["c jo Np"] = {"ts\\","i","iUN"}
			mapping3["c' jo Np"] = {"ts\\","i","iUN"}
			mapping3["ch jo Np"] = {"ts\\","i","iUN"}
		mapping2a["ju Np"] = {"y_n", "@N"}
			mapping3["b ju Np"] = {"p","i","iUN"}
			mapping3["b' ju Np"] = {"p","i","iUN"}
			mapping3["p ju Np"] = {"p_h","i","iUN"}
			mapping3["m ju Np"] = {"m","i","iUN"}
			mapping3["d ju Np"] = {"t","i","iUN"}
			mapping3["d' ju Np"] = {"t","i","iUN"}
			mapping3["t ju Np"] = {"t_h","i","iUN"}
			mapping3["n ju Np"] = {"n","y","y_n @N"}
			mapping3["D ju Np"] = {"n","y","y_n @N"}
			mapping3["r ju Np"] = {"l","y","y_n @N"}
			mapping3["l ju Np"] = {"l","y","y_n @N"}
			mapping3["c ju Np"] = {"ts\\","y_n","@N"}
			mapping3["c' ju Np"] = {"ts\\","y_n","@N"}
			mapping3["ch ju Np"] = {"ts\\","y_n","@N"}
		mapping2a["ue Np"] = {"u@_n"}
		mapping2a["u7 Np"] = {"u@_n","@N"}
			mapping3["b ue Np"]	=	{"p","u","@_n"}
			mapping3["b u7 Np"]	=	{"p","u","@_n @N"}
			mapping3["b' ue Np"]	=	{"p","u","@_n"}
			mapping3["b' u7 Np"]	=	{"p","u","@_n @N"}
			mapping3["p ue Np"]	=	{"p_h","u","@_n"}
			mapping3["p u7 Np"]	=	{"p_h","u","@_n @N"}
			mapping3["m ue Np"]	=	{"m","u","@_n"}
			mapping3["m u7 Np"]	=	{"m","u","@_n @N"}
			mapping3["n ue Np"]	=	{"n","u","@_n"}
			mapping3["n u7 Np"]	=	{"n","u","@_n @N"}
			mapping3["D ue Np"]	=	{"n","u","@_n"}
			mapping3["D u7 Np"]	=	{"n","u","@_n @N"}
		mapping2a["ui Np"] = {"u", "iN"}
		mapping2a["Mi Np"] = {"u", "iN"}
			mapping3["sh ui Np"]	=	{"ts\\_h","iN"}
			mapping3["sh' ui Np"]	=	{"ts\\","iN"}
		mapping2a["i Np"] = {"iN"}
			mapping3["c i Np"]	= {"ts\\","iN"}
			mapping3["c' i Np"]	= {"ts\\","iN"}
			mapping3["ch i Np"]	= {"ts\\","iN"}
	
	mapping["@r"]	= "@`"
	mapping["C"]	= "ts"
	mapping["z"]	= "ts"
	mapping["v"]	= "u"

	mapping["Sil"]	= "Sil"

	-- get list of notes
	VSSeekToBeginNote()
	idx = 1
	retCode, noteEx = VSGetNextNoteEx()
	while (retCode == 1) do
		noteExList[idx] = noteEx
		retCode, noteEx = VSGetNextNoteEx()
		idx = idx + 1
	end

	-- check if empty
	noteCount = table.getn(noteExList)
	if (noteCount == 0) then
		VSMessageBox("No notes to process!", 0)
		return 0
	end
	
	-- check Job Plugin can lock phoneme
	local bPhLock = canPhLock(noteExList[1])
	
	-- transform notes
	for idx = 1, noteCount do
		local updNoteEx = {}
		updNoteEx = noteExList[idx]
		
		-- split on whitespace
		local phns = {}
		for token in string.gmatch(updNoteEx.phonemes, "[^%s]+") do
			 table.insert(phns, token)
		end
		
		-- do phoneme-by-phoneme mapping
		for i = 1, table.getn(phns) do
			-- try exceptions first
			local mapped = false
			if i+2 <= table.getn(phns) then
		        threephn = phns[i] .. " " .. phns[i+1] .. " " .. phns[i+2]
		        if mapping3[threephn] then
					phns[i] = mapping3[threephn][1]
					phns[i+1] = mapping3[threephn][2]
					phns[i+2] = mapping3[threephn][3]
					mapped = true
				end
			end

			if not mapped then
				if i+1 <= table.getn(phns) then
					twophn = phns[i] .. " " .. phns[i+1]
					if mapping2a[twophn] then
						phns[i] = mapping2a[twophn][1]
						phns[i+1] = mapping2a[twophn][2]
						-- (in this case no need to increment i because mapping2[twophn][2] is always "i", so will map to "i" on next iteration)
						mapped = true -- there's no continue in lua
					end
				end
			end
			
			if not mapped then
				if i+1 <= table.getn(phns) then
					twophn = phns[i] .. " " .. phns[i+1]
					if mapping2[twophn] then
						phns[i] = mapping2[twophn][1]
						phns[i+1] = mapping2[twophn][2]
						-- (in this case no need to increment i because mapping2[twophn][2] is always "i", so will map to "i" on next iteration)
						mapped = true -- there's no continue in lua
					end
				end
			end
			-- general mapping second
			if not mapped then
				if mapping[phns[i]] then
					phns[i] = mapping[phns[i]]
				end
			end
		end
		
		-- join by space
		updNoteEx.phonemes = table.concat(phns, " ");
		
		-- Do phoneme lock
		if (bPhLock) then
			updNoteEx.phLock = 1
		end		
		
		-- update note
		retCode = VSUpdateNoteEx(updNoteEx);
		if (retCode ~= 1) then
			VSMessageBox("Failed to update note!", 0)
			return 1
		end
	end

	-- Success
	return 0
end

-- Check if note has phLock property (only in newer API, Editor 3.0.5+)
function canPhLock(note)
	local status = false

	for key, val in pairs(note) do
		if (key == "phLock") then
			status = true
			break
		end
	end
	
	return status
end