var imgSrc = "";

var imageArea = function() {
	$("#fileID").trigger("click");
}

var submitImage =  function() {
	$("#formID").submit();
}

$("#formID").submit(function(e) {
	
	var input = document.querySelector("input[type=file]");
	var reader = new FileReader();
	reader.readAsDataURL(input.files[0]);
	reader.onload = function (event) {
	     imgSrc = event.target.result;     
	}
	
	var companyID = $("#companyID").val().trim();
	
	//........................................... create form object
	//var formdata = new FormData($(this)[0]);
	
	var formdata = new FormData();
    var files = $("#fileID")[0].files[0];
    var file_name = files.name;
    
    //............................................. append the value of in form object 
    formdata.append("file",files);
    formdata.append("filename",file_name);
    formdata.append("company_id", companyID);
    
	$.ajax({
    type: "POST"  ,
    url: "../Model/task.cfc?method=updateLogo" ,
    contentType: false,
    processData: false,
    data: formdata,
    success:function(res)
         {
   	    	
   	    	if(res) {
   	    		$("#companyLogo").attr("src", imgSrc);
   	    	}
   	    	else {
   	    		console.log("DB Error");
   	    		alert("DB Problem with logo");
   	    	}
         }
   });
	e.preventDefault();
});
