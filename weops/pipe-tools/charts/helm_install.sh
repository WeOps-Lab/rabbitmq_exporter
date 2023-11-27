#!/bin/bash

# 部署监控对象
object=rabbitmq
object_versions=("3.7" "3.8")

# 设置起始端口号
port=15672

for version in "${object_versions[@]}"; do
  version_suffix="v$(echo "$version" | grep -Eo '[0-9]{1,2}\.[0-9]{1,2}' | tr '.' '-')"
  helm install $object-"$version_suffix" --namespace $object -f ./values/bitnami_values.yaml ./$object \
  --set image.tag="$version" \
  --set commonLabels.object_version="$version_suffix" \
  --set service.nodePorts.manager=$port

  ((port++))

  sleep 1
done

