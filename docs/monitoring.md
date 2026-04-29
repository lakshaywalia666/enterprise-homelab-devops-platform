# Homelab Monitoring

This document describes the uptime monitoring setup for the Enterprise Homelab DevOps Platform.

## Monitoring Tool

Uptime Kuma is used to monitor core homelab services.

Dashboard:

    http://192.168.1.18:3001

## Monitored Services

| Monitor Name | Type | Target | Status |
|---|---|---|---|
| Homelab Demo App | HTTP(s) | http://192.168.1.18:8080/health | UP |
| Local Docker Registry | HTTP(s) | http://192.168.1.18:5000/v2/ | UP |
| Portainer | HTTP(s) | https://192.168.1.18:9443 | UP |
| SSH Server | TCP Port | 192.168.1.18:22 | UP |

## Current Dashboard Summary

| Metric | Value |
|---|---:|
| Up | 4 |
| Down | 0 |
| Maintenance | 0 |
| Unknown | 0 |
| Paused | 0 |

## Notes

The SSH monitor uses a fixed Docker network for Uptime Kuma.

| Item | Value |
|---|---|
| Uptime Kuma fixed IP | 172.30.10.10 |
| Uptime Kuma subnet | 172.30.10.0/24 |
| Firewall access | 172.30.10.0/24 to port 22 |

## Verification Commands

Check running containers:

    docker ps

Check registry health:

    curl http://192.168.1.18:5000/v2/

Check demo app health:

    curl http://192.168.1.18:8080/health

Check Uptime Kuma fixed IP:

    docker inspect uptime-kuma --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'

Test SSH access from Uptime Kuma container:

    docker exec uptime-kuma node -e "const net=require('net'); const s=net.connect(22,'192.168.1.18',()=>{console.log('SSH_OK');process.exit(0)}); s.on('error',e=>{console.error('SSH_FAIL:',e.message);process.exit(1)}); setTimeout(()=>{console.error('TIMEOUT');process.exit(1)},5000)"
