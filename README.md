# CI Autoship

A modular tool to manage software versioning, publishing and many other devops routines.

## Operating Modes

CI Autoship can operate in two modes:

1. When linked to working repository and executed there, it can also use local copy of the project (*devel*).
2. When executed in this repostirory, all project code will be fetched from remote repositories (*ci*).

## Usage

Simply start `./ci` or link it to the root of your project repository and run it there. It will
list available tasks you can run.

## Requirements

Just `bash`, `docker`, `jq` and few basic GNU command-line utils. Main script checks all tools on
the first run.

## Phases of the Task Run

TODO: Write.

## Environment Variables in Scripts

During the execution the following environment variables gets set:

* `BRANCH` - Name of the branch for running a task.
* `PLATFORM` - Either 'local' or 'docker' depending on the execution context.
* `REPO` - Name of the repository for running a task.
* `ROOTDIR` - The directory containing CI Autoship code.
* `WORKDIR` - The root directory of the working project.

## Top Level Configuration

* `PROJECT` - Symbolic name of the project.

## Testing

To run self test
```
cd test
./test-autoship
```
