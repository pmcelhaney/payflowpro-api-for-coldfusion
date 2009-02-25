<cfcomponent>

<cffunction name="init" output="no">
	<cfargument name="mode">
	<cfswitch expression="#arguments.mode#">
		<cfcase value="LIVE">
			<cfset variables.gatewayURL = "https://payflowpro.verisign.com:443">
		</cfcase>
		<cfcase value="TEST">
			<cfset variables.gatewayURL = "https://pilot-payflowpro.verisign.com:443">
		</cfcase>
		<cfdefaultcase>
			<cfthrow  message = "You must specify either LIVE or TEST in the init() method.">
		</cfdefaultcase>
	</cfswitch>
	<cfreturn this>
</cffunction>

<cffunction name = "createTransaction">
	<cfreturn createObject("component", "PayFlowProTransaction").init(this)>
</cffunction>


<cffunction name = "chargeCard">
	<cfargument name="params">
	<cfargument name="transactionID">

	<CFHTTP url="#variables.gatewayURL#" method="post" resolveurl="no" timeout="30">
		 <CFHTTPPARAM type="header" name="X-VPS-REQUEST-ID" value="#arguments.transactionID#">
		 <CFHTTPPARAM type="header" name="X-VPS-CLIENT-TIMEOUT" value="30">
		 <CFHTTPPARAM type="body" value="#encodeURLData(arguments.params)#">
	</CFHTTP>

	<cfreturn parseURLData(CFHTTP.FileContent)>
</cffunction>
	
<cffunction name = "encodeURLData" output="no">
	<cfargument name="params">
	<cfset var key = 0>
	<cfset var pairs = arrayNew(1)>
	<cfloop collection = "#arguments.params#" item = "key">
		<cfset arrayAppend(pairs, "#key#=#params[key]#")>
	</cfloop>
	<cfreturn arrayToList(pairs, "&")>
</cffunction>

<cffunction name = "parseURLData" output="no">
	<cfargument name="params">
	<cfset var data = StructNew()>
	<cfset var key = 0>
	<cfloop list="#params#" index="key" delimiters="&">
	   <cfset data[listFirst(key,'=')] = urlDecode(listRest(key,"="))>
	</cfloop>
	<cfreturn data>
</cffunction>

</cfcomponent>