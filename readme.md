# Deploy blue-green

Application Node.js + Nginx with blue-green deploy

**[By Cloud Foundry](https://docs.cloudfoundry.org/devguide/deploy-apps/blue-green.html)**:

*Blue-green deployment is a technique that reduces downtime and risk by running two identical production environments called Blue and Green. At any time, only one of the environments is live, with the live environment serving all production traffic. For this example, Blue is currently live and Green is idle.*

## Structure

```
|-- app # Node.js application
|-- docker
|   |-- nginx # Nginx configs
|   |-- docker-compose.yml # application and Nginx containers
|   |-- Dockerfile # Node.js image
|-- deploy.sh # deploy script
|-- test.sh # script to test request
```

## Requirements

- Docker & Docker compose

## Running
```
chmod +x deploy.sh
./deploy.sh
```

First execution:
```
Current version: green
New version: blue
Starting deploy
First deploy
Kill old container
```

Alternate execution:
```
Current version: blue
New version: green
Starting deploy
Deploy blue-green
Redirect traffic
[ ok ] Reloading nginx: nginx.
Kill old container
```

## Testing
```
chmod +x test.sh
./test.sh
```

This script shows the HTTP response status. If empty is printed, then ocurred a error.