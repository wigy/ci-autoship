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

In the `modules` directory there are tasks with `.ts` extension. When any of those tasks given as an
argument to `./ci`, it will be exacuted. The execution has steps that can be defined in the task file.
Steps are executed in the following order:
1. `parse_args()` - This function can verify that task arguments are correctly given.
2. `prepare()` - This function is executed in outside of the docker and in can set up and validate
                 an environment needed for the task.
3. `main()` - Actual task that is executed inside the docker containing many useful tools. Working directory
              is mounted there and environment defined from `prepare()` function.
4. `success()` or `fail()` - Either of these functions are executed inside the docker depending on the
                             result of the `main()` function.
4. `cleanup()` - This is executed outside the docker as the last step.

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
