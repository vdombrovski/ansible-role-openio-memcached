#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

# Tests
@test 'listening' {
  run bash -c "echo 'stats' | nc ${SUT_IP} 12346"
  echo "output: "$output
  echo "status: "$status
  [ "${status}" -eq "0" ]
}


@test 'connection' {
  run bash -c "echo 'stats' | nc ${SUT_IP} 12346 | grep 'accepting_conns' | tr -d '\r'"
  echo "output: "$output
  echo "status: "$status
  [ "${output}" = "STAT accepting_conns 1" ]
}

@test 'get empty data' {
  run bash -c "echo 'get foo' | nc ${SUT_IP} 12346| tr -d '\r'"
  echo "output: "$output
  echo "status: "$status
  [ "${output}" = "END" ]
}


@test 'set test key' {
  run bash -c "echo -e 'add travis 1 0 17\r\ntravis test value\r' | nc ${SUT_IP} 12346| tr -d '\r'"
  echo "output: "$output
  echo "status: "$status
  [ "${output}" = "STORED" ]
}

@test 'delete test key' {
  run bash -c "echo -e 'delete travis' | nc ${SUT_IP} 12346| tr -d '\r'"
  echo "output: "$output
  echo "status: "$status
  [ "${output}" = "DELETED" ]
}
