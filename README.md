# Personal MC server for SupremeGamer peeps

This is a self contained easy to use minecraft server and does not require root or any modification in your system. Simply follow the instructions below to get started!

# Instructions for starting the server

## Clone this repository:

```shellscript
git clone https://github.com/supremegamers/minecraft && cd minecraft
```

## Start the server

### With Ngrok tunnel

> Easy to get started but could result in slow networking among Asians

- Get ngrok auth token from https://dashboard.ngrok.com/get-started/your-authtoken
    - Login with Github there
    - Copy the token once you are logged in

- Run the server in the following manner
```bash
bash start.sh your_token
```

- Then it will give you server address for sharing and your friends can join with it from Minecraft.

### With Argo(Cloudflare) tunnel

> Slightly compilcated for the first time but offers more stable networking in most cases.

You don't need any token for it. Simply run it as below:

```bash
TUNNEL=cloudflare bash start.sh
```

But your friends will need to install a program for connecting to it.

#### Linux friends
-----------------

Your linux friends needs to run the following once:

```bash
sudo wget -O /usr/bin/cloudflared "https://github.com/cloudflare/cloudflared/releases/download/2021.8.2/cloudflared-linux-amd64" && sudo chmod 755 /usr/bin/cloudflared
```

Later for connecting anytime:

```bash
cloudflared access tcp --hostname https://the-server-address-you-shared.com --url 127.0.0.1:25565
```


#### Windows friends
-------------------

Your windows friends needs to install cloudflared for the first time, [from here](https://github.com/cloudflare/cloudflared/releases/download/2021.8.2/cloudflared-windows-386.msi).

Later for connecting anytime your friend needs to either open CMD/PowerShell and run the following:

```powershell
cloudflared access tcp --hostname https://the-server-address-you-shared.com --url 127.0.0.1:25565
```

#### Connecting from minecraft (Only if you used Argo/Cloudflared)
------------------------------

After your friends have run cloudflared command they can join from Minecraft with the following server address:

```
127.0.0.1:25565
```

## The last but not the least step:

<details>
  <summary>Spoiler</summary>
  
  ~~Enjoy~~ if you can.
  
</details>


> Protip: You can allocate more RAM for better performance, here is an example:
> `ALLOC_MEM=8G bash start.sh`
