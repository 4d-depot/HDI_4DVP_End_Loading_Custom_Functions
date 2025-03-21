//%attributes = {"invisible":true}
#DECLARE ($isOK : Boolean)

If (Not:C34($isOK))
	ALERT:C41("An error is occured during the creation of the PDF document")
End if 

ProgressBarAdvancement(0; "")
OBJECT SET VISIBLE:C603(*; "Thermometer"; False:C215)