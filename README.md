# venetianBlindsControl
Controlling my venetian blinds via wifi with a nodemcu (esp8266)

Work in progress ...

Needs an image for the Espressfi nodemcu/esp8226 (currently i'm using an custom build by frightanic.com):
>  SSL: false

>	modules: node,file,gpio,wifi,net,pwm,tmr,uart,mqtt,dht,tsl2561

About the files:
```
    +- src
    | |
    | +- lua
    |    |
    |    +- *.lua (The files needed to be saved on the esp8266)
    |
    +- venetian-blinds.html (needs to be served by an webserver inside yout local wifi area)
```
