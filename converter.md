---
layout: default
title: Dictionary Converter 字典转换器
nav_order: 6
--- 
  
# Dictionary Converter 字典转换器   
  
{: .new }
> 您可以将传统字典上传并转换为适用于通用插件的字典，或者直接粘贴字典的mapping部分进行转换。    
> You can upload a traditional dictionary and convert it into a dictionary that is suitable for general plugins, or directly paste the mapping part of the dictionary for conversion.    

<textarea id="inputText" rows="10" cols="85" placeholder="Paste your dictionary here...  请粘贴您的字典…"></textarea>    
<input type="file" id="fileInput" class="btn" accept=".lua" />{: .btn .btn }
<button type="button" name="button" class="btn" onclick="uploadAndConvert()">Upload / Convert 上传 / 转换</button>{: .btn .btn-blue }
  
### Resulting Output 输出结果    
<textarea id="outputText" rows="10" cols="85" readonly></textarea>    
<button type="button" name="button" class="btn" onclick="downloadResult()">Download 下载</button>{: .btn .btn-purple }  
  
<script src="converter.js"></script>