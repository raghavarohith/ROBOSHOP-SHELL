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
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app



echo -e "\e[33m Extract Application content\e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app



echo -e "\e[33m Install Depedencies \e[0m"
npm install &>>/tmp/roboshop.log


echo -e "\e[33m Setup SystemD cart Service  \e[0m"
cp /home/centos/Roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

systemctl daemon-reload &>>/tmp/roboshop.log

systemctl enable cart &>>/tmp/roboshop.log
systemctl start cart &>>/tmp/roboshop.log

