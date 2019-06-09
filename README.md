renat-stats is a ELK docker composer with predefined dashboard to track your renat scenario

### Prepare the renat server to send data to this stack
The renat official container came with this ability already. If you install the renat server by your own, follow these steps to send data to the renat-stats stack.

1. add ELK 7.1 repository `/etc/yum.repos.d/elasticsearch.repo`

```
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```

2. install ELK filebeat

```
$ yum install -y filebeat
```

3. configure filebeat service by editing `/etc/filebeat/filebeat.yml` to have at least those
```yaml:filebeat.yml
filebeat.inputs:
- type: log
  paths:
    - /var/log/renat/renat.log
    - /var/log/renat.log
  fields:
    service: renat
output.logstash:
  hosts: ["<renat-stats-logstash-ip>:5044"]
...
where `<renat-stats-logstash-ip>` is the logstash IP of the stack. In case the renat container is running within the same docker network, it could be just `logstash`.

4. restart the filebeat service

```
$ systemctl restart filebeat
```
and confirm the status of the service

```
$ systemctl status filebeat
```


### Using the renat-stats
1. Start the stack

```
$ ./start.sh
```

2. Stop and remove the stack

```
$ ./stop.sh
```
The ELK data will remains in `./elasticsearch/data`
