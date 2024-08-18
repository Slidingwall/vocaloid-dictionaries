function setOutputText(text) {  
    document.getElementById('outputText').value = text;  
}  
  
function convert(inputText) {  
    let csv = '';  
    inputText.split(/\r\n|\n/).forEach(line => {  
        line = line.trim();  
        if (line.startsWith('mapping["')) {  
            const [_, key, value] = line.match(/^mapping\["([^"]*)"\]\s*=\s*"([^"]*)"/);  
            csv += `1,${escapeCsvValue(key)},${escapeCsvValue(value)}\n`;  
        } else if (/^(mapping2|mapping3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/.test(line)) {  
            const [, type, key, valuesStr] = line.match(/^(mapping2|mapping3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/);  
            const values = valuesStr.split(/,\s*/).map(v => escapeCsvValue(v)).join(' ');  
            csv += `${type === 'mapping2' ? '2' : '3'},${escapeCsvValue(key)},${escapeCsvValue(values)}\n`;  
        }  
    });  
    setOutputText(csv);  
}  
  
function escapeCsvValue(value) {  
    return value.trim().replace(/\\/g, '\\').replace(/"/g, '');  
}   
  
function uploadAndConvert() {  
    const file = document.getElementById('fileInput').files[0];  
    const inputText = document.getElementById('inputText').value.trim()
    if (!file && !inputText) {  
        setOutputText('Please select a file to upload or enter text.');  
        return;  
    }  
    if (file && !file.name.toLowerCase().endsWith('.lua')) {  
        setOutputText('Unsupported file type. Please upload a Lua file.');  
        return;  
    }
    if (file) {  
        const reader = new FileReader();  
        reader.onload = e => {convert(e.target.result); document.getElementById('inputText').value=e.target.result;}; 
        reader.readAsText(file);  
    } else {  
        convert(inputText);  
    }
}  
  
function downloadResult() {  
    const blob = new Blob([document.getElementById('outputText').value], { type: 'text/plain' });  
    const downloadLink = document.createElement('a');  
    downloadLink.href = URL.createObjectURL(blob);  
    downloadLink.download = 'output.txt';  
    downloadLink.click();  
    URL.revokeObjectURL(downloadLink.href);  
}