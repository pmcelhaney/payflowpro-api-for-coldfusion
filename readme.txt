PayFlowPro Components for Cold Fusion

Simple interface to process credit card transactions via Verisign PayFlowPro. It wraps around the HTTP interface using CFHTTP.

<!--- Change "TEST" to "LIVE" in live code --->
<cfset gateway = createObject("component", "HTTPPayFlowProGateway").init("TEST")>	

<cfset transaction = variables.paymentGateway.createTransaction()>
<cfset transaction.setVendor(vendor)>
<cfset transaction.setUsernameAndPassword(username,password )>
<cfset transaction.setCardNumber(card_number)>	
<cfset transaction.setExpirationMonthAndYear(expiration_month, expiration_year)>
<cfset transaction.setAmount(amount_to_charge)>
<cfset transaction.run()>

<cfoutput>
Approved? #transaction.approved()#<br>
Result Code: #transaction.resultCode()#<br>
Response Message: #transaction.responseMessage()#
</cfoutput>