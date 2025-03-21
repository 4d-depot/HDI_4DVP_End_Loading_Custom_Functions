Class constructor($EntitySelection : Object)
	// Calculation of the new page to display
	
	This:C1470.nextRecord:=0
	This:C1470.firstRecord:=0
	This:C1470.lastRecord:=0
	This:C1470.recordNumber:=99
	This:C1470.info:=""
	This:C1470.EntitySelection:=$EntitySelection
	
Function Next->$selection : Object
	
	// if no other records, return to the first
	If (This:C1470.EntitySelection.length<This:C1470.nextRecord)
		This:C1470.nextRecord:=0
	End if 
	
	// part of the entity selection that must be showed
	$selection:=This:C1470.EntitySelection.slice(This:C1470.nextRecord; This:C1470.nextRecord+This:C1470.recordNumber)
	
	// calculation of the first and last records
	This:C1470.firstRecord:=This:C1470.nextRecord
	This:C1470.lastRecord:=This:C1470.nextRecord+$selection.length
	
	This:C1470.nextRecord:=This:C1470.nextRecord+This:C1470.recordNumber+1