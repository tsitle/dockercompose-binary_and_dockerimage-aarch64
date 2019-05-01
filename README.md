# docker-compose binary for aarch64/arm64v8/arm64

This repository provides a **docker-compose** binary for aarch64/arm64v8/arm64 as well as the Docker Image used for building it.  

## Using the pre-built binary
Copy the binary from ``./binary/`` to ``/usr/bin/docker-compose`` on the **AARCH64** machine.  
Then make sure the binary is executable.

```
$ sudo cp ./binary/docker-compose-Linux-aarch64-* /usr/bin/docker-compose
$ sudo chmod 755 /usr/bin/docker-compose
```

Verify that the binary is OK:

```
$ docker-compose --version
```

## Building the binary
### Cross-building on a X64/AMD64 host
On the X64/AMD64 host, run:

```
$ cd cross-build
$ ./build_binary.sh
```

This will generate the binary ``docker-compose-Linux-aarch64-VERSION`` in ``./cross-build/dist/``.

Copy binary from ``./cross-build/dist/`` folder to ``/usr/bin/docker-compose`` on the **AARCH64** machine.

Then make sure the binary is executable on the **AARCH64** machine:

```
$ sudo chmod 755 /usr/bin/docker-compose
```

### Building on an AARCH64/ARM64v8/ARM64 host
On the AARCH64/ARM64v8/ARM64 host, run:

```
$ cd native-build
$ ./build_binary.sh
```

This will generate the binary ``docker-compose-Linux-aarch64-VERSION`` in ``./native-build/dist/``.

Copy binary from ``./native-build/dist/`` folder to ``/usr/bin/docker-compose`` on the **AARCH64** machine.

Then make sure the binary is executable on the **AARCH64** machine:

```
$ sudo chmod 755 /usr/bin/docker-compose
```

---

The Docker Image is based on: [https://github.com/ubiquiti/docker-compose-aarch64](https://github.com/ubiquiti/docker-compose-aarch64)
