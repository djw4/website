---
date: "2019-01-16"
title: "Configing Pushover with ZNC-Push on Centos 7"

---

In some certain use organisations and private groups, IRC is still the best tool to allow groups of users communicate with one another - however it does have it's limitations. In this day and age, using IRC on a mobile device can be a pain to configure and some apps lack in functionality but there can be a need to ensure messages are received whilst a client is offline.

Traditionally this has been the domain of a 'bouncer' to collect and store messages for offline users, so that the messages can be received when the user signs in again. This tried and tested message has been the defacto standard for IRC usage for many years, however unless a user logs into the server to check for any new messages - the messages will sit there indefinitely.

To compliment the bouncer we will use [ZNC-Push](https://github.com/jreese/znc-push) to ensure that messages matching filters that we specify will be forwarded onto our chosen devices. The installation process is as follows:

#### Preparation

To ensure the server has the necessary packages required to compile the module, install the necessary packages with:

```
$ yum group install "Development Tools"
$ yum install znc-devel git
```

#### Compiling the module

To compile the module, clone the repository from Github to a directory on the server - then enter the directory and use `znc-buildmod`:

```
$ git clone https://github.com/jreese/znc-push.git
$ cd znc-push
$ znc-buildmod push.cpp
```

If the compile process is sucessful you should have a `push.so` file located in the same directory.

#### Adding the module to ZNC

Create the directory `modules` in the root directory of your ZNC installation. 

```
$ mkdir /var/lib/znc/.znc/modules
```

If you've installed ZNC from the repository then this is likely `/var/lib/znc/.znc`. You will also need to ensure the ownership of the directory and file are correct, as below.

```
$ cp push.so /var/lib/znc/.znc/modules
$ chown -R znc:znc /var/lib/znc/.znc/modules
```

Lastly restart your ZNC service, for good measure.

```
systemctl restart znc
```

#### Configuring the module

_These installation steps have been extracted from the [readme](https://github.com/jreese/znc-push/blob/master/README.md) in the repository._

Before starting the module configuration process, first log into the Pushover control panel and create a new app - taking note of both the application key and your user key.


1. Connect to your bouncer and load the module: `/msg *status loadmod --type=user push`
2. Tell ZNC-Push to use the _pushover_ service: `/msg *push set service pushover`
3. Then tell ZNC-Push your user key: `/msg *push set username ugi...kyg`
4. Finally tell ZNC-Push your API Key: `/msg *push set ace...vt8`
5. Save your configuration by specifying a full path: `/msg *push save /var/lib/znc/.znc/pushover.config`

Each time you perform an activation you should get the output `Ok` from the bouncer.


ZNC-Push is now active but won't yet send you messages - it requires some final configuration. We can easily fix this with `set`.

* `/msg *push set last_active 15` -- Only send messages through Pushover if the last message from the sending user is greater than x seconds (avoiding message spam).
* `/msg *push set away_only yes` -- Only send messages through Pushover if you are away (use the simpleaway module for this).
* `/msg *push set highlight <<INSERT-YOUR-NIC-HERE>>` -- Add your nic and any topics that you'd like to be alerted on.

You will now receive messages on all devices when messages have been sent to you that require your attention. You can configure the module to only send to specific devices of your choosing, check the readme for more information.