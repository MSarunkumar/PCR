<cfheader name="expires" value="#now()#">
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate">
<cfif NOT (structKeyExists(SESSION,"CIN") AND structKeyExists(SESSION,"name")) >
	<cflocation url="../index.cfm?messageID=5" addtoken="false" />
</cfif>
<html>
	<head>
		<title>
			PCR Task
		</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="../assets/css/progress.css" rel="stylesheet">
		<link href="https://www.w3schools.com/w3css/4/w3.css" rel="stylesheet">
		<link href="../assets/css/message.css" rel="stylesheet">
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Archivo|Lato" rel="stylesheet">
		<link href="../assets/css/task.css" rel="stylesheet">
		<link href="../assets/css/divs.css" rel="stylesheet">
	</head>
	<body>
		<cfset VARIABLES.reportID = APPLICATION.taskObj.getReportIDs(SESSION.CIN) />
		<cfparam name="URL.RID" type="numeric" default="#VARIABLES.reportID[1]#" />

		<cfif NOT ArrayContains(VARIABLES.reportID,URL.RID)>
			<cflocation url="../error/error.cfm" addtoken="false" />
		</cfif>

		<cfparam name="URL.SID" type="numeric" default="1" />
		<cfset VARIABLES.Sender = APPLICATION.taskObj.getSender(URL.RID) />
		<cfset VARIABLES.fixedSectionName = APPLICATION.taskObj.getFixedSection() />
		<cfset VARIABLES.sectionData = APPLICATION.taskObj.getSectionData(URL.SID,URL.RID) />
		<cfset VARIABLES.companyInfo = APPLICATION.taskObj.getCompanyInfo(URL.RID) />
		<cfset VARIABLES.getUsers = APPLICATION.taskObj.getUsers(SESSION.CIN) />
		<cfset VARIABLES.getReview = APPLICATION.taskObj.getReviewInfo(URL.RID) />
		<cfset VARIABLES.madeLive = APPLICATION.taskObj.getMadeLiveInfo(URL.RID) />
		<cfset VARIABLES.approve = APPLICATION.taskObj.getApprove(URL.RID) />
		<!-------------------------------------------- Make company logo path --->
		<cfset VARIABLES.ext = ListLast(VARIABLES.companyInfo.logo,".") />
		<cfset VARIABLES.companyID = Trim(VARIABLES.companyInfo.CIN) />
		<cfset VARIABLES.path = "../Assets/serverLogo/" & VARIABLES.companyID & "." & VARIABLES.ext />
		<!--------------------------------------------- Hidden fields --->
		<cfoutput>
			<input type="hidden" id="reportID" value="#URL.RID#" />
			<input type="hidden" id="sectionID" value="#URL.SID#" />
			<input type="hidden" id="companyID" value="#VARIABLES.companyInfo.CIN#" />
			<input type="hidden" id="accessID" value="#SESSION.isFullAccess#" />
			<input type="hidden" id="userID" value="#SESSION.email#" />
		</cfoutput>
		<!--- -------------------------------------------   HEADER  --->
		<cfif VARIABLES.companyInfo.progressLavel GT 2>
			<input type="hidden" id="levelR" value="done" />
		</cfif>
		<cfif VARIABLES.companyInfo.progressLavel GT 3>
			<input type="hidden" id="approveID" value="done" />
			<cfoutput><input type="hidden" id="approveName" value="#VARIABLES.approve#"></cfoutput>
		</cfif>
		<cfif VARIABLES.companyInfo.progressLavel GT 4>
			<input type="hidden" id="madeLiveID" value="done" />
		</cfif>
		<cfif VARIABLES.companyInfo.progressLavel GT 5>
			<input type="hidden" id="sentTestID" value="done" />
		</cfif>

		<div class="container-fluid">
			<div class="header">
				<div class="row">
					<div class="col-sm-4">
						<img src="../assets/image/PCR.jpg" height="80" width="300" />
					</div>
					<form id="formID" enctype="multipart/form-data" method="post">
						<input type="file" name="fileName" id="fileID" accept="image/png,image/jpeg,image/jpg"
							onChange="javascript:submitImage()" />
					</form>
					<div class="col-sm-4" >
						<div class="tooltips" id="centerEle" onClick="javascript:imageArea()">
							<cfoutput>
								<img id="companyLogo" src="#VARIABLES.path#" alt="your image" height="80" width="200"/>
							</cfoutput>
							<span class="tooltiptext">
								Click to update logo
							</span>
						</div>
					</div>
					<div class="col-sm-4">
						<!--- ............................ --->
						<ul class="list-group is-access">
							<li class="list-group-item">
								<a href="#">
									<i class="glyphicon glyphicon-font">
									</i>
								</a>
							</li>
							<li class="list-group-item">
								<a href="#">
									<i class="glyphicon glyphicon-bold">
									</i>
								</a>
							</li>
							<li class="list-group-item">
								<a href="#">
									<i class="glyphicon glyphicon-bell">
									</i>
								</a>
							</li>
							<li class="list-group-item" id="emailIconId">
								<a href="#"  onclick="document.getElementById('emailModel').style.display='block'">
									<i class="glyphicon glyphicon-envelope">
									</i>
								</a>
							</li>
							<li class="list-group-item">
								<a href="#">
									<i class="glyphicon glyphicon-th">
									</i>
								</a>
							</li>
							<li class="list-group-item">
								<a href="#">
									<i class="glyphicon glyphicon-print">
									</i>
								</a>
							</li>
							<li class="list-group-item">
								<a href="#">
									<i class="glyphicon glyphicon-eye-close">
									</i>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!--- -------------------------------------------------------- PROGRESS BAR --->
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-3">
				</div>
				<div class="col-sm-6">
					<div class="progressdiv">
						<ul class="progressbar">
							<li >
								In House
							</li>
							<li class="active">
								In Progress
							</li>
							<li id="level3" onclick="showReview()" -onmouseleave="hideReview()" >
								In Review
							</li>
							<li id="level4">
								Approved
							</li>
							<li id="level5" onmouseenter="showMadeLive()" onmouseleave="hideMadeLive()">
								Made Live
							</li>
							<li id="level6">
								Sent
							</li>
						</ul>
					</div>
				</div>
				<!--- ------------------------------------------------------- --->
				<div class="review-box" id="review-id">
					<div class="container">
						<div class="pointer-line">
						</div>
						<div class="upper-area"  >
							<div class="review-heading" style="color:#f22e2e;font-size: medium;">
								Under Review By :
								<span class="person" >
									<cfoutput>
										<span class="in-box" id="in-box-r">
										#VARIABLES.Sender# &nbsp
										</span>
									</cfoutput>
									<cfloop query="VARIABLES.getReview">
										<cfoutput>
											<span class="in-box">
											#VARIABLES.getReview.receiver# &nbsp
											</span>
										</cfoutput>
									</cfloop>
								</span>
							</div>
						</div>
						<br>
						<div class="container-fluid">
							<div class="row down-area ">
								<div class="left-area col-sm-8" style="padding:unset;color:#f22e2e;font-size: medium;">
									Status
									<p style="background-color:#f22e2e;height:4px;width:395px;content:'';margin-top: 5px;" >
									</p>
								</div>
								<div class="right-area col-sm-4" style="color:#f22e2e;font-size: medium;">
									Date &#38; Time
									<p style="background-color:#f22e2e; height:4px;width:180px;content:'';margin-top: 5px;" >
									</p>
								</div>
								<table width="100%" cellspacing="0" cellpadding="0" border="0" role="presentation">
									<tr>
										<td width="69%" wrap>
											<div style="width: 100%;">
												<table align="center" style="border-collapse: collapse;" >
													<cfloop query="VARIABLES.getReview">
														<cfoutput>
															<tr>
																#VARIABLES.sender# sent for review to #VARIABLES.getReview.receiver#
															</tr>
															<br>
															<br>
														</cfoutput>
													</cfloop>
												</table>
											</div>
										</td>
										<td width="2%" >
										</td>
										<td wrap width="29%" style="vertical-align: top;" >
											<div style="width: 100%; vertical-align: top;">
												<table align="center" style="border-collapse: collapse;" >
													<cfloop query="VARIABLES.getReview">
														<cfset VARIABLES.dt=dateformat(VARIABLES.getReview.date, "dd/mm/yyyy") &' '& TimeFormat(VARIABLES.getReview.date, "h:nn tt")>
														<cfoutput>
															<tr>
																#VARIABLES.dt#
															</tr>
															<br>
															<br>
														</cfoutput>
													</cfloop>
												</table>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!--- ------------------------------------     Made Live Box --->
				<div class="madeLive-box" id="madeLive-id">
				 <div class="madeLive-container">
				  <div class="madeLive-pointer-line"></div>
				   <div class="container-fluid">
				   <div class="row">
					<div class="col-sm-7" style="padding:unset;color:#f22e2e;font-size: medium;">
						Status
						<p style="background-color:#f22e2e;height:4px;width:288px;content:'';margin-top:5px;" ></p>
					</div>
					<div class="col-sm-5" style="color:#f22e2e;font-size: medium;">
						Date &#38; Time
						<p style="background-color:#f22e2e; height:4px;width:185px;content:'';margin-top:5px;" ></p>
					</div>

				<table width="100%" cellspacing="0" cellpadding="0" border="0" role="presentation">

					<tr>
			    		<td width="59%" wrap>
						   <div style="width: 100%;">
								<table align="center" style="border-collapse: collapse;" >
									<cfloop query="VARIABLES.madeLive">
										<cfoutput>
											<tr>
												Made Live By #VARIABLES.madeLive.name#
											</tr>
											<br>
											<br>
										</cfoutput>
									</cfloop>
								 </table>
						   </div>
						</td>
				        <td width="2%" ></td>
			            <td wrap width="39%" style="vertical-align: top;" >
						   <div style="width: 100%; vertical-align: top;">
								<table align="center" style="border-collapse: collapse;" >
									<cfloop query="VARIABLES.madeLive">
										<cfset VARIABLES.mdt=dateformat(VARIABLES.madeLive.date, "dd/mm/yyyy") &' '& TimeFormat(VARIABLES.madeLive.date, "h:nn tt")>
										<cfoutput>
											<tr>
												#VARIABLES.mdt#
											</tr>
											<br>
											<br>
										</cfoutput>
									</cfloop>
								 </table>
						      </div>
			      		      </td>
					        </tr>
			              </table>
				        </div>
				      </div>
				    </div>
				</div>
				<!--- ------------------------------------------------------- --->

				<div class="col-sm-3">
					<div class="right-btns">
						<input type="button" class="proBtns" id="approveBtnID" value="Approve">
						<input type="button" class="proBtns" id="madeLiveBtnID"value="Go Live">
						<input type="button" class="proBtns" id="sendTestBtnID"value="Send Test">
					</div>
				</div>
			</div>
		</div>
		<!--- -------------------------------------------------------- Slider Navbar  --->
		<div id="elem">
			<cfloop from="1" to="#VARIABLES.fixedSectionName.recordCount#" index="i">
				<cfoutput>
					<a href="##Section#i#" class="section" >
						#VARIABLES.fixedSectionName.sName[i]#
					</a>
				</cfoutput>
			</cfloop>
			<cfloop from="#i#" to="15" index="j">
				<cfoutput>
					<a href="##Section#j#" class="section" >
						Section#j#
					</a>
				</cfoutput>
			</cfloop>
		</div>
		<br>
		<!--- ------------------------------------------------------- --->
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-3" >
					<div class="panel panel-default" >
						<div class="blue_box_shadow_left" id="addSticky">
							<cfoutput>
								#VARIABLES.companyInfo.cName#
							</cfoutput>
							, Inc.
						</div>
						<div class="panel-body " >
						</div>
					</div>
				</div>
				<div class="col-sm-9">
					<!--- ------------------------------------------------- --->
					<div class="panel-group">
						<div class="panel panel-default" id="Section1">
							<div class="blue_box_shadow">
								Analytical Overview
							</div>
							<div class="panel-body">
								<div class="form-group">
									<div id="serverMessage">
									</div>
									<cfoutput>
										<textarea name="ckeditor" id="ckeditor" class="form-control">
											#VARIABLES.sectionData.sData#
										</textarea>
									</cfoutput>
									<button type="button" class="btn btn-primary center-block" id="Btn" onclick="saveBtnAction()">
										Save
									</button>
								</div>
							</div>
						</div>
					</div>
					<!--- -------------------------------------- --->
					<div class="panel-group">
						<div class="panel panel-default" id="Section2">
							<div class="blue_box_shadow">
								Highlights
							</div>
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table">
										<thead>
											<tr>
												<th>
													Year
												</th>
												<th>
													Quarter
												</th>
												<th>
													Half
												</th>
												<th>
													full
												</th>
												<th>
													amount
												</th>
												<th>
													profit
												</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													2007
												</td>
												<td>
													$500
												</td>
												<td>
													$456
												</td>
												<td>
													$543
												</td>
												<td>
													$10
												</td>
												<td>
													$900
												</td>
											</tr>
											<tr>
												<td>
													2009
												</td>
												<td>
													$100
												</td>
												<td>
													$552
												</td>
												<td>
													$345
												</td>
												<td>
													$20
												</td>
												<td>
													$300
												</td>
											</tr>
											<tr>
												<td>
													2010
												</td>
												<td>
													$400
												</td>
												<td>
													$345
												</td>
												<td>
													$554
												</td>
												<td>
													$33
												</td>
												<td>
													$678
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<!--- --------------------------------------- --->
					<div class="panel panel-default" id="Section3">
						<div class="blue_box_shadow">
							Financial Snapshot
						</div>
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table">
									<tr>
										<td>
											<div id="Sarah_chart_div" >
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<!--- ----------------------------------------- --->
					<div class="panel panel-default" id="Section4">
						<div class="blue_box_shadow">
							Financial Table
						</div>
						<div class="panel-body">
							<div class="table-responsive">
								<table id="tableId" class="cell-border order-column  stripe hover table">
									<thead>
										<tr>
											<th>
												Name
											</th>
											<th>
												Data1
											</th>
											<th>
												Data2
											</th>
											<th>
												Data3
											</th>
											<th>
												Data4
											</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!--- ------------------------------------------- --->
					<div class="panel panel-default" id="Section5">
						<div class="blue_box_shadow">
							Financial Map
						</div>
						<div class="panel-body">
							<table class="table">
								<tr
								<td>
									<div id="regions_div" >
									</div>
								</td>
								</tr>
							</table>
						</div>
					</div>
					<!--- -------------------------------------------- --->
					<div class="panel panel-default" id="Section6">
						<div class="blue_box_shadow">
							Financial Chart
						</div>
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table">
									<tr>
										<td>
											<div id="linechart_material" >
											</div>
										</td>
										<td>
											<div id="barchart_material" >
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<!--- ---------------------------------------------- --->
				</div>
			</div>
		</div>
		</div>
		<!--- ------------------------------------------  email model  ----------- --->
		<div id="emailModel" class="w3-modal">
			<div class="w3-modal-content w3-card-4">
				<header class="w3-container" style="background-color:#d2d5db;">
					<span onclick="document.getElementById('emailModel').style.display='none'"
						class="w3-button w3-display-topright">
						&times;
					</span>
					<cfoutput>
						<h3>
							Send Report To:
							<span style="font-weight:bold">
								#SESSION.name#
							</span>
						</h3>
					</cfoutput>
				</header>
				<div class="w3-container" style="height:400px;overflow-y: auto;">
					<h3>
						Executive Management:
					</h3>
					<cfloop query="#VARIABLES.getUsers#" >
						<cfoutput>
							<cfif role EQ "Executive Management">
								<input type="checkbox" value="#email#" name="emails">
								<span style="width:170px;display: -webkit-inline-box;">
									#name#
								</span>
							</cfif>
						</cfoutput>
					</cfloop>
					<h3>
						Analyst Team:
					</h3>
					<cfloop query="#VARIABLES.getUsers#" >
						<cfoutput>
							<cfif role EQ "Analyst Team">
								<input type="checkbox" value="#email#" name="emails">
								<span style="width:170px;display: -webkit-inline-box;">
									#name#
								</span>
							</cfif>
						</cfoutput>
					</cfloop>
					<h3>
						Research:
					</h3>
					<cfloop query="#VARIABLES.getUsers#" >
						<cfoutput>
							<cfif role EQ "Research">
								<input type="checkbox" value="#email#" name="emails">
								<span style="width:170px;display: -webkit-inline-box;">
									#name#
								</span>
							</cfif>
						</cfoutput>
					</cfloop>
					<h3>
						Real Estate:
					</h3>
					<cfloop query="#VARIABLES.getUsers#" >
						<cfoutput>
							<cfif role EQ "Real Estate">
								<input type="checkbox" value="#email#" name="emails">
								<span style="width:170px;display: -webkit-inline-box;">
									#name#
								</span>
							</cfif>
						</cfoutput>
					</cfloop>
					<h3>
						Support/Admin:
					</h3>
					<cfloop query="#VARIABLES.getUsers#" >
						<cfoutput>
							<cfif role EQ "Admin">
								<input type="checkbox" value="#email#" name="emails">
								<span style="width:170px;display: -webkit-inline-box;">
									#name#
								</span>
							</cfif>
						</cfoutput>
					</cfloop>
					<br>
					<textarea style="height:100px; width:850px; margin-top: 10px;" heigh  id="xtraMessage" placeholder="Enter Additional Email Contents"
						>
					</textarea>
				</div>
				<footer class="w3-container">
					<hr>
					<input type="button" value="SEND" id="send"style="margin-left: 45%; margin-top:10px">
				</footer>
			</div>
		</div>
		<!--- -------------------------------------------------------------------------- --->
		<!--- -------------------------------------------------------------------------- --->
		<script src="../assets/js/jquery.js" type="text/javascript"></script>
		<script src="../assets/js/message.js" type="text/javascript"></script>
		<script src="../assets/js/bootstrap_3_3_7.js" type="text/javascript"></script>
		<script src="../assets/js/task.js" type="text/javascript"></script>
		<script src="../assets/js/sendEmail.js" type="text/javascript"></script>
		<script src="../assets/js/companyLogo.js" type="text/javascript"></script>
		<script src="../assets/js/navbar.js" type="text/javascript"></script>
		<script src="../assets/js/datatable_1_10_19_min.js" type="text/javascript"></script>
		<script src="../assets/js/google_chart_loader.js" type="text/javascript"></script>
		<script src="../assets/js/googleChart.js" type="text/javascript"></script>
		<script src="../ckeditor/ckeditor.js" type="text/javascript"></script>
		<script src="../assets/js/ckEditor.js"></script>
		<script src="../assets/js/sticky.js" type="text/javascript"></script>
	</body>
</html>
