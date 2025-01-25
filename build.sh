#!/usr/bin/env bash
VERSION=2.0

docker build -t phil1pp/vcontrold:$VERSION .
docker push phil1pp/vcontrold:$VERSION
docker tag phil1pp/vcontrold:$VERSION phil1pp/vcontrold:latest
docker push phil1pp/vcontrold:latest
