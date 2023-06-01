echo -e "\e[33mConfiguring NodeJs Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m Install NodeJs \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m Add application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m create Application Directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app


echo -e "\e[33m Download Application content\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m Extract Application content\e[0m"
unzip /tmp/user.zip &>>/tmp/roboshop.log
cd /app



echo -e "\e[33m Install Depedencies \e[0m"
npm install &>>/tmp/roboshop.log


echo -e "\e[33m Setup SystemD User Service  \e[0m"
cp /home/centos/Roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

systemctl daemon-reload &>>/tmp/roboshop.log

systemctl enable user &>>/tmp/roboshop.log
systemctl start user &>>/tmp/roboshop.log

echo  -e "\e[33m copy MONGODB Repo  \e[0m"
cp  /home/centos/Roboshop-shell/Mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33m install mongodb client   \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log


echo  -e "\e[33m Load Schema Mongodb  \e[0m"
mongo --host mongodb-devop.devopsb73.site </app/schema/user.js &>>/tmp/roboshop.log

