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

# TODO install rustup if not available
# Check if rustup is available
if ! command -v rustup &>/dev/null; then
    echo "Error: rustup is not installed. Please install rustup before running this script"
    exit 1
fi

# TODO install cargo if not available
# Check if cargo is available
if ! command -v cargo &>/dev/null; then
    echo "Error: Cargo is not installed. Please install Rust before running this script."
    exit 1
fi

# Set Rust edition interactively
echo "Choose Rust edition:"
select edition in "stable" "beta" "nightly"; do
    case $edition in
        "stable" | "beta" | "nightly")
            echo "Setting Rust edition to $edition..."
            rustup default $edition
            check_status $? "Failed to set Rust edition"
            break
            ;;
        *)
            echo "Invalid selection, please choose a valid edition"
            ;;
    esac
done

# cargo-binutils
echo "Installing 'cargo-binutils'..."
cargo install cargo-binutils
check_status $? "Failed to install 'cargo-binutils'"

# llvm-tools-preview
echo "Installing 'llvm-tools-preview'..."
rustup component add llvm-tools-preview
check_status $? "Failed to install 'llvm-tools-preview'"

# TODO install the right version of gdb for embedded programming

cortex_version="Cortex-M4F"
target="thumbv7em-none-eabihf"
echo "Adding target for ${cortex_version} ($target)..."
rustup target add "$target"
check_status $? "Failed to add the target for ${cortex_version} ($target)"

# TODO check if there is some tool missing for setup

echo "Toolchain setup completed successfully"

