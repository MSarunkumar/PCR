<!---
  --- Task
  --- ----
  ---
  --- This for handling data.
  ---
  --- author: mindfire
  --- date:   11/14/18
  --->
<cfcomponent hint="This for handling data." accessors="true" output="false" persistent="false">

<!--- Method: It will return sectionData id and data based on reportID and sectionID  --->
	<cffunction name="getsectionData" access="public" returntype="query" hint="It will return section data">
		<cfargument name="sectionId" required="true" type="numeric"  hint="Catch the section id" />
		<cfargument name="reportId" required="true" type="numeric"  hint="Catch the report id" />
		<cfquery name="LOCAL.getSectionData">
			SELECT SDID,sData
			FROM sectionData
			WHERE RID=<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.reportId#" />
			      AND SID=<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sectionId#" />
		</cfquery>
		<cfreturn LOCAL.getSectionData />

	</cffunction>

<!--- Method: It will return heading data based on sectionData id  --->
	<cffunction name="getHeadingData" access="public" returntype="query" hint="return heading data with name">
		<cfargument name="sectionDataId" required="true" type="numeric" hint="catch sectionData id" />
		<cfquery name="LOCAL.fetchHeadingData">
			SELECT HID,hName,hData
			FROM heading
			WHERE SDID=<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sectionDataId#">
		</cfquery>
		<cfreturn LOCAL.fetchHeadingData />

	</cffunction>

<!--- Method: It will update the section data based on report id and section id  --->
	<cffunction name="updateSectionData" access="remote" returnformat="JSON" returntype="boolean"
				hint="It will update the data of ckeditor">
		<cfargument name="reportId" required="true" type="numeric" hint="It will catch the report id" />
		<cfargument name="sectionId" required="true" type="numeric" hint="It will catch the section id" />
		<cfargument name="sectionData" type="string" hint="It will catch the section data" default=NULL/>

		   <cfquery name="LOCAL.doUpdate">
			UPDATE sectionData
			SET sData=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#ARGUMENTS.sectionData#" />
			WHERE RID=<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.reportId#" />
			      AND SID=<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sectionId#" />
		</cfquery>
		<cfreturn TRUE />
	</cffunction>

<!--- Method: It will return  all sectionData Id of one report--->
	<cffunction name="getSectionsName" access="public" returntype="query"
				hint="It will return section name of report which are not fixed">
	<cfargument name="reportID" required="true" type="numeric" hint="It will catch report ID" />
		<cfquery name="LOCAL.fetchSectionName">
			SELECT s.sName,sd.sData
			FROM sectionData sd
			INNER JOIN section s
			ON sd.RID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.reportID#">
			AND sd.SID = s.SID
		</cfquery>
		<cfreturn LOCAL.fetchSectionName />
	</cffunction>

<!--- Method: It will return fixed section name --->
	<cffunction name="getFixedSection" access="public" returntype="query"
				hint="It will return all fixed section name">
		<cfquery name="LOCAL.fetchFixedSection">
			SELECT sName
			FROM section
			WHERE fixed =1;
		</cfquery>
		<cfreturn LOCAL.fetchFixedSection />
	</cffunction>

<!--- Method : It will return company information --->
	<cffunction name="getCompanyInfo" access="public" returntype="query">
	<cfargument name="rid" required="true" type="numeric" hint="Catch report id">
	<cfquery name="LOCAL.fetchCompanyInfo">
		SELECT cName,logo,c.CIN,cAddress,r.progressLavel
		FROM company c INNER JOIN report r
		ON rid=<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rid#" />
		AND r.CIN=c.CIN
	</cfquery>
	<cfreturn LOCAL.fetchCompanyInfo />
	</cffunction>

<!--- Method: It will return report ids based on cin --->
	<cffunction name="getReportIDs" access="public" returntype="array" hint="It will report ids">
	<cfargument name="companyID" required="true" type="string" hint="Catch company id (CIN)" />
	<cfquery name="LOCAL.fetchReportID">
		SELECT RID
		FROM report r INNER JOIN company c
	    ON c.CIN=<cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.companyID#"/>
	    AND r.CIN=c.CIN
	</cfquery>

	<cfset LOCAL.arrayRid = arrayNew(1) />

<!--- made array for report ids --->
    <cfloop query = "LOCAL.fetchReportID">
    	<cfset   arrayAppend(LOCAL.arrayRid,"#LOCAL.fetchReportID.RID#","true") />
    </cfloop>
    <cfreturn LOCAL.arrayRid />
	</cffunction>

