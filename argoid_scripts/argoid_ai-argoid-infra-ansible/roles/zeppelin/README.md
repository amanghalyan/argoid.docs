To Setup Zeppelin:


```ansible-playbook  -i inventory/saas-test1/template-common.ini sites/zeppelin-site.yml  --tags=setup_spark_client,setup_hadoop_client,setup_zeppelin --limit=<zeppelin_ip> ```


To Start Zeppelin:


``` ansible-playbook  -i inventory/saas-test1/template-common.ini sites/zeppelin-site.yml  --tags=start_zeppelin,check_zeppelin  --limit=<zeppelin_ip> ```
