# OCI8 PHP DEVELOPMENT SETUP

Setup for PHP and Oracle OCI8 development on Apple Silicon Chip.

This environment is complete for you to have a good development experience, in docker-compose.yml we have already configured the Nginx, Postgres, Pgadmin, Redis and Mailpit images.
If you use the Laravel framework, just add the files into the app folder


## ⚠️ Disclaimer

At the time I am creating this document, I have not yet found any official OCI8 driver from Oracle that offers native support for Apple's silicon architecture to be able to work with PHP.
As this image I created is not native, it will be slower than using it on Linux because I am using the amd64 architecture on arm64.

### 📋 Check list before starting

For you to have a good experience and get the most out of it, I suggest you delete Docker from your Mac and use OrbStack to perform better

- [ ]   [Install OrbStack](https://orbstack.dev/)
- [ ]   Create an account on [Oracle](https://profile.oracle.com/myprofile/account/create-account.jspx) to download drivers

After registering on the oracle website, you will need to download two drivers to build the image


-  [```instantclient-sdk-linux.x64-12.2.0.1.0.zip```](https://download.oracle.com/otn/linux/instantclient/122010/instantclient-sdk-linux.x64-12.2.0.1.0.zip?AuthParam=1695920666_406a2ab9b0fc751a0b292f01ef13ddf1)  ⬅️


-  [```instantclient-basic-linux.x64-12.2.0.1.0.zip```](https://download.oracle.com/otn/linux/instantclient/122010/instantclient-basic-linux.x64-12.2.0.1.0.zip?AuthParam=1695919676_59693b3229510d9a75df6510c90c1ff7) ⬅️

- Copy the files to the oracle folder



## 🚀 Starting

Open the terminal in the project folder, run the command below to build the image and run the containers

```bash
 docker compose up -d 
```