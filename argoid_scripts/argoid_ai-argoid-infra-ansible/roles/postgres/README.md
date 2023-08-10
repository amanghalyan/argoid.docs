To Setup Postgres:


```ansible-playbook  -i inventory/template.ini  sites/postgres-site.yml  --tags=setup_docker,setup_postgres,setup_pgadmin  --limit=<postgres_ip>```


To Start Postgres:


```ansible-playbook  -i inventory/template.ini  sites/postgres-site.yml  --tags=check,start  --limit=<postgres_ip>```
