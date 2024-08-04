# vocaloid-dictionaries

Interlingual user dictionaries and Job Plugins for VOCALOID.
VOCALOID的跨语种用户字典和任务插件。  

Visit our [GitHub Pages](https://slidingwall.github.io/vocaloid-dictionaries), or see the companion repository [for Synthesizer V](https://github.com/Slidingwall/synthv-dictionaries)  
访问我们的[GitHub 页面](https://slidingwall.github.io/vocaloid-dictionaries)，或是看看适用于Synthesizer V的[姐妹项目](https://github.com/Slidingwall/synthv-dictionaries)！

## General Job-Plugin support / 通用插件支持

We strongly recommend that you use general Job-Plugin to simplify operations, General Job-Plugin greatly simplified usage.  
我们强烈建议您使用通用插件以简化操作，通用插件的出现大大简化了操作步骤。  

Folder `/dict`is compatible with [General cross-lingual Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7732403/) by [atonyxu](https://github.com/atonyxu). We have newly added a cross-language syllable splitting function on top of its existing capabilities. [See here for details.](https://slidingwall.github.io/vocaloid-dictionaries/general)  
`/dict`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[通用跨语种插件](https://www.bilibili.com/read/cv7732403/)相兼容。我们在其基础上新增加了跨语种拆音功能。[详情见此。](https://slidingwall.github.io/vocaloid-dictionaries/general)  

Folder `/dict-udc`is compatible with [General user dictionary Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7736635/) by [atonyxu](https://github.com/atonyxu).  
`/dict-udc`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[用户词典插件](https://www.bilibili.com/read/cv7732403/)相兼容。

## How to use 如何使用

Traditional Plugins are now in `archived` folder. The first language in the file name represents the language used in the project file, i.e. the language you want the voicebank to sing in; the second language is the language used by the voicebank.
传统插件现已移至`archived`文件夹中。文件名里的第一个语言代表工程文件所使用的语言，即你想让语音库唱出的语言；第二个语言则是语音库所使用的语言。

`*.lua`is Job-Plugin file for VOCALOID, and `*.udc`is User word dictionary file for VOCALOID (English Voice Library only).  
 `*.lua`文件可作为VOCALOID的任务插件导入，`*.udc`文件可作为VOCALOID的用户字典导入（仅支持英文声库）。  

For detail instruction, please see the manual on our [GitHub Pages](https://slidingwall.github.io/vocaloid-dictionaries/manual).  
详细教程，请查看[GitHub Pages](https://slidingwall.github.io/vocaloid-dictionaries/manual)。  

## Released Dictionaries 已公开字典

Demos can be listened right [here](https://slidingwall.github.io/vocaloid-dictionaries/demo).
音频样本可以在[这里](https://slidingwall.github.io/vocaloid-dictionaries/demo)听到。

### General Plugin Dictionaries 通用插件字典

> `CLG` = Dictionaries for General cross-lingual Job Plugin / 通用跨语种插件字典
> `UDC` = Dictionaries for General user dictionary Job Plugin / 用户字典插件字典
> `FBO` = **F**inished **B**y **O**thers / 由他人完成

|VB \ Lyrics |CHN Lyrics|ENG Lyrics|JPN Lyrics|KOR Lyrics|ESP Lyrics|
|:----:|:----:|:----:|:----:|:----:|:----:|
|CHN VB|N/A| |UDC|CLG|CLG|
|ENG VB|CLG UDC|N/A|UDC|CLG|CLG|
|JPN VB|UDC|FBO|N/A|FBO|FBO|
|KOR VB|UDC| |UDC|N/A| |
|ESP VB|CLG UDC|CLG|UDC|CLG|N/A|
|MAIKA|CLG UDC|FBO|UDC|CLG|N/A|

### Traditional Dictionaries 传统字典

> `FBO` = **F**inished **B**y **O**thers / 由他人完成  

|VB \ Lyrics |CHN Lyrics|ENG Lyrics|JPN Lyrics|KOR Lyrics|ESP Lyrics|
|:----:|:----:|:----:|:----:|:----:|:----:|
|CHN VB|N/A|√|FBO|√|√|
|ENG VB|√|N/A|FBO|√|√|
|JPN VB|FBO|FBO|N/A|FBO|FBO|
|KOR VB|FBO|FBO|FBO|N/A|FBO|
|ESP VB|√|√|FBO|√|N/A|
|MAIKA|√|FBO|FBO|√|N/A|

**Any contributions are welcome. / 欢迎任何形式的贡献**  

---

Author: Slidingwall ([Bilibili](https://space.bilibili.com/141232009))  
作者：Slidingwall（[哔哩哔哩](https://space.bilibili.com/141232009)）  

---
