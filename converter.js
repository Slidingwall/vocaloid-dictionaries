function convert() {  
    var inputText = document.getElementById('inputText').value;  
    var outputText = document.getElementById('outputText');  
    if (!inputText) {  
        outputText.value = 'Input cannot be empty.';  
        return;  
    }  
    let csv = '';  
    const lines = inputText.split(/\r\n|\n/);  
    lines.forEach((line) => {  
        line=line.trim()
        const simpleMatch = line.match(/^mapping\["([^"]*)"\]\s*=\s*"([^"]*)"/);  
        if (simpleMatch) {  
            const [_, key, value] = simpleMatch;  
            csv += `1,${key.replace(/\\\\/g, '\\').replace(/\"/g, '')},${value.replace(/\\\\/g, '\\').replace(/\"/g, '')}\n`;  
        }  
        const complexMatch = line.match(/^(mapping2|mapping3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/);  
        if (complexMatch) {  
            const [_, type, key, valuesStr] = complexMatch;  
            const values = valuesStr.split(/,\s*/).map(value => value.trim().replace(/\\\\/g, '\\').replace(/\"/g, '')).join(' ');  
            csv += `${type === 'mapping2' ? '2' : '3'},${key},${values}\n`;  
        }  
    });
    outputText.value = csv;  
}


function uploadAndConvert() {  
    const file = document.getElementById('fileInput').files[0];  
    if (!file) {  
        document.getElementById('outputText').value ='Please select a file to upload.';  
        return;  
    }  
    const fileName = file.name.toLowerCase();  
    if (!fileName.endsWith('.lua')) {  
        document.getElementById('outputText').value ='Unsupported file type. Please upload a Lua file.';  
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