<!--- Method: It will upload logo   --->
	<cffunction name="updateLogo" access="remote" returnformat="JSON" returntype="boolean">

		<cfif isdefined("FORM") && isdefined("FORM.file")>

			<cfif isdefined("FORM.filename")>
				<cfset LOCAL.filename = FORM.filename>
			<cfelse>
				<cfset LOCAL.filename = "no_name.jpg">
			</cfif>

			<!--- Make File path with file extention --->
			<cfset LOCAL.file_ext = ListLast(LOCAL.filename, ".") />
			<cfset LOCAL.newFilename = FORM.company_id & "." & LOCAL.file_ext />
			<cfset LOCAL.path =  APPLICATION.rootPath & "Assets\serverLogo\" & LOCAL.newFilename />

			<!--- upload file to server --->
			<cffile action="upload" destination="#LOCAL.path#" filefield="FORM.file" nameconflict="overwrite" />
			<cfset LOCAL.updateStatus = doUpdateLogoInDB(LOCAL.path, FORM.company_id ) />
			<cfreturn TRUE />
		</cfif>
		<cfreturn FALSE />

	</cffunction>

<!--- Method: It will update the path of logo in DB --->
	<cffunction name="doUpdateLogoInDB" access="private" returntype="boolean" hint="It will update in table">
		<cfargument name="path" required="true" type="string" hint="Catch path of image" />
		<cfargument name="cin" required="true" type="string" hint="catch company number" />

			<cfquery name="LOCAL.doUpdate">
				UPDATE company
				SET logo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.path#" />
				WHERE CIN = <cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.cin#" />
			</cfquery>
			<cfreturn TRUE />

	</cffunction>

<!--- Method: It will send the email --->
	<cffunction name="sendEmail" access="remote" returnformat="JSON" returntype="boolean" >
		<cfargument name="emails" required="true" type="any" hint="Catch array of emails" />
		<cfargument name="message" type="string"  required="false" default=""/>
	    <cfargument name="didAction" type="string" required="true" />
		<cfargument name="RID" type="numeric" required="true" hint="catch report id" />

		<cfmail from="arunyc2@gmail.com" to="#ARGUMENTS.emails#" subject="PCR Review" type="html">
			   This is email from PCR for review the report.<br>
			   <cfoutput>#ARGUMENTS.message#</cfoutput>
		</cfmail>

		<cfset LOCAL.emailsArray = ListToArray(ARGUMENTS.emails) />
		<cfset LOCAL.time = now() />
		<cfset LOCAL.action = "Review" />

		<cfloop from="1" to="#arrayLen(LOCAL.emailsArray)#" index="i">
             <cfset LOCAL.email = LOCAL.emailsArray[i] />
			<cfset saveReview(LOCAL.email,ARGUMENTS.didAction,ARGUMENTS.RID,LOCAL.time,LOCAL.action) />
		</cfloop>
		<cfset updateLevel(ARGUMENTS.RID,3) />
		<cfreturn TRUE />

	</cffunction>

<!--- Method: It will store the progress of report --->
	<cffunction name="saveReview" access="private" returntype="boolean" >
		<cfargument name="emailID" type="string" required="true" hint="email" />
	    <cfargument name="didAction" type="string" required="true" hint="Catch admin email" />
		<cfargument name="RID" type="numeric" required="true" hint="Catch report id" />
		<cfargument name="date" type="date" required="true" hint="Catch time and date" />
		<cfargument name="action" type="string" required="true" hint="Catch action of report" />
        <cfquery name="LOCAL.doSaveReview">
			INSERT  INTO  progress (RID,email,action,date,didAction)
         	VALUES (
	            <cfqueryparam value = "#ARGUMENTS.RID#" cfsqltype = "cf_sql_integer" />,
	            <cfqueryparam value = "#ARGUMENTS.emailID#" cfsqltype = "cf_sql_varchar" />,
	            <cfqueryparam value = "#ARGUMENTS.action#" cfsqltype = "cf_sql_varchar" />,
				<cfqueryparam value = "#ARGUMENTS.date#" cfsqltype = "cf_sql_timestamp" />,
				<cfqueryparam value = "#ARGUMENTS.didAction#" cfsqltype = "cf_sql_varchar" />
				 )
		</cfquery>

	    <cfreturn TRUE />
	</cffunction>

<!--- Method: It will update the lavel of report --->
	<cffunction name="updateLevel" access="private" >
		<cfargument name="RID" type="numeric" required="true" />
		<cfargument name="level" type="numeric" required="true" />
		<cfquery name="LOCAL.doUpdateLevel">
			UPDATE report
			SET progressLavel = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.level#" />
			WHERE RID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.RID#" />
		</cfquery>

	</cffunction>
