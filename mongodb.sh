
echo -e "\e[33mCopy mongodb Repo\e[0m"
cp /home/centos/Roboshop-shell/Mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>/tmp/roboshop.log

echo -e "\e[33mInstalling Nginx Server\e[0m"
yum install  mongodb-org -y  &>>/tmp/roboshop.log

echo -e "\e[33mUpdate MongoDB Listen Address\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf


echo -e "\e[33mStarting MongoDB Server\e[0m"
systemctl enable mongod  &>>/tmp/roboshop.log
systemctl restart mongod  &>>/tmp/roboshop.log


