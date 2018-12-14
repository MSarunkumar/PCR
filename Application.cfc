<cfcomponent  accessors = "true" output = "false" persistent = "false">

	<cfset THIS.name = "PCR_1" />
	<cfset THIS.applicationTimeout = CreateTimeSpan(0,4,0, 0) />
	<cfset THIS.sessionManagement = TRUE />
	<cfset THIS.sessionTimeout = CreateTimeSpan(0, 3,0, 0) />
    <cfset THIS.datasource = "PCR" />
	<cfset THIS.clientManagement = TRUE />
	<cfset THIS.setClientCookies = TRUE />


<!--------------- Method [ OnApplicationStart ] -------------->

	<cffunction name = "OnApplicationStart" access = "public" returntype = "boolean" output = "false"
		        hint = "Fires when the application start">

		<cfset APPLICATION.taskObj = CreateObject("component", "Model.Task") />
		<cfset APPLICATION.loginObj = CreateObject("component", "Model.login") />

		<cfset APPLICATION.rootPath = getDirectoryFromPath(getCurrentTemplatePath()) />

		<cfreturn TRUE />
	</cffunction>

<!---   Method [onMissingTemplate]   ---------------------->
  	<cffunction name = "onMissingTemplate" access = "public" >
		<cfargument  name = "targetPage" type = "string" required = "true" />
          <cfdump var="#targetPage#" abort="true">
	</cffunction>

<!--- Method [onRequest] --->
	<cffunction name = "OnRequest" access = "public" returntype = "void" output = "true"
		                            hint = "Fires after pre page processing is complete.">
		<cfargument name = "TargetPage" type = "string" required = "true"/>

		<!--- Restart application --->
		<cfif structKeyExists(URL, "Reset")>
			<cfset structClear(SESSION) />
			<cfset ApplicationStop() />
		</cfif>

		<!--- Logout user [clear session and change cookie] --->
		<cfif structKeyExists(URL, "logout")>
			<cfset structClear(SESSION) />
			<CFCOOKIE NAME="CFID" VALUE="" EXPIRES="NOW" />
			<CFCOOKIE NAME="CFTOKEN" VALUE="" EXPIRES="NOW" />
		</cfif>
        <cfinclude template = "#ARGUMENTS.TargetPage#" />

		<cfreturn />

	</cffunction>

<!--- Method [onRequestEnd]  --->
	<cffunction name = "onRequestEnd" access = "public" returntype = "void" output = "false">
		<cffile action="write" file="aa.txt" output="onRequestEnd" >

	</cffunction>

<!--- Method [OnApplicationEnd] --->
	<cffunction name = "OnApplicationEnd" access = "public" returntype = "void" output = "true"
		                                  hint = "Fires when the application is terminated.">

		<cfargument name = "ApplicationScope" type = "struct" required = "FALSE" default = "#StructNew()#" />

        <cffile action = "append" file = "D:/Errors/project.txt"
		        output = "Application #Arguments.ApplicationScope.applicationname# Ended..Time --> #now()#" />
		<cfreturn />

	</cffunction>

<!--- Method [OnError] ---------------------------------------------------------->
<!---  <cffunction name = "OnError" access = "public" returntype = "void" output = "true"
		                          hint = "Fires when an exception occures that is not caught by a try/catch.">
		<cfargument name = "Exception" type = "any" required = "true" />
		<cfargument type = "String" name = "EventName" required = "true"/>



		<cfreturn />
	</cffunction> --->

</cfcomponent>
