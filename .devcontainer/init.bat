@echo off
docker pull ghcr.io/ltpn/nedoqs-tutorials:docker
docker image prune --filter "label=ghcr.io/ltpn/nedoqs-tutorials:docker" -f
exit /b 0
