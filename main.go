// Command keep-branches is used to prune your local git repository
// of unwanted feature branches, etc.
package main

// Usage: keep-branches <branch, ...>
// Will remove any branch that is not main, the current branch, or
// listed in the command line arguments.

import (
	"fmt"
	"os"
	"strings"

	"github.com/go-git/go-git/v5"
	"github.com/go-git/go-git/v5/plumbing"
	"github.com/hashicorp/go-set"
)

func main() {
	help(os.Args)

	keep := set.From(os.Args[1:])
	keep.Insert("main")

	lockdown() // lockout filesystem

	r, err := git.PlainOpen(".")
	check(err)

	head, err := r.Head()
	check(err)
	keep.Insert(branch(head))

	it, err := r.Branches()
	check(err)

	err = it.ForEach(func(ref *plumbing.Reference) error {
		label := branch(ref)
		if !keep.Contains(label) {
			fmt.Println("DELETE", label)
			del := hash(head, label)
			return r.Storer.RemoveReference(del.Name())
		}
		return nil
	})
	check(err)
}

func check(err error) {
	if err != nil {
		fmt.Println("[failure]", err)
		os.Exit(1)
	}
}

func branch(r *plumbing.Reference) string {
	name := string(r.Name())
	return strings.TrimPrefix(name, "refs/heads/")
}

func hash(head *plumbing.Reference, branch string) *plumbing.Reference {
	name := plumbing.ReferenceName("refs/heads/" + branch)
	return plumbing.NewHashReference(name, head.Hash())
}

func help(args []string) {
	if len(args) == 2 {
		switch args[1] {
		case "-h", "-help", "--help":
			fmt.Println("keep-branches <branches>")
			os.Exit(0)
		}
	}
}
