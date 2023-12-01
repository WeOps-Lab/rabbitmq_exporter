apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{OBJECT}}-exporter-{{VERSION}}
  namespace: {{OBJECT}}
spec:
  serviceName: {{OBJECT}}-exporter-{{VERSION}}
  replicas: 1
  selector:
    matchLabels:
      app: {{OBJECT}}-exporter-{{VERSION}}
  template:
    metadata:
      annotations:
        telegraf.influxdata.com/interval: 1s
        telegraf.influxdata.com/inputs: |+
          [[inputs.cpu]]
            percpu = false
            totalcpu = true
            collect_cpu_time = true
            report_active = true

          [[inputs.disk]]
            ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]

          [[inputs.diskio]]

          [[inputs.kernel]]

          [[inputs.mem]]

          [[inputs.processes]]

          [[inputs.system]]
            fielddrop = ["uptime_format"]

          [[inputs.net]]
            ignore_protocol_stats = true

          [[inputs.procstat]]
          ## pattern as argument for exporter (ie, exporter -f <pattern>)
            pattern = "exporter"
        telegraf.influxdata.com/class: opentsdb
        telegraf.influxdata.com/env-fieldref-NAMESPACE: metadata.namespace
        telegraf.influxdata.com/limits-cpu: '300m'
        telegraf.influxdata.com/limits-memory: '300Mi'
      labels:
        app: {{OBJECT}}-exporter-{{VERSION}}
        exporter_object: {{OBJECT}}
        object_mode: standalone
        object_version: {{VERSION}}
        pod_type: exporter
    spec:
      nodeSelector:
        node-role: worker
      shareProcessNamespace: true
      containers:
      - name: {{OBJECT}}-exporter
        image: registry-svc:25000/library/{{OBJECT}}-exporter:latest
        imagePullPolicy: Always
        securityContext:
          allowPrivilegeEscalation: false
          runAsUser: 0
        env:
          - name: RABBIT_USER
            value: weops
          - name: RABBIT_PASSWORD
            value: {{PASS}}
          - name: RABBIT_URL
            value: http://rabbitmq-{{VERSION}}.rabbitmq:15672
          - name: RABBIT_EXPORTERS
            value: "connections,shovel,federation,exchange,node,queue,memory"
          - name: RABBIT_TIMEOUT
            value: "5"
          - name: SKIPVERIFY
            value: "false"
          - name: RABBIT_CONNECTION
            value: loadbalancer
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
          limits:
            cpu: 500m
            memory: 500Mi
        ports:
        - containerPort: 9114

---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: {{OBJECT}}-exporter-{{VERSION}}
  name: {{OBJECT}}-exporter-{{VERSION}}
  namespace: {{OBJECT}}
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "9419"
    prometheus.io/path: '/metrics'
spec:
  ports:
  - port: 9419
    protocol: TCP
    targetPort: 9419
  selector:
    app: {{OBJECT}}-exporter-{{VERSION}}
