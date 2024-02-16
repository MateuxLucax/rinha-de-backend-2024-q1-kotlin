#!/bin/bash

RESULTS_WORKSPACE="$(pwd)/load-test/user-files/results"
GATLING_BIN_DIR=$HOME/gatling/bin
GATLING_WORKSPACE="$(pwd)/load-test/user-files"

runGatling() {
    sh "$GATLING_BIN_DIR"/gatling.sh -rm local -s RinhaBackendCrebitosSimulation \
        -rd "Rinha de Backend - 2024/Q1: Crébito" \
        -rf "$RESULTS_WORKSPACE" \
        -sf "$GATLING_WORKSPACE/simulations"
}

startTest() {
  for i in {1..20}; do
      curl --fail http://localhost:9999/clientes/1/extrato && \
      echo "" && \
      curl --fail http://localhost:9999/clientes/1/extrato && \
      echo "" && \
      runGatling && \
      break || sleep 2;
  done
}

startTest