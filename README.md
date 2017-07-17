# madam a.k.a mruby-ipvsadm

Set ipvs from json

## build

for ubuntu
```
$ apt-get install build-essential bison libnl-3-dev
$ ln -s /lib/x86_64-linux-gnu/libnl-3.so /lib/x86_64-linux-gnu/libnl.so
$ rake compile
```

## example
```json
$ cat sample/sample.json
[
  {
    "virtual_ip":"192.168.0.1",
    "virtual_port":443,
    "protocol":0,
    "dests": [
      {
        "ip": "10.0.0.1",
        "port": 443
      },
      {
        "ip": "10.0.0.2",
        "port": 443
      }
    ]
  }
]
```

```bash
$ madam apply $(cat sample/sample.json)
```
