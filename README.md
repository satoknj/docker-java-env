# docker-java-env 

## what is this
This is eclipse environment in docker container from windows os.
To use eclipse (and other desktop applications) connect container with ssh and X-server(like mobaXterm).

include
* fcitx
* mozc
* tomcat

## usage 
build Dockerfile, and create container with following command,
docker run -d -p 10022:22 -p 8080:8080 --name [container_name] [image_name]

Connect container ssh, port is your specified(in the above, 10022).
Login with dev/dev.
To start eclipse, run ~/eclipse/eclipse

## memo
To input japanese, run [fcitx-config-gtk3].
Then, select keyboard mozc, hankaku_zenkaku setting and your favarite setting.
