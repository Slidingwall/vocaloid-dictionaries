function convert() {  
    // 这里我们假设convert函数处理粘贴的文本，而不是文件上传  
    const inputText = document.getElementById('inputText').value;  
    let lines = inputText.split(/\r\n|\n/);  
    let csv = 'Index,Key,Value\n';  
    let index = 1;  
  
    lines.forEach(line => {  
        // 匹配第一种格式：mapping["key"]="value"  
        const simpleMatch = line.match(/mapping\d*\[\"([^\"]*)\"\]\s*=\s*\"([^\"]*)\"/);  
        if (simpleMatch) {  
            const key = simpleMatch[1];  
            const value = simpleMatch[2];  
            csv += `${index++},${key},${value}\n`;  
        }  
  
        // 匹配第二种格式：mappingN["key"]="{value1, value2, ...}"  
        const complexMatch = line.match(/mapping\d*\[\"([^\"]*)\"\]\s*=\s*\{([^\}]*)\}/);  
        if (complexMatch) {  
            const key = complexMatch[1];  
            const values = complexMatch[2].split(/,\s*/); // 分割值和去除多余的空格  
            values.forEach(value => {  
                csv += `${index++},${key},${value.replace(/\"/g, '')}\n`; // 去除可能的引号  
            });  
            // 如果需要每个mappingN作为一个整体只占用一行索引，可以重置index  
            // 但通常我们不会在这里重置，除非有特别需求  
        }  
    });  
  
    document.getElementById('outputText').value = csv;  
}  
  
function uploadAndConvert() {  
    const file = document.getElementById('fileInput').files[0];  
    if (!file) {  
        alert('Please select a file to upload.');  
        return;  
    }  
    const fileName = file.name.toLowerCase();  
    if (!fileName.endsWith('.lua')) {  
        alert('Unsupported file type. Please upload a Lua file.');  
        return;  
    }
    const reader = new FileReader();  
    reader.onload = function(e) {  
        console.log('File loaded:', e.target.result); 
        document.getElementById('inputText').value = e.target.result;  
        convert(); 
    };  
    reader.readAsText(file); 
}

function downloadResult() {  
    const csvContent = document.getElementById('outputText').value;  
    const blob = new Blob([csvContent], { type: 'text/plain' });  
    const downloadLink = document.createElement('a');  
    downloadLink.href = URL.createObjectURL(blob);  
    downloadLink.download = 'output.txt';  
    document.body.appendChild(downloadLink);  
    downloadLink.click();  
    document.body.removeChild(downloadLink);  
}  