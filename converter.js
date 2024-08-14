function convert() {   
    const lines = document.getElementById('inputText').value.split(/\r\n|\n/);  
    let csv = 'Index,Key,Value\n';  
    let index = 1;  
  
    let mapping = {};  
    let mapping2 = {};  
    let mapping3 = {};  
  
    lines.forEach(line => {  
        // 处理简单的键值对映射  
        const simpleMatch = line.match(/^mapping\["([^"]*)"\]\s*=\s*"([^"]*)"/);  
        if (simpleMatch) {  
            const key = simpleMatch[1];  
            const value = simpleMatch[2];  
            mapping[key] = value;  
        }  
  
        // 处理映射到值数组的映射（mapping2 和 mapping3）  
        const complexMatch = line.match(/^(mapping2|mapping3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/);  
        if (complexMatch) {  
            const type = complexMatch[1]; // 区分是 mapping2 还是 mapping3  
            const key = complexMatch[2];  
            const valuesStr = complexMatch[3];  
            const values = valuesStr.split(/,\s*/).map(value => value.replace(/\"/g, '').replace(/I0/g, 'I')); // 替换 "I0" 为 "I"（如果需要）  
            if (type === 'mapping2') {  
                mapping2[key] = values;  
            } else if (type === 'mapping3') {  
                mapping3[key] = values;  
            }  
        }  
    });  
  
    // 处理简单的键值对映射  
    Object.keys(mapping).forEach(key => {  
        csv += `${index++},${key},${mapping[key]}\n`;  
    });  
  
    // 处理映射到值数组的映射（mapping2）  
    Object.keys(mapping2).forEach(key => {  
        mapping2[key].forEach(value => {  
            csv += `${index++},${key},${value}\n`;  
        });  
    });  
  
    // 处理映射到值数组的映射（mapping3）  
    Object.keys(mapping3).forEach(key => {  
        mapping3[key].forEach(value => {  
            csv += `${index++},${key},${value}\n`;  
        });  
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