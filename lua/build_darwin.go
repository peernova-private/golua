// +build darwin

package lua

// #cgo CFLAGS: -I${SRCDIR}/../3rdparty/include
// #cgo LDFLAGS: ${SRCDIR}/../3rdparty/lib/darwin_amd64/liblua.a -lm -ldl
import "C"
