# aws-ebcli-docker-image

A docker image providing the ElasticBeanstalk CLI tools.

## Description

This builds a docker container for the ebcli tools. The intent is to keep
the ebcli dependencies separate from any other python environment due to
conflicts that can occur between the ebcli and other tools such as the aws-cli.

While AWS provides docker images for other tools, the ebcli does not currently
offer an official image. This image is meant to fill that gap.

The build follows the installation directions from [the aws elastic beanstalk cli setup](https://github.com/aws/aws-elastic-beanstalk-cli-setup).

## Build the image

```shell
docker build -t adamaig/aws-ebcli:2 .
```

## Usage

Add an alias to your shell similar to this:

```shell
alias ebcli="docker run --rm -it -v ${PWD}:/root/work adamaig/aws-ebcli:2 eb"
```
