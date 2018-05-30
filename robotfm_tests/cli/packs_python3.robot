# **integration_packs_doc.rst**: This test suite covers same functionality as: `test_packs_pack.yaml <https://github.com/StackStorm/st2tests/blob/master/packs/tests/actions/chains/test_packs_pack.yaml>`_.

*** Test Cases ***

TEST:Verify "packs.setup_virtualenv" with no python3 flag works and defaults to Python 2
    ${result}=          Run Process  st2  run  packs.setup_virtualenv  packs\=examples  -j
    Process Log To Console     ${result}
    Should Contain      ${result.stdout}  "result": "Successfuly set up virtualenv for the following packs: examples"
    Should Contain      ${result.stdout}  ${SUCCESS STATUS}
    ${result}=          Run Process  /opt/stackstorm/virtualenvs/examples/bin/python  --version
    Process Log To Console     ${result}
    Should Contain      ${result.stdout}  Python 2.7.


TEST:Verify "packs.setup_virtualenv" with python3 flag works
    ${result}=          Run Process  st2  run  packs.setup_virtualenv  packs\=examples  python3\=true   -j
    Process Log To Console     ${result}
    Should Contain      ${result.stdout}  "result": "Successfuly set up virtualenv for the following packs: examples"
    Should Contain      ${result.stdout}  ${SUCCESS STATUS}
    ${result}=          Run Process  /opt/stackstorm/virtualenvs/examples/bin/python  --version
    Process Log To Console     ${result}
    Should Contain      ${result.stdout}  Python 3.


TEST:Verify Python 3 virtual environment works
    ${result}=          Run Process  st2  run examples.python_runner_print_python_version  -j
    Should Contain      ${result.stdout}  Using Python executable: /opt/stackstorm/virtualenvs/examples/bin/python
    Should Contain      ${result.stdout}  Using Python version: 3.
    Should Contain      ${result.stdout}  ${SUCCESS STATUS}

*** Settings ***
Library         Process
Library         String
Library         OperatingSystem
Resource        ../common/keywords.robot
Suite Setup     SETUP:Copy and Load Examples Pack
Suite Teardown  TEARDOWN:Uninstall Examples Pack
