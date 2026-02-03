# Linux Health Checker & Auto-Recovery System

This project simulates how a university Linux lab or shared research server can automatically monitor itself and recover from abuse.

It uses:
- vim
- bash
- cron
- nginx
- systemd
- logging in /var/log

Every minute it checks CPU and disk usage, kills runaway processes, restarts nginx, and logs all activity.

