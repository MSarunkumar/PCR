//...........  get checked send email
var reportID = $("#reportID").val();
var madeAction = $("#userID").val();

$("#send").click(function(){
	
    var sendedEmails = [];
    
    $.each($("input[name='emails']:checked"), function(){            
    	sendedEmails.push($(this).val());
    });
    
    var emailList = sendedEmails.join(",");
    var xtraMessage = $("#xtraMessage").val();
    
   
    sendEmails(emailList,xtraMessage,reportID,madeAction);
});


function sendEmails(emailList,xtraMessage,reportID,madeAction) {
	
	$.ajax({
        type: "Post" ,
        url: "../Model/task.cfc?method=sendEmail",
        data:{
        	 emails:emailList,
        	 message:xtraMessage,
        	 didAction:madeAction,
        	 RID:reportID
        	 },
        datatype: "json",
        success:function(res)
             {   	
       	    	if(res) {
       	    		window.location.assign("report.cfm");			
       	    	}
       	    	else {
       	    		console.log("Server Error in send email");
       	    	}
             }
       });
  }


$("#approveBtnID").click(function() {
		
	doApprove(reportID,madeAction);
});

$("#madeLiveBtnID").click(function(){
	doMadeLive(reportID,madeAction);
});

$("#sendTestBtnID").click(function(){
	doSendTest(reportID,madeAction);
});

function doApprove(reportID,madeAction) {
	
	$.ajax({
        type: "Post" ,
        url: "../Model/task.cfc?method=doApprove",
        data:{
        	 didAction:madeAction,
        	 RID:reportID
        	 },
        datatype: "json",
        success:function(res)
             {   	
       	    	if(res) {
       	    		$("#level4").addClass("active");
       	    		$("#approveBtnID").prop("disabled", true);
       	    		$("#madeLiveBtnID").prop("disabled", false);
       	    		$("#level4").text("Approved");
       	    		$("#level3").text("Reviewed By");
       	    		$("#approveBtnID").css({
   	    				"color" : "dimgray",
   	    				"background-color" : "#e0e1e2"
        			});
       	    		
       	    		$("#madeLiveBtnID").css({
       				   "color" : "white",
       				   "background-color" : "#2564f7"
       			     });
       	    	}
       	    	else {
       	    		console.log("Server Error in approve");
       	    	}
             }
       });
}

function doMadeLive(){
	
	$.ajax({
        type: "Post" ,
        url: "../Model/task.cfc?method=doMadeLive",
        data:{
        	 didAction:madeAction,
        	 RID:reportID
        	 },
        datatype: "json",
        success:function(res)
             {   	
       	    	if(res) {
       	    		window.location.assign("report.cfm");	
       	    	}
       	    	else {
       	    		console.log("Server Error in do made live");
       	    	}
             }
       });
	
}

function doSendTest(){
	
	$.ajax({
        type: "Post" ,
        url: "../Model/task.cfc?method=doSendTest",
        data:{
        	 didAction:madeAction,
        	 RID:reportID
        	 },
        datatype: "json",
        success:function(res)
             {   	
       	    	if(res) {
       	    		$("#level6").addClass("active");
       	    		$("#sendTestBtnID").prop("disabled", true);
       	    		$("#level6").text("Sent");
       	    		$("#sendTestBtnID").css({
        				   "color" : "dimgray",
        				   "background-color" : "#e0e1e2"
        			});
       	    	}
       	    	else {
       	    		console.log("Server Error in do made live");
       	    	}
             }
       });
	
	
}