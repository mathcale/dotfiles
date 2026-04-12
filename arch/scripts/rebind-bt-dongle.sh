#!/bin/bash

set -euo pipefail

VENDOR="0a12"
PRODUCT="0001"

echo "Resetting Bluetooth dongle ($VENDOR:$PRODUCT)..."
usbreset "$VENDOR:$PRODUCT"
