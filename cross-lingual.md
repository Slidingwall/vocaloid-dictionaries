---
nav_order: 2
---

# Cross-lingual Job-Plugin 跨语种插件

1. TOC
{:toc}

{: .new }
> We strongly recommend that you use general Job-Plugin to simplify operations, General Job-Plugin greatly simplified usage.  
> 我们强烈建议您使用通用插件以简化操作，通用插件的出现大大简化了操作步骤。  
> You can use [converter](/vocaloid-dictionaries/converter) to convert traditional Job-Plugin's Mapping part to Grneral Job-Plugin's dictionary.  
> 您可以用[转换器](/vocaloid-dictionaries/converter)将传统插件的Mapping部分转换为通用插件可用的字典。  

{: .warning}
> Job Plugin is no longer supported in Vocaloid 5 and 6 , the project needs to be converted in Vocaloid 3 or 4 first.  
> Vocaloid 5 与 6 不再支持 Job Plugin 插件，工程需要先在Vocaloid 3 或 4 中进行转换。
>
> Phonemes shaped like `a_0` are not converted by the plugin. You may need to refer to the [phoneme table](/vocaloid-dictionaries/phoneme) for manual conversion.  
> 形如`a_0`的音素并不能被插件转换。可能需要参考[音素表](/vocaloid-dictionaries/phoneme)进行手动转换。

## General cross-lingual Job Plugin 通用跨语种插件
{: .d-inline-block }
New
{: .label .label-green }

Folder `/dict`is compatible with [General cross-lingual Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7732403/) by [atonyxu](https://github.com/atonyxu).  
`/dict`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[通用跨语种插件](https://www.bilibili.com/read/cv7732403/)相兼容。  

{: .note }
> 
> `CLG` = [Dictionaries for General cross-lingual Job Plugin / 通用跨语种插件字典](https://github.com/Slidingwall/vocaloid-dictionaries/tree/main/dict)  
> `FBO` = **F**inished **B**y **O**thers / 由他人完成  
> **Bold Dictionaries are now support spliting. 加粗的字典现已支持拆音。**

|VB \ Lyrics |CHN Lyrics|ENG Lyrics|JPN Lyrics|KOR Lyrics|ESP Lyrics|
|:----:|:----:|:----:|:----:|:----:|:----:|
|CHN VB|N/A| |**CLG** |**CLG**|**CLG**|
|ENG VB|CLG |N/A||CLG|CLG|
|JPN VB|FBO|FBO|N/A|FBO|FBO|
|KOR VB|||FBO|N/A||
|ESP VB|CLG|CLG|FBO|CLG|N/A|
|MAIKA|CLG|FBO|FBO|CLG|N/A|

**We have newly added a cross-language syllable splitting function on top of its existing capabilities**. For this newly added feature, the corresponding dictionary rules are as follows:  
**我们在其基础上新增加了跨语种拆音功能。** 对于新增加的功能，它对应的字典规则如下：  

1. The first column indicates the number of phonemes to match: 1 represents matching one phoneme, 2 represents two, and 3 represents three. L and R represent left and right syllable splitting respectively, and will add a 1/64 note at the corresponding position.  
第一列表示匹配音素个数：1表示匹配1个音素，2表示2个，3表示3个。L和R分别代表左拆音和右拆音，会在对应位置增加一个1/64音符。  
2. The second column indicates the phonemes that need to be matched and replaced.  
第二列表示需要匹配替换的音素。  
3. The third column indicates the phonemes that will replace the matched ones. If syllable splitting is required, replace the space at the syllable splitting point with `#`.  
第三列表示将要替换成的音素。如果需要拆音，则将拆音点位置的空格替换为`#`。  

For example:  例如：  

```
L2,s i:,s i\#i
R2,r U,z` UN#-
L3,k j o,k 7#i@U
R3,a n k,a_n#k 7_0
```

![Effect in the Editor](/assets/general.png)

## Download traditional Job-Plugins  下载传统插件
{: .d-inline-block }
Archived 已存档
{: .label .label-red }

{: .note }
> Discontinued on August 4, 2024.  
> 自2024年8月4日起弃用。  
>
> `FBO` = **F**inished **B**y **O**thers / 由他人完成  

| **VB \ Lyrics** | CHN Lyrics | ENG Lyrics | KOR Lyrics | ESP Lyrics |
|:---:|:---:|:---:|:---:|:---:|
| **CHN VB** | N/A | [Eng2Chn.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Eng2Chn.lua) | [Kor2Chn.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Kor2Chn.lua) | [Esp2Chn.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Esp2Chn.lua) |
| **ENG VB** | [Chn2Eng.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Chn2Eng.lua) | N/A | [Kor2Eng.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Kor2Eng.lua) |[Esp2Eng.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Esp2Eng.lua)|
| **ESP VB** | [Chn2Esp.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Chn2Esp.lua) | [Eng2Esp.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Eng2Esp.lua) | [Kor2Esp.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Kor2Esp.lua) | N/A |
| **MAIKA** | [Chn2Esp++.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Chn2Esp%2B%2B.lua) | FBO | [Kor2Esp++.lua](https://github.com/Slidingwall/vocaloid-dictionaries/blob/main/archived/Kor2Esp%2B%2B.lua) | N/A |

## Install and use the plugin 安装并使用插件

Click on `Job`->`Manage Job Plugins` or press the shortcut `Crtl+Shift+J` to open the `Job Plugin Manager` window.  
点击`任务`-->`管理任务插件`，或按下快捷键`Crtl+Shift+J`，打开`任务插件管理`窗口。  
![open the Job Plugin Manager window](/assets/install1.webp)

Click `Add` and select the task plugin you want to add in the window and click `Open`.  
点击`添加`，并在窗口中选中要添加的任务插件，点击`打开`。  
![select the task plugin you want to add](/assets/install2.webp)

When you have finished adding, click `OK` to close the `Job Plugin Manager` window.  
添加完成后，点击`确定`关闭`任务插件管理`窗口。  
![finished adding](/assets/install3.webp)

After entering the lyrics in the original language singer, first select the Job Plugin you want to execute in `Job`->`Job Plugin` and execute it, then switch the singer.  
在用原始语言的歌手输入完歌词后，先在`任务`-->`任务插件`中选择要执行的任务插件并执行，再切换歌手。  
![select the Job Plugin you want to execute](/assets/install4.webp)




