
<html>
	<head>
		<title>Login Action</title>
	</head>
	<body>
		<cfif isDefined("FORM.login") >
			   <cfset VARIABLES.valid = TRUE />
			   <!------  It will check email formate    ----------->
			   <cfif NOT isValid("regex", trim(FORM.uid),"^([a-zA-Z0-9_\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$")>
				         <cfset VARIABLES.valid = FALSE />
			   </cfif>

			   <!------- It will check password formate ----------------------->
			   <cfif NOT (len(FORM.password) GTE 8 AND refind('[A-Z]',FORM.password)
				     AND refind('[a-z]',FORM.password) AND refind('[0-9]',FORM.password)
				     AND refind('[!@##$&* = -{}<>,.:;|?""''~]',FORM.password ) )>
                         <cfset VARIABLES.valid = FALSE />
				</cfif>

				<!--- If email/password formate is good than go to if block  --->
			    <cfif  VARIABLES.valid EQ TRUE >

				    <cfset VARIABLES.record = APPLICATION.loginObj.isEmailExist(FORM.uid) />
				    <!---   <cfdump var = "#VARIABLES.record#"><cfabort>   --->

				    <cfif VARIABLES.record EQ -1>
					   <cflocation url = "../index.cfm?messageID=3" addToken = "false" />
				    </cfif>

				    <cfif VARIABLES.record EQ 1 >
					    <cfset VARIABLES.user = APPLICATION.loginObj.getUserInfo(FORM.uid) />
						<cfset VARIABLES.hashedPass = hash(FORM.password,"md5") />
						 <cfset VARIABLES.dbPass = BinaryEncode(VARIABLES.user.password, "HEX") />

						<cfif VARIABLES.hashedPass EQ VARIABLES.dbPass>
							<!--- Set session variable --->
							<cfset SESSION.name = VARIABLES.user.name />
							<cfset SESSION.CIN = VARIABLES.user.CIN />
							<cfset SESSION.role = VARIABLES.user.role />
							<cfset SESSION.isFullAccess = VARIABLES.user.fullAccess />
							<cfset SESSION.email = FORM.uid />
							<cflocation url="../view/report.cfm" addtoken="false" />
						<cfelse>
							<cflocation url="../index.cfm?messageID=4" addtoken="false" />
						</cfif>
				    <cfelse>
                         <cflocation url = "../index.cfm?messageID=2" addToken = "false" />
				    </cfif>
			  <cfelse>
				      <cflocation url = "../index.cfm?messageID=1" addToken = "false" />
			  </cfif>
		  <cfelse>
			  <cflocation url = "../error/error.cfm" addToken = "false" />
		  </cfif>
	</body>
</html>
