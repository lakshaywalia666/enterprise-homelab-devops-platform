# Reboot Survival Test

This document proves that the Enterprise Homelab DevOps Platform services automatically recover after a server reboot.

## Test Date

2026-04-29

## Server

| Item | Value |
|---|---|
| Hostname | gateway-home-server |
| IP Address | 192.168.1.18 |
| OS | Ubuntu Server 24.04 LTS |
| Main Directory | /srv/homelab |

## Services Tested

| Service | Port | Result |
|---|---:|---|
| Portainer | 9443 | Running after reboot |
| Uptime Kuma | 3001 | Healthy after reboot |
| Demo App | 8080 | Healthy after reboot |
| SSH | 22 | Reachable after reboot |

## Verification Commands

Check running containers:

    docker ps

Check demo app health endpoint:

    curl http://192.168.1.18:8080/health

Check Uptime Kuma fixed container IP:

    docker inspect uptime-kuma --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'

Check SSH from inside Uptime Kuma:

    docker exec uptime-kuma node -e "const net=require('net'); const s=net.connect(22,'192.168.1.18',()=>{console.log('SSH_OK');process.exit(0)}); s.on('error',e=>{console.error('SSH_FAIL:',e.message);process.exit(1)}); setTimeout(()=>{console.error('TIMEOUT');process.exit(1)},5000)"

## Results

Demo app health endpoint returned:

    {"status":"healthy"}

Uptime Kuma fixed IP:

    172.30.10.10

SSH monitor test:

    SSH_OK

## Conclusion

The homelab services successfully restarted after reboot. Docker services are configured with restart policies, and Uptime Kuma uses a fixed Docker network to keep SSH monitoring stable.
