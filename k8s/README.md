## Kubernetes manifests files

We have different directories here. `app`  directory contains the manifest files of the application and `prometheus` contains the manifest files of the the monitoring. `k8sconfig` contains the manifest files of the the namespace configuration and cluster roles required for prometheus.  `grafana` directory contains the manifest files of the application

## Deployment

In general, to deploy either of directories we can directlz use `kubectl apply -f .` by navigating into the directory itself. However, since application and monitoring are running in different namespace, we have to apply the namespace manifest first and cluster role by `kubectl apply -f ./k8sconfig/` .

## Makefile

In order to avoid running `kubectl` during the process since application and monitoring are running on different namespace, you can use the Makefile. This Makefile gives you an ability to run apply, describe, logs and get.

In order to use the Makefile you need to export the directory name accordinglz. For instance, if you want to run `Make get` for app directory, you need to `export DEP=app` in your terminal first

### Examples:

In order to see the pods:

```
export DEP=app
Make get
```
Result:
```
Using Environment: dev
Using Deployment:  app
Using Namespace:   app
Using files:       app/deployment.yml app/services.yml
kubectl  --namespace app get pod
NAME                                   READY   STATUS    RESTARTS   AGE
prom-http-simulator-686bcc4f8f-58mn8   1/1     Running   0          74m
prom-http-simulator-686bcc4f8f-68g5g   1/1     Running   0          74m
```

For seeing logs:

```
export DEP=prometheus
Make logs
```

Result:

```
Using Environment: dev
Using Deployment:  prometheus
Using Namespace:   monitoring
Using files:       prometheus/role-binding.yml prometheus/deployment.yml prometheus/configMap.yml prometheus/service-account.yml prometheus/services.yml
kubectl --namespace monitoring logs -lapp=prometheus
level=info ts=2020-10-18T17:50:25.635Z caller=head.go:719 component=tsdb msg="WAL replay completed" checkpoint_replay_duration=37µs wal_replay_duration=394.04µs total_replay_duration=577.09µs
level=info ts=2020-10-18T17:50:25.637Z caller=main.go:732 fs_type=EXT4_SUPER_MAGIC
level=info ts=2020-10-18T17:50:25.637Z caller=main.go:735 msg="TSDB started"
level=info ts=2020-10-18T17:50:25.637Z caller=main.go:861 msg="Loading configuration file" filename=/etc/prometheus/prometheus.yml
level=info ts=2020-10-18T17:50:25.637Z caller=main.go:892 msg="Completed loading of configuration file" filename=/etc/prometheus/prometheus.yml totalDuration=702.739µs remote_storage=1.84µs web_handler=440ns query_engine=1.1µs scrape=243.31µs scrape_sd=29.3µs notify=25.52µs notify_sd=32.62µs rules=1.3µs
level=info ts=2020-10-18T17:50:25.638Z caller=main.go:684 msg="Server is ready to receive web requests."
level=info ts=2020-10-18T17:52:19.331Z caller=main.go:861 msg="Loading configuration file" filename=/etc/prometheus/prometheus.yml
level=info ts=2020-10-18T17:52:19.332Z caller=kubernetes.go:263 component="discovery manager scrape" discovery=kubernetes msg="Using pod service account via in-cluster config"
level=info ts=2020-10-18T17:52:19.335Z caller=kubernetes.go:263 component="discovery manager notify" discovery=kubernetes msg="Using pod service account via in-cluster config"
level=info ts=2020-10-18T17:52:19.337Z caller=main.go:892 msg="Completed loading of configuration file" filename=/etc/prometheus/prometheus.yml totalDuration=5.992562ms remote_storage=2.27µs web_handler=440ns query_engine=1.55µs scrape=284.66µs scrape_sd=2.356037ms notify=249.71µs notify_sd=1.359158ms rules=765.308µs
```

For describing Deployment:

```
export DEP=alertmanager
Make describe
```
Result:

```
Using Environment: dev
Using Deployment:  alertmanager
Using Namespace:   monitoring
Using files:       alertmanager/deployment.yml alertmanager/configMap.yml alertmanager/services.yml
kubectl --namespace monitoring describe deployment alertmanager
Name:                   alertmanager
Namespace:              monitoring
CreationTimestamp:      Sun, 18 Oct 2020 19:01:35 +0200
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 2
                        kubectl.kubernetes.io/last-applied-configuration:
                          {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"alertmanager","namespace":"monitoring"},"spec":{"replicas...
Selector:               app=alertmanager
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 0 max surge
Pod Template:
  Labels:       app=alertmanager
  Annotations:  prometheus.io/port: 9093
                prometheus.io/scrape: true
  Containers:
   alertmanager:
    Image:      prom/alertmanager
    Port:       9093/TCP
    Host Port:  0/TCP
    Args:
      --config.file=/etc/alertmanager/config.yml
      --storage.path=/alertmanager
    Limits:
      memory:     256Mi
    Liveness:     http-get http://:alertmanager/-/healthy delay=0s timeout=1s period=10s #success=1 #failure=3
    Environment:  <none>
    Mounts:
      /etc/alertmanager from config (rw)
  Volumes:
   config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      alertmanager-config
    Optional:  false
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   alertmanager-6cc66ccd9b (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  30m   deployment-controller  Scaled down replica set alertmanager-675589c796 to 0
  Normal  ScalingReplicaSet  30m   deployment-controller  Scaled up replica set alertmanager-6cc66ccd9b to 1
```

## To Do
- [ ] Securing Prometheus by adding authentication as mentioned [here](https://prometheus.io/docs/guides/basic-auth/)