// Copyright (c) Seth Hoenig
// SPDX-License-Identifier: MPL-2.0

//go:build linux

package main

import (
	"github.com/shoenig/go-landlock"
)

func lockdown(directory string) {
	ll := landlock.New(
		landlock.Dir(directory, "rwc"),
	)
	assert(ll.Lock(landlock.Mandatory))
}

func assert(err error) {
	if err != nil {
		panic(err)
	}
}
