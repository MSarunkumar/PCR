/**
 * 
 */

	window.onscroll = function() { myFunction(); };

		var elem = document.getElementById("elem");
		
		var sticky = elem.offsetTop;
        
		function myFunction() {
			if (window.pageYOffset >= sticky) {
				elem.classList.add("sticky")
			} else {
				elem.classList.remove("sticky");
			}
		}
			