# Robotest: E2E testing with the Robot Framework

> **Robot Framework** is a generic open source automation framework. It can be
> used for test automation and robotic process automation (RPA).

The framework was initially developed at Nokia and was open sourced in 2008.

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

### Environment specific variables

Copy the `env.yaml.example` file and fill in the missing values:

    $ cp env.yaml.example qas.yaml

### Secrets

Fetched from a [Vault](https://www.vaultproject.io/) instance.

**Note**: Be sure to set the `VAULT_ADDR` and `GITHUB_TOKEN` environment
variables before running the tests.

_TODO_: Refactor into external `robotframework-vault` library.

## Test organisation and structure

All tests are organised according to the following structure:

```
tests
└── platform
    └── system
        └── function
```

For instance:

```
tests
├── mediahaven
│   ├── ftp-tra.robot
│   ├── http.resource
│   ├── monitoring
│   │   └── monitoring.robot
│   ├── oai-pmh
│   │   └── oai-pmh.robot
│   └── rest
│       └── rest-users.robot
└── meemoo
    ├── organisations_api
    │   ├── org-api.robot
    │   └── schemas
    │       └── org_api.json
    └── pid_webservice
        ├── pid_webservice.robot
        ├── pid_webservice.schemagen.robot
        └── schemas
            └── pid_webservice.json
```

Four different filetypes:

- `.robot` files
  These are the files that contain the actaul tests.
- `.resource` files
  These files containt higher-order keywords to be used in the actual test
(`.robot`) files.
- `.schemagen.robot` files
  These files contain the code that generate schemas from HTTP-responses (be it
json or xml).
- `.json` files
  These files contain the schemas generate by the `.schemagen` files.

When running the tests, only the actual test files (`.robot` files) are
executed. The `.schemagen` files are always excluded based on their tag
(`schemagen`). This behaviour is controlled by the `<env>.args` files. For
example `int.args`:


```
--logtitle Test Log: INT
--reporttitle Test Report: INT
--pythonpath ./libraries
--exclude schemagen
--include int
--norpa
```

## Running the tests

Select the environment to test by setting an environment variable (`int`, `qas`
or `prd`) and run the tests with:

    $ export ENV=qas
    $ pipenv run robot -A ${ENV}.args -V ${ENV}.yaml --outputdir ./results ./tests

View the HTML report in your browser at: `WORK_DIR/results/report.html`

## Concepts

This will give you a short introduction on the concepts in use in the Robot
Framework. For more in depth documentation, check out
[RobotFrameworkUserGuide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html).

_TODO_:
- Keywords and Higher Order Keywords
- Test Suites
- Test Cases
- Tasks (RPA)
- Tags

### Tags

_TODO_

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

## Caveats

### Clear Expectations

Validating responses, within a single Test Case, against a JSON schema via the
`Expect Response` keyword should always be followed by the `Clear Expectations`
keyword. If not, a `KeyError: 'request'` is raised.
