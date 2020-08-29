# docker-playsms

| Item            | Info   |
| --------------- | ------ |
| Project update  | 200407 |
| Project version | 2.0    |
| playSMS version | 1.4.3  |

This project is playSMS docker image project.

playSMS is a Free and Open Source SMS Gateway Software. Not A Free SMS Service.

Visit [playSMS](http://playsms.org) website for more information.

## Build

To build the image `yourname/playsms`, execute the following command on the `docker-playsms` folder:

    docker build -t yourname/playsms .

Push your new image to the docker hub:

    docker push yourname/playsms

## Install

Pull/download the image from docker hub:

    docker pull zhironghuang/playsms-gammu:latest

## Usage

See docker-compose.yml for examples

## References

- https://github.com/tutumcloud/tutum-docker-lamp
- https://github.com/tutumcloud/tutum-docker-wordpress
