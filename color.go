// Copyright (c) Seth Hoenig
// SPDX-License-Identifier: MPL-2.0

package main

const (
	reset  = "\033[0m"
	red    = "\033[31m"
	green  = "\033[32m"
	yellow = "\033[33m"
	blue   = "\033[34m"
	purple = "\033[35m"
	cyan   = "\033[36m"
	gray   = "\033[37m"
	white  = "\033[97m"
)

func format(label string) string {
	return red + " DEL " + yellow + " " + label + reset
}