<!--- Method: It will return users information of a perticular company  --->
	<cffunction name="getUsers" access="public" returntype="query" >
		<cfargument name="companyID" required="true" type="string" />
		<cfquery name="LOCAL.fetchUsers">
			SELECT email,name,role
			FROM users
			WHERE CIN=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.companyID#" />
		</cfquery>
		<cfreturn LOCAL.fetchUsers />
	</cffunction>


<!--- Method: It will return review of report info--->
	<cffunction name="getReviewInfo" access="public" returntype="query">
		<cfargument name="RID" type="numeric" required="true" />

		<cfquery name="LOCAL.fetchReview">
			SELECT u.name AS receiver ,p.date AS date
            FROM progress p INNER JOIN users u
	        ON p.email=u.email
	        AND rid=<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.RID#">
	        AND action='Review'
	 		ORDER BY p.PID DESC;
		</cfquery>
		<cfreturn LOCAL.fetchReview />

	</cffunction>

<!--- Method: it will return sender info --->
	<cffunction name="getSender" access="public" returntype="String">
		<cfargument name="RID" type="numeric" required="true" />
		<cfquery name="LOCAL.fetchSender">
			SELECT TOP 1 u.name AS sender
			FROM progress p INNER JOIN users u
	        ON p.didAction=u.email
	        AND rid=<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.RID#">
	        AND p.action='Review'
	 		ORDER BY p.PID DESC;
		</cfquery>
		<cfreturn LOCAL.fetchSender.sender />
	</cffunction>

<!--- Method: It will update approved action --->
	<cffunction name="doApprove" access="remote" returnformat="JSON" returntype="boolean">
	    <cfargument name="didAction" type="string" required="true" />
		<cfargument name="RID" type="numeric" required="true" hint="catch report id" />
		<cfset LOCAL.time = now() />
		<cfset LOCAL.action = "Approve" />
        <cfset saveReview("default@gmail.com",ARGUMENTS.didAction,ARGUMENTS.RID,LOCAL.time,LOCAL.action) />
		<cfset updateLevel(ARGUMENTS.RID,4) />
		<cfreturn TRUE />
	</cffunction>

<!--- Method: It will return approved person --->
	<cffunction name="getApprove" access="public" returntype="string">
		<cfargument name="RID" type="numeric" required="true" />
		<cfquery name="LOCAL.fetchApproved">
			SELECT u.name AS approved
			FROM progress p INNER JOIN users u
	        ON p.didAction=u.email
	        AND rid=<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.RID#">
	        AND p.action='Approve'
	 		ORDER BY p.PID DESC;
		</cfquery>
		<cfreturn LOCAL.fetchApproved.approved />
	</cffunction>

<!--- Method: It will do made live --->
	<cffunction name="doMadeLive" access="remote" returnformat="JSON" returntype="boolean">
		<cfargument name="didAction" type="string" required="true" />
		<cfargument name="RID" type="numeric" required="true" hint="catch report id" />
		<cfset LOCAL.time = now() />
		<cfset LOCAL.action = "MadeLive" />
        <cfset saveReview("default@gmail.com",ARGUMENTS.didAction,ARGUMENTS.RID,LOCAL.time,LOCAL.action) />
		<cfset updateLevel(ARGUMENTS.RID,5) />
		<cfreturn TRUE />
	</cffunction>

<!--- Method: It will update save test --->
	<cffunction name="doSendTest" access="remote" returnformat="JSON" returntype="boolean">
		<cfargument name="didAction" type="string" required="true" />
		<cfargument name="RID" type="numeric" required="true" hint="catch report id" />
		<cfset LOCAL.time = now() />
		<cfset LOCAL.action = "SendTest" />
        <cfset saveReview("default@gmail.com",ARGUMENTS.didAction,ARGUMENTS.RID,LOCAL.time,LOCAL.action) />
		<cfset updateLevel(ARGUMENTS.RID,6) />
		<cfreturn TRUE />
	</cffunction>

<!--- Method: It will return made live person`s data --->
	<cffunction name="getMadeLiveInfo" access="public" returntype="query">
		<cfargument name="RID" required="true" type="numeric" />
		<cfquery name="LOCAL.fetchMadeLive">
			SELECT u.name AS name, p.date AS date
			FROM progress p INNER JOIN users u
			ON p.didAction=u.email
			AND rid=<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.RID#">
			AND action='MadeLive'
			ORDER BY p.PID DESC;
		</cfquery>
		<cfreturn LOCAL.fetchMadeLive />
	</cffunction>
</cfcomponent>