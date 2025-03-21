property area:="myVPArea"
property windowRef : Integer
property pdfPath : Text
property trace : Boolean
property VPdocument : Text

property peoplePagination : cs:C1710.PaginateTable
property EntitySelection : Object

property autoQuit:=False:C215
property timeout:=100

Class constructor($windowRef : Integer; $pdfPath : Text; $trace : Boolean)
	
	This:C1470.windowRef:=$windowRef
	This:C1470.pdfPath:=$pdfPath
	This:C1470.trace:=$trace
	This:C1470.VPdocument:=Get 4D folder:C485(Current resources folder:K5:16)+"hdi.4vp"
	This:C1470.peoplePagination:=cs:C1710.PaginateTable.new(ds:C1482.People.all())
	This:C1470.EntitySelection:=This:C1470.peoplePagination.Next()
	
	// Initializes the progress bar
	CALL FORM:C1391(This:C1470.windowRef; "ProgressBarAdvancement"; 0; "Initializing custom functions")
	
Function onEvent
	Case of 
		: (FORM Event:C1606.code=On Load:K2:1)
			This:C1470._allowDataStoreFields()
			
			
		: (FORM Event:C1606.code=On VP Ready:K2:59)
			// Updates the progress bar
			CALL FORM:C1391(This:C1470.windowRef; "ProgressBarAdvancement"; 25; "Loading document")
			
			If (This:C1470.trace)
				TRACE:C157
			End if 
			
			var $this:=This:C1470
			// Starts the document import and initialize the callback as the _exportPDF() function
			VP IMPORT DOCUMENT(This:C1470.area; This:C1470.VPdocument; {formula: Formula:C1597($this._exportPDF())})
			
		: (FORM Event:C1606.code=On URL Loading Error:K2:48)
			CANCEL:C270
			
	End case 
	
Function _exportPDF()
	If (This:C1470.trace)
		TRACE:C157
	End if 
	
	var $this:=This:C1470
	// updates the progress bar
	CALL FORM:C1391(This:C1470.windowRef; "ProgressBarAdvancement"; 75; "PDF creation")
	// Starts the pdf creation. The VP offscreen will be closed in the callback called at the end of the export
	// The call back is the _PDFCallback function
	VP EXPORT DOCUMENT(This:C1470.area; This:C1470.pdfPath; {formula: Formula:C1597($this._PDFCallback($1; $2; $3; $4)); windowRef: This:C1470.windowRef})
	
	// Method called at the end of the PDF export
Function _PDFCallback($areaName : Text; $filePath : Text; $paramObj : Object; $status : Object)
	If (This:C1470.trace)
		TRACE:C157
	End if 
	
	If ($status.success)
		CALL FORM:C1391($paramObj.windowRef; "ProgressBarAdvancement"; 100; "")
		ACCEPT:C269
		OPEN URL:C673($filePath)
	Else 
		ALERT:C41("Error: "+$status.errorMessage)
		CANCEL:C270
	End if 
	
Function _allowDataStoreFields
	// Initializes the list of fields used in the document
	// ----------------------------------------------------
	
	var $customFunctions; $entitySelection : Object
	
	$customFunctions:={}
	
	$entitySelection:=This:C1470.EntitySelection
	
	$customFunctions.People_Portrait_S:={}
	$customFunctions.People_Portrait_S.formula:=Formula:C1597($entitySelection[$1].Portrait_S)
	$customFunctions.People_Portrait_S.parameters:=[{name: "num"; type: Is integer:K8:5}]
	
	$customFunctions.People_Title:={}
	$customFunctions.People_Title.formula:=Formula:C1597($entitySelection[$1].Title)
	$customFunctions.People_Title.parameters:=[{name: "num"; type: Is integer:K8:5}]
	
	$customFunctions.People_Firstname:={}
	$customFunctions.People_Firstname.formula:=Formula:C1597($entitySelection[$1].Firstname)
	$customFunctions.People_Firstname.parameters:=[{name: "num"; type: Is integer:K8:5}]
	
	$customFunctions.People_Lastname:={}
	$customFunctions.People_Lastname.formula:=Formula:C1597($entitySelection[$1].Lastname)
	$customFunctions.People_Lastname.parameters:=[{name: "num"; type: Is integer:K8:5}]
	
	$customFunctions.People_Address:={}
	$customFunctions.People_Address.formula:=Formula:C1597($entitySelection[$1].Address)
	$customFunctions.People_Address.parameters:=[{name: "num"; type: Is integer:K8:5}]
	
	$customFunctions.People_ZipCode:={}
	$customFunctions.People_ZipCode.formula:=Formula:C1597($entitySelection[$1].ZipCode)
	$customFunctions.People_ZipCode.parameters:=[{name: "num"; type: Is integer:K8:5}]
	
	$customFunctions.People_City:={}
	$customFunctions.People_City.formula:=Formula:C1597($entitySelection[$1].City)
	$customFunctions.People_City.parameters:=[{name: "num"; type: Is integer:K8:5}]
	
	$customFunctions.People_Country:={}
	$customFunctions.People_Country.formula:=Formula:C1597($entitySelection[$1].Country)
	$customFunctions.People_Country.parameters:=[{name: "num"; type: Is integer:K8:5}]
	
	$customFunctions.People_Phone:={}
	$customFunctions.People_Phone.formula:=Formula:C1597($entitySelection[$1].Phone)
	$customFunctions.People_Phone.parameters:=[{name: "num"; type: Is integer:K8:5}]
	
	$customFunctions.People_email:={}
	$customFunctions.People_email.formula:=Formula:C1597($entitySelection[$1].email)
	$customFunctions.People_email.parameters:=[{name: "num"; type: Is integer:K8:5}]
	
	var $area:=This:C1470.area
	VP SET CUSTOM FUNCTIONS($area; $customFunctions)