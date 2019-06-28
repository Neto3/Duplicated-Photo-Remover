#include <Array.au3>
#include <Date.au3>
#include <File.au3>
#include <GDIPlus.au3>

$dir = FileSelectFolder ("", "c:")

$dir_2 = $dir & '\2'
If FileExists($dir_2) == 0 Then
	DirCreate($dir_2)
EndIf

$files = _FileListToArray($dir)

For $i = 1 To $files[0] - 1

	$file_1 = $dir & '\' & $files[$i]
	$file_2 = $dir & '\' & $files[$i+1]

	If StringInStr($file_1, 'jpg', 0) > 0 And StringInStr($file_2, 'jpg', 0) > 0 Then

		$time_diff = comparePhotoCaptureTimes($file_1, $file_2)

		If $time_diff <= 2 Then

			FileMove($file_2, $dir_2 & '\' & $files[$i+1])

			$i = $i + 1

		EndIf

	EndIf

Next

Func comparePhotoCaptureTimes($photo_1, $photo_2)

	$capture_time_1 = StringReplace(getPhotoCaptureTime($photo_1), ":", "/", 2)

	$capture_time_2 = StringReplace(getPhotoCaptureTime($photo_2), ":", "/", 2)

	$time_diff = _DateDiff('s', $capture_time_1, $capture_time_2)

	Return Abs($time_diff)

EndFunc


Func getPhotoCaptureTime($file)

	_GDIPlus_Startup()

	$photo = _GDIPlus_ImageLoadFromFile($file)

	If @error Then
		_GDIPlus_Shutdown()
		MsgBox(16, "", "An error has occured - unable to load image!" & $file, 30)
		Return False
	EndIf

	$capture_time = _GDIPlus_ImageGetPropertyItem($photo, 306)

	_GDIPlus_ImageDispose($photo)
	_GDIPlus_Shutdown()

	Return $capture_time[1]

EndFunc
