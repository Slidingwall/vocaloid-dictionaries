---
nav_order: 3
---

# General Job-Plugin support 通用插件支持

{: .new }
> We strongly recommend that you use general Job-Plugin to simplify operations, General Job-Plugin greatly simplified usage.  
> 我们强烈建议您使用通用插件以简化操作，通用插件的出现大大简化了操作步骤。  


## General cross-lingual Job Plugin 通用跨语种插件

Folder `/dict`is compatible with [General cross-lingual Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7732403/) by [atonyxu](https://github.com/atonyxu).  
`/dict`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[通用跨语种插件](https://www.bilibili.com/read/cv7732403/)相兼容。  

We have newly added a cross-language syllable splitting function on top of its existing capabilities. For this newly added feature, the corresponding dictionary rules are as follows:  
我们在其基础上新增加了跨语种拆音功能。对于新增加的功能，它对应的字典规则如下：  

1. The first column indicates the number of phonemes to match: 1 represents matching one phoneme, 2 represents two, and 3 represents three. L and R represent left and right syllable splitting respectively, and will add a 1/64 note at the corresponding position.  
第一列表示匹配音素个数：1表示匹配1个音素，2表示2个，3表示3个。L和R分别代表左拆音和右拆音，会在对应位置增加一个1/64音符。  
2. The second column indicates the phonemes that need to be matched and replaced.  
第二列表示需要匹配替换的音素。  
3. The third column indicates the phonemes that will replace the matched ones. If syllable splitting is required, replace the space at the syllable splitting point with `#`.  
第三列表示将要替换成的音素。如果需要拆音，则将拆音点位置的空格替换为`#`。  

For example:  例如：  

```csv
L2,s i:,s i\#i
R2,r U,z` UN#-
L3,k j o,k 7#i@U
R3,a n k,a_n#k 7_0
```
![Effect in the Editor](/assets/general.png)

## General user dictionary Job Plugin 用户词典插件

Folder `/dict-udc`is compatible with [General user dictionary Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7736635/) by [atonyxu](https://github.com/atonyxu).  
`/dict-udc`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[用户词典插件](https://www.bilibili.com/read/cv7732403/)相兼容。

For languages like Chinese and Japanese, it is relatively easier to use the user dictionary plugin.This project offer user dictionary which can let other voicebanks singing Chinese and Japanese.  
对于像中文和日语这样的语言来说，采用用户词典插件会相对好用一些。本项目提供使其他声库唱出中文和日语的用户词典。