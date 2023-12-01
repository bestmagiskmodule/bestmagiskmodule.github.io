function search() {
            var searchTerm = document.getElementById("searchTerm").value;
            var url = "https://magiskflash.com/?search=" + encodeURIComponent(searchTerm);
            window.location.href = url;
        }
	
        
