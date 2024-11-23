function output(text) {document.getElementById('outputText').value = text}  
function csvClean(value) {return value.trim().replace(/\\\\/g, '\\').replace(/"/g, '')}    
function convert(inputText) {  
    const csvLines = [];
    inputText.split(/\r\n|\n/).forEach(line => {  
        line = line.trim();  
        if (line.startsWith('mapping["')) {  
            const [, key, value] = line.match(/^mapping\["([^"]*)"\]\s*=\s*"([^"]*)"/);  
            csvLines.push(`1,${csvClean(key)},${csvClean(value)}`);  
        } else if (/^(mapping2|mapping3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/.test(line)) {  
            const [, type, key, value] = line.match(/^(mapping2|mapping3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/);  
            const values = value.split(/,\s*/).map(csvClean).join(' ');
            csvLines.push(`${type === 'mapping2' ? '2' : '3'},${csvClean(key)},${values}`);  
        }  
    });  
    output(csvLines.join('\n'));  
  } 
function uploadAndConvert() {
    const file = document.getElementById('fileInput').files[0];
    const inputText = document.getElementById('inputText').value.trim();
    if (!file && !inputText) output('Please select a file to upload or enter text.');
    if (file && !/\.lua$/i.test(file.name)) return output('Unsupported file type. Please upload a Lua file.');
    if (file) {  
        const reader = new FileReader();  
        reader.onload = e => {convert(e.target.result); document.getElementById('inputText').value=e.target.result;}; 
        reader.readAsText(file);  
    } else convert(inputText); 
}  
function downloadResult() {  
    const blob = new Blob([document.getElementById('outputText').value], { type: 'text/plain' });  
    const downloadLink = document.createElement('a');  
    downloadLink.href = URL.createObjectURL(blob);  
    downloadLink.download = `${(document.getElementById('fileInput').files[0]?.name.split('.')[0] || 'output')}.txt`;  
    downloadLink.click();  
    URL.revokeObjectURL(downloadLink.href);  
}