echo -e "\e[33m Install maven \e[0m"
yum install maven -y  &>>/tmp/roboshop.log

echo  -e "\e[33m Add application user \e[0m"
useradd roboshop   &>>/tmp/roboshop.log

echo -e "\e[33m Create an application directory\e[0m"
rm -rf /app   &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[33m Download Application content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip  &>>/tmp/roboshop.log
cd /app


echo -e "\e[33m Extract Application content \e[0m"
unzip /tmp/shipping.zip  &>>/tmp/roboshop.log


echo -e "\e[33m Download Depedencies \e[0m"

mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[33m Install Mysql client \e[0m"
yum install mysql -y  &>>/tmp/roboshop.log

echo -e "\e[33m Load Mysql Schema \e[0m"
mysql -h  mysql-dev.devopsb73.site -uroot -pRoboShop@1 < /app/schema/shipping.sql  &>>/tmp/roboshop.log


echo -e "\e[33m Setup SystemD File \e[0m"
cp /home/centos/Roboshop-shell/shipping.service /etc/systemd/system/shipping.service  &>>/tmp/roboshop.log

echo -e "\e[33m Start Shipping Service \e[0m"
systemctl daemon-reload     &>>/tmp/roboshop.log
systemctl enable shipping  &>>/tmp/roboshop.log
systemctl restart shipping  &>>/tmp/roboshop.log