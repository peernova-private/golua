// +build linux

package lua

// #cgo CFLAGS: -I${SRCDIR}/../../../../../3rdparty/include
// #cgo LDFLAGS: ${SRCDIR}/../../../../../3rdparty/lib/linux_amd64/liblua.a -lm -ldl
//
//#include <lua/lua.h>
//#include <lua/lualib.h>
//#include <stdlib.h>
//
//#include "golua.h"
//
import "C"
