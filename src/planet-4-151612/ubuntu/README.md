# docker-ubuntu-base

https://registry.hub.docker.com/u/greenpeace/ubuntu/

Automated daily build of an Ubuntu Xenial base image from phusion/baseimage (https://github.com/phusion/baseimage-docker/blob/master/Changelog.md#0919-release-date-2016-07-08).

- Includes Jason Wilder's handy [Dockerize](https://github.com/jwilder/dockerize) binary
- Defines structures for source environment files (`/app/env/`), copying `/app/etc` to `/etc`
- Modified apt sources.list to use `http://mirror.rackspace.com/ubuntu/`, which seems reliable, fast and local to most servers
- Container timezone is set via environment variable `CONTAINER_TIMEZONE`, defaults to `UTC`
