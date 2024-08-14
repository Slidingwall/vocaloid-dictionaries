function convertLuaToCsv() {  

	    const input = document.getElementById('luaFile');  

	    if (input.files && input.files[0]) {  

	        const reader = new FileReader();  

	  

	        reader.onload = function(e) {  

	            const content = e.target.result;  

	            const lines = content.split(/\r\n|\n/);  

	            let csv = '';  

	  

	            lines.forEach(line => {  

	                // 假设格式如 mapping["key"]="value"  

	                const match = line.match(/mapping\d*\[\"([^\"]*)\"\]=\"([^\"]*)\"/);  

	                if (match) {  

	                    const key = match[1];  

	                    const value = match[2].replace(/，/g, ','); // 替换中文逗号  

	                    csv += `${key},${value}\n`;  

	                }  

	            });  

	  

	            document.getElementById('csvOutput').value = csv;  

	            const downloadLink = document.getElementById('downloadLink');  

	            downloadLink.href = URL.createObjectURL(new Blob([csv], { type: 'text/csv' }));  

	            downloadLink.style.display = 'block';  

	        };  

	  

	        reader.readAsText(input.files[0]);  

	    }  

	}