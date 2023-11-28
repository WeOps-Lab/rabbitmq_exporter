#!/bin/bash

object=rabbitmq

for version in v3-7 v3-8; do
    output_file="dp_${version}.yaml"
    if [ "$version" == "v3-7" ]; then
        pass="guest"
    else
        pass="Weops@123"
    fi
    sed "s/{{VERSION}}/${version}/g;s/{{OBJECT}}/${object}/g;s/{{PASS}}/${pass}/g;" dp.tpl > ../dp/${output_file}
done

