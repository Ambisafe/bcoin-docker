Bcoin on Docker
=====

Build files for bcoin docker image

By default, persists data in user home directory at `~/.bcoin`.

Container based on AlpineLinux for speed and portability.

How To Use
----

> Login to docker cloud
```
$ sudo docker login
```

> Change bcoin version in `docker_build_and_push.sh`
```
$ sudo ./docker_build_and_push.sh
```