# 🦁 [Brave Browser][repo]
This container allows you to access the [brave web browser][brave] trough another web browser using [kasmvnc][kasm].


> [!NOTE]
> This project is based on the [linuxserver/chromium][chromium] project as a reference! This project is not affiliated nor endorsed by Brave Software, Inc. or linuxserver.io and/or their partners.


## Setup

To set up the container, you can either use docker-compose or the docker cli. You can use options and additional settings/mods from linuxserver.io.

### docker-compose (recommended, [click here for more info][dcompose])

```yaml
---
services:
  brave:
    image: tibor309/brave:latest
    container_name: brave-browser
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - BRAVE_CLI=https://www.github.com/ #optional
    volumes:
      - /path/to/config:/config
    ports:
      - 3000:3000
      - 3001:3001
    shm_size: "1gb"
    restart: unless-stopped
    hostname: brave #optional
```

### docker cli ([click here for more info][dcli])

```bash
docker run -d \
  --name=brave-browser \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e BRAVE_CLI=https://www.github.com/ `#optional` \
  -p 3000:3000 \
  -p 3001:3001 \
  -v /path/to/config:/config \
  --shm-size="1gb" \
  --restart unless-stopped \
  --hostname brave `#optional` \
  tibor309/brave:latest
```

## Config

Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container. You can find additional parameters and settings from the [linuxserver/chromium][chromium-setup] project page!

| Parameter | Function |
| :----: | --- |
| `-p 3000` | Brave desktop gui. |
| `-p 3001` | HTTPS Brave desktop gui. |
| `-e PUID=1000` | for UserID |
| `-e PGID=1000` | for GroupID |
| `-e TZ=Etc/UTC` | specify a timezone to use, see this [list][tz]. |
| `-e BRAVE_CLI=https://www.github.com/` | Specify one or multiple [Brave CLI flags][flags], this string will be passed to the application in full. |
| `-v /config` | Users home directory in the container, stores local files and settings |
| `--shm-size=` | This is needed for any modern website to function like youtube. |
| `--security-opt seccomp=unconfined` | For Docker Engine only, many modern gui apps need this to function on older hosts as syscalls are unknown to Docker. |
| `--hostname brave` | Hostname for the container. It is advised to change this to your own if you're planning to use brave sync. |

## Usage
To access the container, navigate to the ip address with the port you provided at the setup.

* [http://yourhost:3000/][link]
* [https://yourhost:3001/][link]


[brave]: https://brave.com/
[kasm]: https://kasmweb.com/kasmvnc
[chromium]: https://github.com/linuxserver/docker-chromium/
[chromium-setup]: https://github.com/linuxserver/docker-chromium/blob/master/README.md#application-setup

[dcompose]: https://docs.linuxserver.io/general/docker-compose
[dcli]: https://docs.docker.com/engine/reference/commandline/cli/
[flags]: https://support.brave.com/hc/en-us/articles/360044860011-How-Do-I-Use-Command-Line-Flags-in-Brave
[tz]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List

[repo]: https://github.com/tibor309/docker-brave
[link]: https://www.youtube.com/watch?v=dQw4w9WgXcQ

