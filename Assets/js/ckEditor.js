$(document).ready(function () {
	CKEDITOR.replace("ckeditor");
	 
});

var isSaved = true;
var preTime = new Date("Nov 28, 2018 20:15:10");
var count = 0;
var unSavePreTime = new Date("Nov 28, 2018 20:15:10");

/*....................................................*/

CKEDITOR.on("instanceReady", function(evt) {
	
	var editor = evt.editor;
    
	editor.on("change", function(e) {
    	onChangeAction(); 
    });
});
//....................................................

function onChangeAction() {
	var currTime = new Date();
    if( Math.floor((Math.abs(currTime - preTime) / 1000)%60) > 5) {
		 preTime = new Date();
		 
		 saveText();
  	 }
    else {
    	isSaved = false;
        $("#serverMessage").html("Changes Pending...").css("color","#ef3920");
        unSavePreTime = new Date();
        saveInTime();
    } 	
} 

//....................................................
function saveInTime() {
	var myVar = setInterval(doSave, 5000);
	function doSave() {
		var unSaveCurrTime = new Date();
		if( !isSaved && (Math.floor((Math.abs(unSaveCurrTime - unSavePreTime) / 1000)%60) > 1)) {
			saveText();
		  
		}
	    clearInterval(myVar);
	}
}
//....................................................   
function saveBtnAction() {
	if(isSaved) {
			$.MessageBox("Data Already saved");
	}
	else {
		   saveText();
		   $.MessageBox("Data save successfully");
	}
}
//...................................    save the CKeditor data

function saveText() {
		var sectionData = CKEDITOR.instances["ckeditor"].getData();
		var sectionID = $("#sectionID").val();
		var reportID = $("#reportID").val();
	  
		 $.ajax({
	        type: "Post" ,
	        url: "../Model/task.cfc?method=updateSectionData",
	        data:{
	        	 reportId:reportID,
	        	 sectionId:sectionID,
	        	 sectionData:sectionData  
	        	 },
	        datatype: "json",
	        success:function(res)
	             {   
	       	    	var res = $.parseJSON(res);
	       	    	if(res){
	       	    		isSaved = true;
	       	    		$("#serverMessage").html("Changes Saved").css("color","#32ef21");
	       	    	}
	       	    	else{
	       	    		$("#serverMessage").html("DB Error");
	       	    	}
	             }
	       });
}
