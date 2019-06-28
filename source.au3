#include <Array.au3>
#include <GDIPlus.au3>

$photo = FileOpenDialog('', @WindowsDir & "\", "All (*.*)", $FD_FILEMUSTEXIST)

getPhotoCaptureTime($photo)

Func getPhotoCaptureTime($photo)

	_GDIPlus_Startup()

	$photo = _GDIPlus_ImageLoadFromFile($photo)

	If @error Then
		_GDIPlus_Shutdown()
		MsgBox(16, "", "An error has occured - unable to load image!", 30)
		Return False
	EndIf

	$capture_time = _GDIPlus_ImageGetPropertyItem($photo, 306)

	_GDIPlus_ImageDispose($photo)
	_GDIPlus_Shutdown()

	Return $capture_time[0]

EndFunc
