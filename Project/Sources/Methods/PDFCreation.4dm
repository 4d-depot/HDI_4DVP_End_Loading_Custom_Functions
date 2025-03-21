//%attributes = {"invisible":true}
// Inits the offscreen area and starts the pdf creation
#DECLARE($windowRef : Integer; $pdfPath : Text; $trace : Boolean)

var $offScreen : cs:C1710.OffScreen

// creation of the offscreen object to init the offscreen area
$offScreen:=cs:C1710.OffScreen.new($windowRef; $pdfPath; $trace)

// creation of the offscreen area
VP Run offscreen area($offScreen)

CALL FORM:C1391($windowRef; "PDFState"; Bool:C1537(OK))
