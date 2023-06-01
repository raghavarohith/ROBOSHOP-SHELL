echo  -e "\e[33m Installing Nginx Server\e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[33m Removing the old content Nginx Server \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[33m Downloading Frontend Content Nginx Server \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e  "\e[33m Extracting Frontend content Nginx Server \e[0m"
cd /usr/share/nginx/html &>>/tmp/roboshop.log
unzip /tmp/frontend.zip  &>>/tmp/roboshop.log

echo -e "\e[33m Update Frontend Configuration \e[0m"
cp  /home/centos/Roboshop-shell/Roboshop.conf /etc/nginx/default.d/Roboshop.conf

echo -e "\e[33m Starting Nginx Server \e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log


