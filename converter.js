function setOutputText(text) {  
    document.getElementById('outputText').value = text;  
}  
  
function convert() {  
    const inputText = document.getElementById('inputText').value;  
    if (!inputText) {  
        setOutputText('Input cannot be empty.');  
        return;  
    }  
    let csv = '';  
    inputText.split(/\r\n|\n/).forEach(line => {  
        line = line.trim();  
        if (line.startsWith('mapping["')) {  
            const [_, key, value] = line.match(/^mapping\["([^"]*)"\]\s*=\s*"([^"]*)"/);  
            csv += `1,"${key.replace(/\\/g, '\\\\').replace(/"/g, '\\"')}","${value.replace(/\\/g, '\\\\').replace(/"/g, '\\"')}"\n`;  
        } else if (line.startsWith(('mapping2' || 'mapping3') + '[')) {  
            const [_, type, key, valuesStr] = line.match(/^(mapping2|mapping3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/);  
            const values = valuesStr.split(/,\s*/).map(v => v.trim().replace(/\\/g, '\\\\').replace(/"/g, '\\"')).join(' ');  
            csv += `${type === 'mapping2' ? '2' : '3'},"${key}","${values}"\n`;  
        }  
    });  
    setOutputText(csv);  
}  
  
function uploadAndConvert() {  
    const file = document.getElementById('fileInput').files[0];  
    if (!file || !file.name.toLowerCase().endsWith('.lua')) {  
        setOutputText(file ? 'Unsupported file type. Please upload a Lua file.' : 'Please select a file to upload.');  
        return;  
    }  
    const reader = new FileReader();  
    reader.onload = e => {  
        document.getElementById('inputText').value = e.target.result;  
        convert();  
    };  
    reader.readAsText(file);  
}  
  
function downloadResult() {  
    const blob = new Blob([document.getElementById('outputText').value], { type: 'text/plain' });  
    const downloadLink = document.createElement('a');  
    downloadLink.href = URL.createObjectURL(blob);  
    downloadLink.download = 'output.txt';  
    downloadLink.dispatchEvent(new MouseEvent('click', {  
        'view': window,  
        'bubbles': true,  
        'cancelable': true  
    }));  
    URL.revokeObjectURL(downloadLink.href);  
}