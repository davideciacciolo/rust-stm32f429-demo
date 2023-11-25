#!/bin/bash

# This script sets up Rust targets for ARM Cortex-M4F microcontrollers
# Usage: ./setup.sh

# Auxiliary function to check and report status
check_status() {
    local exit_code=$1
    local error_message=$2
    if [ $exit_code -ne 0 ]; then
        echo "Error: $error_message"
        exit 1
    fi
}

# Check if rustup is available
if ! command -v rustup &>/dev/null; then
    echo "Error: rustup is not installed. Please install rustup before running this script."
    exit 1
fi

# Set Rust edition (stable)
echo "Setting Rust edition to stable..."
rustup default stable
check_status $? "Failed to set Rust edition."
echo "Rust edition has been set successfully."

# TODO add printing and error handling for the next 2 lines
cargo install cargo-binutils
rustup component add llvm-tools-preview
# TODO install the right version of gdb for embedded programming

cortex_version="Cortex-M4F"
target="thumbv7em-none-eabihf"
echo "Adding target for ${cortex_version} ($target)..."
rustup target add "$target"
check_status $? "Failed to add the target for ${cortex_version} ($target)."
echo "Rust target has been set up succesfully"

# TODO check if there is some tool missing for setup

