#include <windows.h>

fn C.MessageBox(hwnd int, lpText &u16, lpCaption &u16, uType u32) int


result := C.MessageBox(0, 'Hallo, wereld!'.to_wide(), 'Mijn eerste MessageBox'.to_wide(), 0)
println(result)
