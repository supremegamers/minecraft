# Personal MC server for SupremeGamer peeps

This is a self contained easy to use minecraft server and does not require root or any modification in your system. Simply follow the instructions below to get started!

## Instructions for starting the server

- Clone this repository:

```shellscript
git clone https://github.com/supremegamers/minecraft && minecraft
```

- Get ngrok auth token from https://dashboard.ngrok.com/
    - Login with Github there
    - Copy the token from this part once you are logged in:
    ![Ngrok auth token example](ngrok.png)

- Run the following command:

```shellscript
bash start.sh your_token
```

- The last and the least step: <details>
  <summary>Spoiler</summary>
  
  ~~Enjoy~~ if you can.
  
</details>


> Protip: You can allocate more RAM for better performance, here is an example:
> `bash start.sh your_token 8G`