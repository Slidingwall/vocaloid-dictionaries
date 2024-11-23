function setOutputText(text) {  
    document.getElementById('outputText').value = text;  
}  
function escapeCsvValue(value) {  
    return value.trim().replace(/\\\\/g, '\\').replace(/"/g, '');  
}    
function convert(inputText) {  
    const csvLines = [];
    inputText.split(/\r\n|\n/).forEach(line => {  
        line = line.trim();  
        if (line.startsWith('mapping["')) {  
            const [, key, value] = line.match(/^mapping\["([^"]*)"\]\s*=\s*"([^"]*)"/);  
            csvLines.push(`1,${escapeCsvValue(key)},${escapeCsvValue(value)}`);  
        } else if (/^(mapping2|mapping3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/.test(line)) {  
            const [, type, key, valuesStr] = line.match(/^(mapping2|mapping3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/);  
            const values = valuesStr.split(/,\s*/).map(escapeCsvValue).join(' ');
            csvLines.push(`${type === 'mapping2' ? '2' : '3'},${escapeCsvValue(key)},${values}`);  
        }  
    });  
    setOutputText(csvLines.join('\n'));  
  } 
function uploadAndConvert() {
    const file = document.getElementById('fileInput').files[0];
    const inputText = document.getElementById('inputText').value.trim();
    if (!file && !inputText) setOutputText('Please select a file to upload or enter text.');
    if (file && !file.name.toLowerCase().endsWith('.lua')) return setOutputText('Unsupported file type. Please upload a Lua file.');
    (file ? new FileReader().readAsText(file).then(result => document.getElementById('inputText').value = result && result) : Promise.resolve(inputText))
        .then(convert)
        .catch(error => setOutputText(`An error occurred: ${error.message}`));
}  
function downloadResult() {  
    const blob = new Blob([document.getElementById('outputText').value], { type: 'text/plain' });  
    const downloadLink = document.createElement('a');  
    downloadLink.href = URL.createObjectURL(blob);  
    downloadLink.download = `${(document.getElementById('fileInput').files[0]?.name.split('.')[0] || 'output')}.txt`;  
    downloadLink.click();  
    URL.revokeObjectURL(downloadLink.href);  
}