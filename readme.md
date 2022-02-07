[VIDEO OVERVIEW OF USING DOCKER IMAGE FROM DOCKER HUB](https://youtu.be/mN5UHsMNm4U)

## Developer Environment with Docker

The `Dockerfile` and `docker-compose.yml` are meant to help create an easy to replicate and portable developer environment with the following languages.

- Keep in mind the initial building of the dockerfile will take awhile

*Through the Dockerfile based image*
- Javascript through node & deno
- Java 17
- Scala 2 & 3 using Coursier (sbt is installed)
- Python 3 (via python3 command)
- Ruby
- PHP

*Docker Compose file will also include*
- postgres database being serves on port 5432
- mongodb database beign served on 

## Building just the image

Make sure to edit the command below with your gitusername and email

**Build Command**

```
docker build -t my_dev_environ --build-arg gitusername="Your Name" --build-arg gitemail="Your@email.com" .

docker run -it my_dev_environ
```

## Setting up the environment using Docker-Compose

First make sure to enter your username and the email on your github account in the env variables.

```yml
      args:
        gitusername: "Your Name"
        gitemail: "your@email.com"
```

Then to turn on the environment (include mongo and postgres databases)

```
docker-compose up
```

To turn off the environment

```
docker-compose down
```

## Opening Up in VSCode

- download the remote-containers vscode extension
- once the container is running
- open the command-pallette and select "Remote-Containers: Attach to Running Container"
- You should be able to attach vscode to the running container and work from it

another option is to copy the dockerfile and docker-compose.yml to a new directory you want to work out of and select "Remote-Containers: Open folder in a container" it should detect the files and give you the option of opening using either. Select the dockerfile or select docker-compose.yml and select the languages service.

## Running Individual Services

If you want to turn on the services individually incase you don't need all three:

- `docker-compose up languages`
- `docker-compose up postgres`
- `docker-compose up mongodb` 

to turn off

- `docker-compose down languages`
- `docker-compose down postgres`
- `docker-compose down mongodb` 

## Running Single Commands

If you just wanted to run a single command against a container, follow this example where we run bash in the languages container.

```
docker-container run languages /bin/bash/
```