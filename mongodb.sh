

yum install mongodb-org -y



systemctl enable mongod
systemctl start mongod



sed - i /127.0.0.1 to 0.0.0.0


systemctl restart mongod