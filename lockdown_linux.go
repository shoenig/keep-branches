//go:build linux

package main

import (
	"github.com/shoenig/go-landlock"
)

func lockdown() {
	ll := landlock.New(
		landlock.Dir(".", "rw"),
	)
	ll.Lock(landlock.Try)
}
