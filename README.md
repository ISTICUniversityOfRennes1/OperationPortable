OperationPortable
=================

Tips, scripts and docs for managing the portable


Some docs can be found here. 
(in french) http://olivier.barais.fr/blog/posts/2014.08.29/Operation_portable_M2_ISTIC.html

In you get some troubles with the wifi. You can reinstall the module

```bash
apt-get update
apt-get install --reinstall bcmwl-kernel-source
```

If you try to launch docker with option -d and it fails, try 
```bash
apt-get install apparmor
```
