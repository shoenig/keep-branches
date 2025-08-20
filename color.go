// Copyright (c) Seth Hoenig
// SPDX-License-Identifier: MIT

package main

const (
	reset  = "\033[0m"
	red    = "\033[31m"
	yellow = "\033[33m"
)

func format(label string) string {
	return red + " DEL " + yellow + " " + label + reset
}
