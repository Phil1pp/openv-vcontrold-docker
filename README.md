# openv-vcontrold-docker

Viessmann Optolink Control based on OpenV library.
This container uses the vcontrold deamon and connect to a Viessmann heating system. To get get the values, the `vclient` tool is used.

## Hardware requirements

To get this working you need an optolink adatper which is connected to the host system. When starting this docker image you need to pass the device into the docker container. As something like /dev/ttyUSB0 can change/vary on reboot, I would recommend to use the serial id from the optolink adapter.

## Software requirements

A Mqtt broker is required in your environment where this container will send the values to. If you just want to test the vclient to get values set MQTTACTIVE = false. Then you can login to the container `docker exec -it openv-vcontrol-docker bash`. In the shell you can then test your commands e.g. `vclient -h 127.0.0.1 -p 3002 -c getTempA`.

## Configuration

The container expects to have the `vcontrold.xml` and `vito.xml` file passed to the `/config` folder.

## Docker

```
docker run -d \
    --name=vcontrold \
    --restart unless-stopped \
    -e TZ=Europe/Vienna \
    -p 3002:3002 \
    -v vcontrold-config:/config \
    --device=/dev/ttyUsbVitocal:/dev/vitocal \
    phil1pp/vcontrold
```
