![Kamaleo](https://raw.githubusercontent.com/xkraty/kamaleo/main/kamaleo.png)

# **🦎 Kamaleo: The Adaptive Reverse Tunnel for Kamal Deployments**

**Project Name:** Kamaleo (from Chameleon, implying network adaptability)

## **🌟 Overview**

Kamaleo is a system that utilizes a resilient reverse SSH tunnel to enable public access to a local development application running behind a firewall or NAT, integrated seamlessly with a Kamal-managed server and an Nginx proxy.

It solves the critical development problem of exposing a locally running service (e.g., Rails on localhost:3000) to a public domain (kamaleo.domain.com) for testing, demos, or webhooks.

### **The Kamaleo Connection Flow**

Kamaleo connects three key network points:

| Component                   | Location                            | Role                                                                                     |
| :-------------------------- | :---------------------------------- | :--------------------------------------------------------------------------------------- |
| **Local App (e.g., Rails)** | Your Laptop (localhost:3000)        | The source of your application's content.                                                |
| **SSH Client**              | Your Laptop                         | Initiates the secure tunnel to the VPS (port 2222).                                      |
| **Kamaleo Container**       | VPS Host (Container kamhole-tunnel) | **The Bridge Endpoint.** Receives forwarded traffic on port 8080.                        |
| **Nginx Proxy**             | VPS Host (Port 80)                  | **The Gateway.** Routes public requests (Port 80) to the container's bridge (Port 8080). |

## **⚙️ Setup and Configuration**

- `cp env.template .env`
- Set `.env` configuration.
- Replace `kamaleo.domain.com` with your domain in `config/deploy.production`.
- Add your public key to `/config/ssh/authorized_keys`.

```
dotenv kamal setup -d production
dotenv kamal deploy -d production
```

## **💻 Usage**

## Makefile

You can drop-in the `Makefile` in your project and run:

```
make run KAMALEO_APP_PORT=3001
```

You can put variables in `.env` file to only run `make run`

```
KAMALEO_APP_PORT=3000
KAMALEO_USER=kamhole
KAMALEO_HOST=tunnel.krakenrb.dev
KAMALEO_SSH_PORT=2222
KAMALEO_PORT=8080
```

## SSH

Simply run the ssh connection.

```
ssh -N -T -R 8080:localhost:<yourport> kamaleo@domain.com -p 2222
```

## **📄 License**

Kamaleo is provided under the **MIT License**.

### **MIT License**

Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:  
The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.  
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  
SOFTWARE.
