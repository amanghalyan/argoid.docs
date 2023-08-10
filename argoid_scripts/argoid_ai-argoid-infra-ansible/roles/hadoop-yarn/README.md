To Setup Yarn:


```ansible-playbook  -i inventory/inventoy-file.ini  sites/yarn-site.yml --limit=192.2.1.xx,192.2.1.yy --tags=setup_yarn```

To Add Nodemanager:


```ansible-playbook  -i inventory/inventoy-file.ini  sites/yarn-site.yml --limit=192.2.1.zz --tags=setup_nodemanager```

To add Hadoop and Spark clients:


```ansible-playbook  -i inventory/inventoy-file.ini sites/hadoop-client.yml --limit=192.2.1.zz --tags=setup_spark_client,setup_hadoop_client ```


To create History servers:


```ansible-playbook  -i inventory/inventoy-file.ini sites/yarn-site.yml --limit=192.2.1.zz --tags=setup_historyserver```

OR 

```ansible-playbook  -i inventory/inventoy-file.ini sites/hadoop-client.yml --limit=192.2.1.zz --tags=setup_historyserver```
