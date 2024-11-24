function output(text) {document.getElementById('outputText').value = text}  
function convert(input) {  
    const clean = value => value.trim().replace(/\\\\/g, '\\').replace(/"/g, '');
    const csv = input.split(/\r\n|\n/).map(line => {  
        line = line.trim();  
        const match1 = line.match(/^mapping\["([^"]*)"\]\s*=\s*"([^"]*)"/);
        const match23 = line.match(/^mapping(2|3)\["([^"]*)"\]\s*=\s*\{([^}]*)\}/);
        if (match1) {return `1,${clean(match1[1])},${clean(match1[2])}`} 
        else if (match23) {return `${match23[1]},${clean(match23[2])},${match23[3].split(/,\s*/).map(clean).join(' ')}`}  
        else {return null}
    }).filter(Boolean);  
    output(csv.join('\n'));  
  } 
function uploadAndConvert() {
    const file = document.getElementById('fileInput').files[0];
    const input = document.getElementById('inputText').value.trim();
    if (!file && !input) {return output('Please select a file to upload or enter text.')}
    else if (file && /\.lua$/.test(file.name.toLowerCase())){  
        const reader = new FileReader();  
        reader.onload = e => {convert(e.target.result); document.getElementById('inputText').value=e.target.result}; 
        reader.readAsText(file) 
    } else if (input) {convert(input)} else {return output('Unsupported file type. Please upload a Lua file.')}
}  
function downloadResult() {  
    const blob = new Blob([document.getElementById('outputText').value], { type: 'text/plain' });  
    const link = document.createElement('a');  
    link.href = URL.createObjectURL(blob);  
    link.download = `${(document.getElementById('fileInput').files[0]?.name.split('.')[0] || 'output')}.txt`;  
    link.click();  
    URL.revokeObjectURL(link.href)
}