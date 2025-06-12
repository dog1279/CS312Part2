#!/bin/bash
set -e

echo "=== Cleaning up Minecraft Server Infrastructure ==="

cd terraform
terraform destroy -auto-approve

echo "=== Cleanup Complete ==="