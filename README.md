A localhost Traefik Playground
===

This is a local playground to help you get started with Traefik. If you speak German listen to our Episode where we talk about this setup and discuss Traefik.

You can use this setup to experiment with Traefik and also easily host services on your machine without remembering lots of ports. Domain names are much more intuitive. Also your browser will help you auto-complete domains better than port numbers. 

# Clone

```
git clone
cd traefik-playground
```

# Edit your /etc/hosts file

`sudo nano /etc/hosts`

Append these lines at the end:

```
127.0.0.1 traefik.docker.localhost
127.0.0.1 web.docker.localhost
127.0.0.1 readme.docker.localhost
```

This is a poor man's DNS solution but it works very reliable. If you want to add domains later do not forget to add them to your `/etc/hosts` file.

# Running the Playground

```
docker-compose up
```

Open this README.md in your browser by visiting [readme.docker.localhost/](http://readme.docker.localhost/) or visit the [Traefik Dasboard](http://traefik.docker.localhost/dashboard/) (user: `test`, password: `test`). There is also [web.docker.localhost](http://web.docker.localhost/).

### How does it work?

Traefik connects to the Docker Daemon to read labels from running containers. All containers that are connected to the network `traefik-playground_default` are also reachable from the Traefik container. Traefik is able to reverse proxy requests based on the lables assigned to docker containers. 

If your working directory from where you executed `docker-compose up` is not `traefik-playground` the network name is different. 

# Adding a container / domain

You can either edit the `docker-compose.yml` file inside this repository or connect a container to the proxy network. Either way you have to tell Traefik via lables how to serve the web port of this container.

Add `127.0.0.1 project.docker.localhost` to `/etc/hosts` (replace `project` with something that better describes your project).

Run the project container:

```
docker run \
    --name some-project \
    -d \
    --network traefik-playground_default \
    -l "traefik.http.routers.project.rule=Host(\`project.docker.localhost\`)" \
    someimage
```

Open [project.docker.localhost](http://project.docker.localhost)


# Local Links

- [traefik.docker.localhost/dashboard/](http://traefik.docker.localhost/dashboard/)
- [web.docker.localhost](http://web.docker.localhost/)
- [readme.docker.localhost](http://readme.docker.localhost/)

# HTTPS, specific ports and more

Read this [blog post](https://blog.containo.us/traefik-2-0-docker-101-fc2893944b9d) from the makers of Traefik.


# Rebuild README.md to HTML

```
make html-files
```