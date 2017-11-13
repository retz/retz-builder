# retz-builder

Retz release package build toolchain, which builds

* RPM package
* DEB package
* Fat jar files for client, server and admin tool

## Usage

Build packages

```sh
$ ls path/to/jdk-8u151-linux-x64/
jdk-8u151-linux-x64.tar.gz
$ ./build.sh path/to/jdk-8u151-linux-x64/ 0.4.0
```

Clean up intermediate files

```sh
$ ./clean.sh
```

## License

APL 2.0

(C) Retz developers, 2017
