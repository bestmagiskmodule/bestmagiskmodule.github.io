function search() {
            var searchTerm = document.getElementById("searchTerm").value;
            var url = "https://www.google.com/search?q=www.magiskflash.com " + encodeURIComponent(searchTerm);
            window.location.href = url;
        }
	
        
