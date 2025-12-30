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

