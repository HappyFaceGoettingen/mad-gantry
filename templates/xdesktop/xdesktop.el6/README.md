dockerfile-centos6-desktop
==========================
###Usage 
````bash
docker run -d -p 5901:5901 akyshr/centos6-desktop
````

###Account
````
 USER : admin
 PASSWD : admin
````
###Root Password
````
 PASSWD : admin
````

###Change Language 

 docker run -d -p 5901:5901 -e "LANG=ja_JP.UTF-8" -e "TZ=JST-9" akyshr/centos6-desktop
