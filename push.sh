#!/bin/bash

docker tag frrocc/db frrocc/db:$(git rev-parse HEAD) 
docker push frrocc/db:$(git rev-parse HEAD)