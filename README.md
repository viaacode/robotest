
# Robotest: E2E testing with the Robot Framework

> **Robot Framework** is a generic open source automation framework. It can be
> used for test automation and robotic process automation (RPA).

Some links about:
- the Robot Framework:
	- website: [https://robotframework.org/](https://robotframework.org/)
	- user guide: [https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- RESTinstance:
	- [https://github.com/asyrjasalo/RESTinstance](https://github.com/asyrjasalo/RESTinstance)

## Prerequisites

- Python >=3.6
- [Geckodriver](https://github.com/mozilla/geckodriver/releases/latest) (Download and untar to `/usr/local/bin`)
- [pipenv](https://pipenv-fork.readthedocs.io/en/latest/)

## Installation

    $ pipenv install

## Configuration

Copy the `env.yaml.example` file and fill in the required credentials:

    $ cp env.yaml.example qas.yaml

Copy the `tests/mediahaven/headers.json.example` file and fill in the base-64
Basic auth header:

    $ cp tests/mediahaven/headers.json.example tests/mediahaven/headers.json

## Running the tests

Select the environment to test by setting an environment variable (`int`, `qas`
or `prd`) and run the tests with:

    $ export ENV=qas
    $ pipenv run robot --norpa -A ${ENV}.args -V ${ENV}.yaml --outputdir ./results ./tests

View the HTML report in your browser at: `WORK_DIR/results/report.html`

## Concepts

### Tags

**TODO**: explain

About platforms:

- mediahaven
- meemoo

About environments:

- prd
- qas
- int

About test case categories:

- smoke  
Preliminary testing to reveal simple failures severe enough to, for example,
reject a prospective software release. First tests to be run. If such a test
fails, all further testing is futile.  For example: "Does it start when I turn
on the switch?"
- regression  
Did a bug-fix introduce malfunctions in other parts of the code base? (Or, was
a bug-fix properly shipped...)

### Caveats

#### Clear Expectations

Validating responses, within a single Test Case, against a JSON schema via the
`Expect Response` keyword should always be followed by the `Clear Expectations`
keyword. If not, a `KeyError: 'request'` is raised.

## TODO

- secrets management, possibly via [robotframework-crypto](https://pypi.org/project/robotframework-crypto/)
- ...
