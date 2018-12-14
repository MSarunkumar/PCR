$(document).ready(function () {
	var table = $("#tableId").DataTable();
	
});



//..........................................................
$("#approveBtnID").prop("disabled", true);
$("#madeLiveBtnID").prop("disabled", true);
$("#sendTestBtnID").prop("disabled", true);
document.getElementById("level3").style.pointerEvents = "none";
document.getElementById("level5").style.pointerEvents = "none";
document.getElementById("level4").style.pointerEvents = "none";
document.getElementById("level6").style.pointerEvents = "none";

//...........................................................
//If user do not have full access like admin then icon box and progress button should not be visible. 

var access = $("#accessID").val();

if(access == 0) {
	$(".is-access").hide();
	$(".right-btns").hide();
}

//.............   Don`t show boxes
$(".review-box").css("display","none");
$(".madeLive-box").css("display","none");

//..............................   For progress level 
var level = $("#levelR").val();
var isApprove = $("#approveID").val();
var isMadeLive = $("#madeLiveID").val();
var isSendTest = $("#sentTestID").val();
var approveName = $("#approveName").val();

//...................................................
if(level == "done") {
	$("#level3").addClass("active");
	document.getElementById("emailIconId").style.pointerEvents = "none";
	$("#level3").text("Under Review");
	document.getElementById("level3").style.pointerEvents = "auto";
	if(!(isApprove == "done")){
		$("#approveBtnID").prop("disabled", false);
		$("#approveBtnID").css({
			   "color" : "white",
			   "background-color" : "#2564f7"
		});	
	}	
}
//........................................................
if(isApprove == "done"){
	$("#level4").addClass("active");
	$("#approveBtnID").prop("disabled", true);
	$("#level4").text("Approved");
	$("#level3").text("Reviewed By");
	document.getElementById("level4").style.pointerEvents = "auto";
	$("#approveBtnID").css({
			"color" : "dimgray",
			"background-color" : "#e0e1e2"
	});
	if(!(isMadeLive == "done")){
		$("#madeLiveBtnID").prop("disabled", false);
		$("#madeLiveBtnID").css({
			   "color" : "white",
			   "background-color" : "#2564f7"
		     });
		
	}
}
//...........................................................
if(isMadeLive == "done") {
	$("#level5").addClass("active");
	$("#madeLiveBtnID").prop("disabled", true);
	$("#level5").text("Made Live");
	document.getElementById("level5").style.pointerEvents = "auto";
	$("#madeLiveBtnID").css({
		"color" : "dimgray",
		"background-color" : "#e0e1e2"
	});
	if(!(isSendTest == "done")){
		$("#sendTestBtnID").prop("disabled", false);
		$("#sendTestBtnID").css({
			   "color" : "white",
			   "background-color" : "#2564f7"
		     });		
	}	
}
//.................................................
if(isSendTest == "done"){
	$("#level6").addClass("active");
	$("#sendTestBtnID").prop("disabled", true);
	$("#level6").text("Send");
	document.getElementById("level6").style.pointerEvents = "auto";
	$("#sendTestBtnID").css({
		"color" : "dimgray",
		"background-color" : "#e0e1e2"
});
}

//...................................................................
function showReview() {
	$(".review-box").css("display","block");
}

function hideReview(){
	$(".review-box").css("display","none");
}

function showMadeLive(){
	$(".madeLive-box").css("display","block");
}

function hideMadeLive(){
	$(".madeLive-box").css("display","none");
}