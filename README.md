sudo chmod +x /usr/local/bin/test-monitor.sh
sudo systemctl daemon-reload
sudo systemctl enable test-monitoring.service
sudo systemctl start test-monitoring.service
sudo systemctl enable test-monitoring.timer
sudo systemctl start test-monitoring.timer
sudo touch /var/log/monitoring.log
sudo chown root:root /var/log/monitoring.log
sudo systemctl restart test-monitoring.service
#или использовать crontab
sudo crontab -e
* * * * * /usr/local/bin/test-monitor.sh
