#!/bin/bash

# Automatically switch to the directory where this script lives
cd "$(dirname "$0")"

# Load environment variables safely
export $(grep -v '^#' .env | xargs)

/Users/mariusbock/LocalDocuments/Development/Rust/crypto_price/target/release/crypto_price
exit 0
