function convert() {  
    var inputText = document.getElementById('inputText').value;  
    var outputTextElement = document.getElementById('outputText');  
    if (!inputText) {  
        outputTextElement.value = 'Input cannot be empty.';  
        return;  
    }  
    let csv = '';  
    const lines = inputText.split(/\r\n|\n/);  
    lines.forEach((line) => {  
        line=line.trim()
        const simpleMatch = line.match(/^mapping\["([^"]*)"\]\s*=\s*"([^"]*)"/);  
        if (simpleMatch) {  
            const key = simpleMatch[1]; 
            const value = simpleMatch[2].replace(/\\\\/g, '\\').replace(/\"/g, '');
            csv += `1,${key},${value}\n`;  
        }  
        const complexMatch = line.match(/^(mapping2|mapping3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/);  
        if (complexMatch) {  
            const type = complexMatch[1];  
            const key = complexMatch[2];  
            const valuesStr = complexMatch[3];  
            const values = valuesStr.split(/,\s*/).map(value => value.replace(/\\\\/g, '\\').replace(/\"/g, '').trim());  
          
            values.forEach(value => {  
                csv += `${type === 'mapping2' ? '2' : '3'},${key},${value}\n`;  
            });  
        }   
    });  
    outputTextElement.value = csv;  
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