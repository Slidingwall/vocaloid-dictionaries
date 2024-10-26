---
nav_order: 2
---

# How to use & General Job-Plugin support 如何使用&通用插件支持

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


## General cross-lingual Job Plugin 通用跨语种插件

Folder `/dict`is compatible with [General cross-lingual Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7732403/) by [atonyxu](https://github.com/atonyxu).  
`/dict`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[通用跨语种插件](https://www.bilibili.com/read/cv7732403/)相兼容。  

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

## Install and use the dictionary 安装并使用字典

{: .important}
> The native user dictionary only supports English. For other languages, you should use General user dictionary Job plugin.  
> 原生的用户字典仅支持英文。对于其他语言，您应该采用用户字典插件。

Click on `Lyrics`-->`User Dictionary` to open the `User Word Dictionary` window.  
点击`歌词`-->`用户字典`，打开`用户词注册`窗口。  
![open the User Word Dictionary window](/assets/udc1.webp)

Click on `Import` and select the user dictionary to be added in the window and click on `Open`.  
点击`导入`，并在窗口中选中要添加的用户字典，点击`打开`。  
![select the user dictionary](/assets/udc2.webp)

Once the import is complete, the dictionary can be selected in the list and used.  
导入完成后，即可在列表中选中字典并使用。  
![dictionary can be selected in the list](/assets/udc3.webp)

## General user dictionary Job Plugin 用户词典插件

Folder `/dict-udc`is compatible with [General user dictionary Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7736635/) by [atonyxu](https://github.com/atonyxu).  
`/dict-udc`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[用户词典插件](https://www.bilibili.com/read/cv7732403/)相兼容。

For languages like Chinese and Japanese, it is relatively easier to use the user dictionary plugin.This project offer user dictionary which can let other voicebanks singing Chinese and Japanese.  
对于像中文和日语这样的语言来说，采用用户词典插件会相对好用一些。本项目提供使其他声库唱出中文和日语的用户词典。  

