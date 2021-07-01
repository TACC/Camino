# Camino

Dependencies:
- [Docker](https://docs.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Docker Hub](https://hub.docker.com/orgs/taccwma/repositories)
- [GNU Make](https://www.gnu.org/software/make/)

### Camino directs and tracks container-based deployments across various environments

A compose file exists for each environment to orchestrate deployments. Each application/service in a compose file can be locked to a specific tag. An image digest can be used to guarantee the correct/expected image is always referenced.

Setup:
Clone the Camino repo to the path `/opt/portal`

At the root of the cloned project create the env file `.env` and add the name of the environment file to be used to manage deployments. The env files are named according the deployment environment they manage, like `dev.env, pprd.env, prod.env` and live in the directory `conf/camino`. With the env file set, make will load the environment variables and pass them to the compose file.

Ex. To manage and deploy dev, use the filename `dev.env`, this file will be passed to docker-compose with `--env-file=./conf/camino/dev.env`

This file can be used to [populate values in the compose file](https://docs.docker.com/compose/environment-variables/)

To deploy changes to a service, the image name and tag (or digest) for the service should be set in the appropriate compose file (or, if using a var, the matching env file in `conf/camino`). This means that the image must be pre-built and its tag or digest known before deployment.

For example, to deploy a new pre-built cms image to production, the image in docker-compose.yml would be updated like below:

```
services:
  cms:
    image: taccwma/frontera-cms:{tag}
    volumes:
```
to
```
services:
  cms:
    image: taccwma/frontera-cms:{tag}
    volumes:
```

To update a dev environment, a similar change would happen in the docker-compose-dev.yml file.

Additionally, to facilitate continuous integration without constant updates to the Camino repo, a service in a compose file can be tagged with `:latest`. New images built and published with the tag `:latest` can then be deployed without requiring updates to Camino.

```
services:
  cms:
    image: taccwma/frontera-cms:latest
    volumes:
```


Deploying with Jenkins:

1. Build and publish the image [Build/Publish Core Portal](https://jenkins01.tacc.utexas.edu/view/Frontera%20Web/job/Frontera_Portal/) [Build/Publish CMS](https://jenkins01.tacc.utexas.edu/view/Frontera%20Web/job/Frontera_CMS/)
2. If required, update the service's image reference in the appropriate compose file as described above
3. Go to [Frontera_Deployments](https://jenkins01.tacc.utexas.edu/view/Frontera%20Web/job/Frontera_Deploy/) in Jenkins and start a build, selecting environment and component/service

A Makefile is included to faciliate manual deployment.

Steps for manually deploying service:

1. Update the Camino compose file with image reference as needed
2. Switch to user portal with `sudo su - portal` 
3. Navigate to the Camino repo `cd /opt/portal/camino/`
4. Run the appropriate `make` command 
    *cms: `make deploy-cms`
    *core portal: `make deploy-core`
    *user guide: `make deploy-docs`
    *all services: : `make deploy-all`




_por necesidad o aventura, todo descubrimiento nace con el inicio de un viaje sin fin, el camino hacia la frontera_
