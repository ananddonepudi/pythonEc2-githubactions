sudo yum update -y          # Amazon Linux
sudo yum install git python3 -y


sudo mkdir -p /var/www/python-app
sudo chown ec2-user:ec2-user /var/www/python-app

#update the service file
/etc/systemd/system/python-app.service
[Unit]
Description=Python Flask App
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/var/www/python-app
ExecStart=/var/www/python-app/venv/bin/python app.py
Restart=always

[Install]
WantedBy=multi-user.target

#start 
sudo systemctl daemon-reload
sudo systemctl enable python-app
sudo systemctl start python-app

-----------------------------------
| Secret            | Value                   |
| ----------------- | ----------------------- |
| `DOCKER_USERNAME` | Docker Hub username     |
| `DOCKER_PASSWORD` | Docker Hub access token |
| Secret                | Value                   |
| --------------------- | ----------------------- |
| `AZURE_CLIENT_ID`     | Service principal appId |
| `AZURE_TENANT_ID`     | Tenant ID               |
| `AZURE_CLIENT_SECRET` | SP secret               |
| `ACR_NAME`            | e.g. `myadregistry`    |
| Secret                  | Value              |
| ----------------------- | ------------------ |
| `AWS_ACCESS_KEY_ID`     | IAM access key     |
| `AWS_SECRET_ACCESS_KEY` | IAM secret         |
| `AWS_REGION`            | e.g. `ap-south-1`  |
| `ECR_REPOSITORY`        | e.g. `python-demo` |

create acr
az login
az ad sp create-for-rbac  --name github-actions-acr   --role acrpush  --scopes /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RG_NAME>/providers/Microsoft.ContainerRegistry/registries/<ACR_NAME>

