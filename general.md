---
nav_order: 3
---

# General Job-Plugin support / 通用插件支持

{: .new }
> We strongly recommend that you use general Job-Plugin to simplify operations, General Job-Plugin greatly simplified usage.  
> 我们强烈建议您使用通用插件以简化操作，通用插件的出现大大简化了操作步骤。  


## General cross-lingual Job Plugin / 通用跨语种插件

Folder `/dict`is compatible with [General cross-lingual Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7732403/) by [atonyxu](https://github.com/atonyxu).  
`/dict`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[通用跨语种插件](https://www.bilibili.com/read/cv7732403/)相兼容。  

However, there are a few more operations that need to be done for some of the inter-language conversions(mostly when converted to Chinese).  
然而，对于一些语言之间的转换，还有一些步骤需要完成（多数为转换至中文时）。

First, open `通用跨语种插件.lua` and add lines after these contents:  
首先，打开 `通用跨语种插件.lua` 并在这些内容后添加行：  

line 34:

```lua
    local mapping3 = {}
```

![line 34](/assets/line34.png)

line 72:

```lua
        elseif lineData[1] == '3' then
            mapping3[lineData[2]] = lineData[3]
```

![line 72](/assets/line72.png)

line 103:

```lua
            if i + 2 <= table.getn(phns) then
                threephn = phns[i] .. " " .. phns[i + 1] .. " " .. phns[i + 2]
                if mapping3[threephn] then
                    phns[i] = mapping3[threephn]
                    phns[i + 1] = ""
                    phns[i + 2] = ""
                    mapped = true
                end
            end

            if not mapped then
```

![line 103](/assets/line103.png)

line 122:

```lua
            end
```

![line 122](/assets/line122.png)

After adding, save and re-add the Job-Plugin and now you can finish converting.  
添加完这些后，保存并重新添加工作插件，现在就可以完成转换了。

## General user dictionary Job Plugin / 用户词典插件

Folder `/dict-udc`is compatible with [General user dictionary Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7736635/) by [atonyxu](https://github.com/atonyxu).  
`/dict-udc`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[用户词典插件](https://www.bilibili.com/read/cv7732403/)相兼容。

For languages like Chinese and Japanese, it is relatively easier to use the user dictionary plugin.This project offer user dictionary which can let other voicebanks singing Chinese and Japanese.  
对于像中文和日语这样的语言来说，采用用户词典插件会相对好用一些。本项目提供使其他声库唱出中文和日语的用户词典。