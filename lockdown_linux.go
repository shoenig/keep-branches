// Copyright (c) Seth Hoenig
// SPDX-License-Identifier: MIT

//go:build linux

package main

import (
	"github.com/shoenig/go-landlock"
)

func lockdown(directory string) {
	ll := landlock.New(
		landlock.Dir(directory, "rwc"),
	)
	check(ll.Lock(landlock.Mandatory))
}
