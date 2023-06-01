echo  -e "\e[33m configuring nodejs \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>>/tmp/roboshop.log

echo  -e "\e[33m install nodejs \e[0m"
yum install nodejs -y   &>>/tmp/roboshop.log

echo  -e "\e[33m Add application user \e[0m"
useradd roboshop   &>>/tmp/roboshop.log


echo -e "\e[33m Create an application directory\e[0m"
rm -rf /app   &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[33m Download Application content \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip   &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m Extract Application content \e[0m"
unzip /tmp/catalogue.zip   &>>/tmp/roboshop.log
cd /app


echo -e "\e[33m Install Nodejs Depedencies \e[0m"
npm install   &>>/tmp/roboshop.log


echo -e "\e[33m Setup SystemD Service \e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service  &>>/tmp/roboshop.log

echo -e "\e[33m Start Catalogue Service \e[0m"
systemctl daemon-reload  &>>/tmp/roboshop.log
systemctl enable catalogue  &>>/tmp/roboshop.log
systemctl start catalogue  &>>/tmp/roboshop.log

echo -e "\e[33m Copy Mongodb repo file \e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo  &>>/tmp/roboshop.log


echo -e "\e[33m Install Mongodb repo file \e[0m"
yum install mongodb-org-shell -y   &>>/tmp/roboshop.log

echo -e "\e[33m Load Schema \e[0m"
mongo --host mongodb-dev.devopsb73.site</app/schema/catalogue.js   &>>/tmp/roboshop.log