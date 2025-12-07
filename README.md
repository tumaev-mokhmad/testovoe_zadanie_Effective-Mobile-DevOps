sudo chmod +x /usr/local/bin/test-monitor.sh
sudo systemctl daemon-reload
sudo systemctl enable test-monitoring.service
sudo systemctl start test-monitoring.service

sudo touch /var/log/monitoring.log
sudo chown root:root /var/log/monitoring.log

sudo systemctl restart test-monitoring.service

sudo crontab -e

* * * * * /usr/local/bin/test-monitor.sh
