<cfheader name="expires" value="#now()#">
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate">

<cfif (structKeyExists(SESSION,"CIN")) >
	<cflocation url="view/report.cfm" addtoken="false" />
</cfif>

<html>
	<head>
		<title>PCR LOGIN </title>
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
		<link href="assets/css/login.css" rel="stylesheet" />
	</head>
	<body>
			<section class="login-block">
			    <div class="container">
				<div class="row">
					<div class="col-md-4 login-sec">
					    <h2 class="text-center">Login PCR</h2>
					    <div id="serverSideMessage">
				        <cfset VARIABLES.messageArray=["Invalid details",
				        						"Not registered email/password",
				        						"Sorry technical problem",
				        						"email/password incorrect",
				        						"Please login"]>
					<cfif isdefined("URL.messageID")>
						<cfif URL.messageID GTE 1 AND URL.messageID LTE 5 >
							<cfoutput>#VARIABLES.messageArray[URL.messageID]#</cfoutput>
							<cfelse>
							<cflocation url="error/error.cfm" addtoken="false">
						</cfif>
					<cfelse>
				    </cfif>
                </div>
				<form action="Controller/loginAction.cfm" class="login-form" onsubmit="return formValidation()" method="POST">
			  	<div class="form-group">
			   	 <label for="exampleInputEmail1" >Email ID</label>
			   	 <input type="text" class="form-control" id="uid" name="uid" placeholder="abc@gmail.com" onblur="emailValid()">
			   	 <div id="eid" class="errMsg"> </div>
			  	</div>

				 <div class="form-group">
				   <label for="exampleInputPassword1" >Password</label>
				   <input type="password" class="form-control" id="password" name="password" onblur="passwordValid()">
				   <div id="pid" class="errMsg"> </div>
				 </div>

			    <div class="form-check">
			    	<input type="Submit" class="btn btn-login float-left" value="Submit" name="login" >
			 	</div></div>
				</form>
				<div class="col-md-8 banner-sec">
				    <div class="carousel-item active">
				      <img class="d-block img-fluid" src="assets/image/login1.jpg" alt="Login pcr image">
				      <div class="carousel-caption d-none d-md-block">
				        <div class="banner-text">
				            <h2>This is PCR Login</h2>
				        </div>
				     </div>
			    </div>
				</div>
			</div>
			</section>
	<script src="assets/js/jquery.js" type="text/javascript"></script>
	<script src="assets/js/login.js" type="text/javascript"></script>

	</body>
</html>