#include <Array.au3>
#include <Date.au3>
#include <GDIPlus.au3>

$photo_1 = FileOpenDialog('', @WindowsDir & "\", "All (*.*)", $FD_FILEMUSTEXIST)

$capture_time_1 = StringReplace(getPhotoCaptureTime($photo_1), ":", "/", 2)

$photo_2 = FileOpenDialog('', @WindowsDir & "\", "All (*.*)", $FD_FILEMUSTEXIST)

$capture_time_2 = StringReplace(getPhotoCaptureTime($photo_2), ":", "/", 2)

$time_diff = _DateDiff('s', $capture_time_1, $capture_time_2)


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

	Return $capture_time[1]

EndFunc
