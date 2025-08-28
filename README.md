[beta_build]: https://github.com/tibor309/brave/tree/beta
[nightly_build]: https://github.com/tibor309/brave/tree/nightly

[brave]: https://brave.com/
[repo]: https://github.com/tibor309/brave

[dhub]: https://hub.docker.com/r/tibordev/brave
[dcompose]: https://docs.linuxserver.io/general/docker-compose
[dcli]: https://docs.docker.com/engine/reference/commandline/cli/
[flags]: https://support.brave.com/hc/en-us/articles/360044860011-How-Do-I-Use-Command-Line-Flags-in-Brave
[tz]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
[link]: https://www.youtube.com/watch?v=dQw4w9WgXcQ

[lsmods]: https://github.com/linuxserver/docker-mods
[lsswag]: https://github.com/linuxserver/docker-swag
[lsselkies-op]: https://github.com/linuxserver/docker-baseimage-selkies#options



# 🦁 [Brave][repo]
This container allows you to use [Brave][brave] remotely trough another web browser. Brave is a fast, private and secure web browser for PC, Mac and mobile.

![brave](https://github.com/user-attachments/assets/8573341d-d7a2-403c-8ddd-4edf7e7172a3)

## Setup
To set up the container, you can use docker-compose or the docker cli. Unless a parameter is flagged as 'optional', it is *mandatory* and a value must be provided. This container is using a linuxserver.io base, so you can use their [mods][lsmods] and configurations to enable additional functionality within the container.

> [!WARNING]
> The [beta][beta_build] and [nightly][nightly_build] editions of the browser will be removed soon! If you use any of them, clone this project, and build your own image!

> [!NOTE]
> This image is also available on [Docker Hub][dhub] under `tibordev/brave`.

### [docker-compose][dcompose] (recommended)

```yaml
---
services:
  brave:
    image: ghcr.io/tibor309/brave:latest
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

### [docker-cli][dcli]

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
  ghcr.io/tibor309/brave:latest
```

## Security
By default, this container has no authentication. Configure the optional environment variables `CUSTOM_USER` and `PASSWORD` to enable basic HTTP auth. This should only be used to locally secure the container on a local network. If you're exposing this container to the internet, it's recommended to use a reverse proxy or a VPN such as [SWAG][lsswag] or Tailscale.

## Config
Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container. Further options can be found on the [Selkies Base Images][lsselkies-op] repo.

| Parameter | Function |
| :----: | --- |
| `-p 3000` | HTTP Brave desktop gui. |
| `-p 3001` | HTTPS Brave desktop gui. |
| `-e PUID=1000` | For UserID |
| `-e PGID=1000` | For GroupID |
| `-e TZ=Etc/UTC` | Specify a timezone to use, see this [list][tz]. |
| `-e BRAVE_CLI=https://www.github.com/` | Specify one or multiple [Brave CLI flags][flags], this string will be passed to the application in full. |
| `-v /config` | Users home directory in the container, stores local files and settings. |
| `--shm-size=` | This is needed for any modern website to function like YouTube. |
| `--security-opt seccomp=unconfined` | For Docker Engine only, many modern gui apps need this to function on older hosts as syscalls are unknown to Docker. |
| `--hostname brave` | Hostname for the container. It is advised to change this to your own if you're planning to use Brave Sync. |

## Updating
This image is updated monthly. To update the app, you'll need to pull the latest image and redeploy the container with your configuration. It's **not** recommended to update the app inside the container. Updating this way could cause issues with configurations and mods.

## Usage
To access the container, navigate to the IP address for your machine with the port you provided at the setup.

* [http://yourhost:3000/][link]
* [https://yourhost:3001/][link]
