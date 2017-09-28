Testing
-

**Assertion:**
The workflow should incorporate a comprehensive test strategy that integrates
with the developers' workflows.

**Assumption:**
Such a framework exists for Ruby/Rails that easily integrates into _Hello World
Inc._'s application source code.

**Assumption:**
Just for the sake of argument, I'll assume that a unit testing framework can be
added to the application code with the addition of a `tests/` directory at the
root of the code tree which contains functional testing specs and jobs to run
these tests.

We could use Travis or Drone or Circle CI or Jenkins or probably other solutions here. Let's just go with Travis for this exercise.

A GitHub service hook will be created in GitHub to allow Travis to monitor PRs
into the upstream repository. When a developer submits a PR, this will trigger
Travis to instantiate a new stack running the application and the new code will
be deployed to the new stack. The `tests/` will be run and the results of the
tests will be fed back into GitHub. The dev team will still code review as
usual, but testing results will be reported before merging. 
