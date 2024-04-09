---
nav_order: 2
---

# How to use / 如何使用

{: .warning}
> Job Plugin is no longer supported in Vocaloid 5 , the project needs to be converted in Vocaloid 3 or 4 first.
> Vocaloid 5 不再支持 Job Plugin 插件，工程需要先在Vocaloid 3 或 4 中进行转换。
>
> Phonemes shaped like `a_0` are not converted by the plugin. You may need to refer to the [phoneme table](/vocaloid-dictionaries/phoneme) for manual conversion.
> 形如`a_0`的音素并不能被插件转换。可能需要参考[音素表](/vocaloid-dictionaries/phoneme)进行手动转换。

- [How to use / 如何使用](#how-to-use--如何使用)
  - [Install and use the plugin / 安装并使用插件](#install-and-use-the-plugin--安装并使用插件)
  - [Install and use the dictionary / 安装并使用字典](#install-and-use-the-dictionary--安装并使用字典)
  - [General Job-Plugin support / 通用插件支持](#general-job-plugin-support--通用插件支持)
    - [General cross-lingual Job Plugin / 通用跨语种插件](#general-cross-lingual-job-plugin--通用跨语种插件)
    - [General user dictionary Job Plugin / 用户词典插件](#general-user-dictionary-job-plugin--用户词典插件)


## Install and use the plugin / 安装并使用插件

Click on `Job`->`Manage Job Plugins` or press the shortcut `Crtl+Shift+J` to open the `Job Plugin Manager` window.  
点击`任务`-->`管理任务插件`，或按下快捷键`Crtl+Shift+J`，打开`任务插件管理`窗口。  
![open the Job Plugin Manager window](/assets/install1.png)

Click `Add` and select the task plugin you want to add in the window and click `Open`.  
点击`添加`，并在窗口中选中要添加的任务插件，点击`打开`。  
![select the task plugin you want to add](/assets/install2.png)

When you have finished adding, click `OK` to close the `Job Plugin Manager` window.  
添加完成后，点击`确定`关闭`任务插件管理`窗口。  
![finished adding](/assets/install3.png)

After entering the lyrics in the original language singer, first select the Job Plugin you want to execute in `Job`->`Job Plugin` and execute it, then switch the singer.  
在用原始语言的歌手输入完歌词后，先在`任务`-->`任务插件`中选择要执行的任务插件并执行，再切换歌手。  
![select the Job Plugin you want to execute](/assets/install4.png)

## Install and use the dictionary / 安装并使用字典

Click on `Lyrics`-->`User Dictionary` to open the `User Word Dictionary` window.  
点击`歌词`-->`用户字典`，打开`用户词注册`窗口。  
![open the User Word Dictionary window](/assets/udc1.png)

Click on `Import` and select the user dictionary to be added in the window and click on `Open`.  
点击`导入`，并在窗口中选中要添加的用户字典，点击`打开`。  
![select the user dictionary](/assets/udc2.png)

Once the import is complete, the dictionary can be selected in the list and used.  
导入完成后，即可在列表中选中字典并使用。  
![dictionary can be selected in the list](/assets/udc3.png)

## General Job-Plugin support / 通用插件支持

### General cross-lingual Job Plugin / 通用跨语种插件

Folder `/dict`is compatible with [General cross-lingual Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7732403/) by [atonyxu](https://github.com/atonyxu).  
`/dict`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[通用跨语种插件](https://www.bilibili.com/read/cv7732403/)相兼容。  

General Job-Plugin greatly simplified usage.However, there are a few more operations that need to be done for some of the inter-language conversions(mostly when converted to Chinese).  
通用插件的出现大大简化了操作步骤。然而，对于一些语言之间的转换，还有一些步骤需要完成（多数为转换至中文时）。

First, open `通用跨语种插件.lua` and add lines after these contents:  
首先，打开 `通用跨语种插件.lua` 并在这些内容后添加行：  

line 34:

```
    local mapping3 = {}
```

![line 34](/assets/line34.png)

line 72:

```
        elseif lineData[1] == '3' then
            mapping3[lineData[2]] = lineData[3]
```

![line 72](/assets/line72.png)

line 103:

```
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

```
            end
```

![line 122](/assets/line122.png)

After adding, save and re-add the Job-Plugin and now you can finish converting.  
添加完这些后，保存并重新添加工作插件，现在就可以完成转换了。

### General user dictionary Job Plugin / 用户词典插件

Folder `/dict-udc`is compatible with [General user dictionary Job Plugin(Chinese Page)](https://www.bilibili.com/read/cv7736635/) by [atonyxu](https://github.com/atonyxu).  
`/dict-udc`文件夹中的文件与[atonyxu](https://github.com/atonyxu)制作的[用户词典插件](https://www.bilibili.com/read/cv7732403/)相兼容。


