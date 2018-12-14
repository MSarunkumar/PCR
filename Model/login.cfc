<!---
  --- login
  --- -----
  ---
  --- This component will containing login related information.
  ---
  --- author: mindfire
  --- date:   12/3/18
  --->
<cfcomponent hint="This component will containing login related information." accessors="true" output="false" persistent="false">

	<!--- Method: Check email registered or not --->
	<cffunction name="isEmailExist" access="public" returntype="numeric">
		<cfargument name="email" required="true" type="string" hint="Catch email id of user">

		<cfquery name="LOCAL.isEmail">
			SELECT COUNT(email) AS isExist
			FROM users
			WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#" maxlength="50">
		</cfquery>
		<cfreturn LOCAL.isEmail.isExist />
	</cffunction>

	<!--- Method: It will return user info  --->
	<cffunction name="getUserInfo" access="public" returntype="query" hint="It will return user information">
		<cfargument name="email" required="true" type="string" hint="Catch email id of user">

		<cfquery name="LOCAL.fetchUserInfo">
			SELECT name,password,role,CIN,fullAccess
			FROM users
			WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#" maxlength="50">
		</cfquery>
		<cfreturn LOCAL.fetchUserInfo />
	</cffunction>

</cfcomponent>