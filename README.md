# vocaloid-dictionaries

Interlingual user dictionaries and Job Plugins for VOCALOID.
VOCALOID的跨语种用户字典和任务插件。  

Visit our [GitHub Pages](https://slidingwall.github.io/vocaloid-dictionaries), or see the companion repository [for Synthesizer V](https://github.com/Slidingwall/synthv-dictionaries)  
访问我们的[GitHub 页面](https://slidingwall.github.io/vocaloid-dictionaries)，或是看看适用于Synthesizer V的[姐妹项目](https://github.com/Slidingwall/synthv-dictionaries)！

Demos can be listened right [here](https://slidingwall.github.io/vocaloid-dictionaries/demo).
音频样本可以在[这里](https://slidingwall.github.io/vocaloid-dictionaries/demo)听到。

## Universal Lyric Fliiling Plugin 万能填词插件

(WIP)Because I forgot the development progress, support for some languages may not be complete yet.  
(开发中)由于我忘记了开发进度，部分语言的支持可能尚未完成。  

This plugin is modified from the user dictionary plugin and serves as an implementation of a third-party Grapheme-to-Phoneme system. It enables cross-lingual conversion directly during the lyrics input process.   
这个插件基于用户字典插件修改而来，是一个第三方单词到音素系统的实现，用于直接在填词的过程中完成跨语种转换的操作。  

The plugin will automatically detect the singer's language and the number of available notes for lyrics input. After entering the lyrics, you need to manually select the language of the entered lyrics. The plugin will then handle the remaining conversion tasks.  
插件将会自动识别歌手语言和可填词音符的个数。填入歌词后，您需要手动选择填入歌词的语言，随后由插件完成剩余的转换工作。  

## General Cross-language Plugin SE 通用跨语种插件SE

We strongly recommend that you use general Job-Plugin to simplify operations, General Job-Plugin greatly simplified usage.  
我们强烈建议您使用通用插件以简化操作，通用插件的出现大大简化了操作步骤。  

**Due to the update of new features, former plugins have now been moved to the `archived` folder.**  
**由于新功能的更新，先前的插件现已移至`archived`文件夹中。**   

Building on the [General cross-lingual Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7732403/) created by [atonyxu](https://github.com/atonyxu), we have modified it into another version (referred to as SE, the second edition). This new version allows the dictionary to only provide simple conversion rules, while leaving the checking of unsupported CV pronunciations and phoneme splitting to the plugin automatically.  
我们在[atonyxu](https://github.com/atonyxu)制作的[通用跨语种插件](https://www.bilibili.com/read/cv7732403/)的基础上再次修改了一版插件（称之为SE，第二版），让字典仅提供简单的转换规则，将不支持的CV发音与拆音交由插件自动检查。

|VB \ Lyrics |CHN Lyrics|ENG Lyrics|JPN Lyrics|KOR Lyrics|ESP Lyrics|
|:----:|:----:|:----:|:----:|:----:|:----:|
|CHN VB|N/A|√|√|√|√|
|ENG VB|√|N/A|√|√|√|
|JPN VB|√|√|N/A|√|v|
|KOR SeeU|√|√|√|N/A|√|
|KOR UNI|√|√|√|N/A|√|
|ESP VB|√|√|√|√|N/A|
|MAIKA|√|√|√|√|N/A|

## Dictionaries for General user dictionary Job Plugin 用户字典插件字典

Folder `/dict-udc`is compatible with [General user dictionary Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7736635/) by [atonyxu](https://github.com/atonyxu).  
`/dict-udc`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[用户词典插件](https://www.bilibili.com/read/cv7732403/)相兼容。
  
> `FBO` = **F**inished **B**y **O**thers / 由他人完成  

| Lyrics \ VB | CHN VB | ENG VB | JPN VB | KOR VB | ESP VB | MAIKA |
|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
| CHN Lyrics | N/A | √ | √ | √ | √ | √ |
| JPN Lyrics | √ | FBO | N/A | √ | √ | √ |

## Other Plugins 其他插件
### Find & Replace Phonemes Job Plugin 音素查找与替换插件

Based on the official Yamaha `convertPhonemes.lua`, an option for perfect matching has been added.
基于Yamaha官方的`convertPhonemes.lua`，增加了一个用于完全匹配的选项。

**Any contributions are welcome. / 欢迎任何形式的贡献**  

---

Author: Slidingwall ([Bilibili](https://space.bilibili.com/141232009))  
作者：Slidingwall（[哔哩哔哩](https://space.bilibili.com/141232009)）  

---
