function search() {
            var searchTerm = document.getElementById("searchTerm").value;
            var url = "https://google.com?search=magiskflash.com " + encodeURIComponent(searchTerm);
            window.location.href = url;
        }
	
        
