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

At the root of the cloned project create the env file `.env` and add the environment variables
that indicate which docker-compose files should be used. With the env file set, Make will 
load the environment variables and pass them to the compose file.

The .env file can be used to [populate values in the compose file](https://docs.docker.com/compose/environment-variables/)
and in conjunction with the Makefile helps create custom service sets.

### Quick-Start Example

1. Clone this repo
2. Create a `.env` file and populate with:
```
BASE_COMPOSE_FILE=docker-compose.nginx.yml
COMPOSE_FILE=
CAMINO_HOME=${PWD}
```
3. Run `make up`
4. Navigate to `localhost`

Services can be customized without modifying base
compose files by creating overrides files in `conf/camino/`

##### To override the version of nginx image used in the previous example

1. Create file `docker-compose.nginx.overrides.yml` In `conf/camino` and paste in:
```
version: "3.8"
services:
  nginx:
    image: nginx:stable
```
2. In the .env file add entry, `COMPOSE_FILE=docker-compose.nginx.overrides.yml`
3. run make up
4. Note that the nginx image with tag `stable` is being pulled down
5. Navigating to `localhost` now displays the default page for the new image

To facilitate continuous integration without updating the Camino repo, 
a service in a compose file can be tagged with `:latest`. New images built and published with the tag `:latest` can then be deployed without requiring updates to Camino.


Deploying with Jenkins:

1. Build and publish the image [Build/Publish Core Portal](https://jenkins01.tacc.utexas.edu/view/Frontera%20Web/job/Frontera_Portal/) [Build/Publish CMS](https://jenkins01.tacc.utexas.edu/view/Frontera%20Web/job/Frontera_CMS/)
2. If required, update the service's image reference in the appropriate compose file as described above
3. Go to [Frontera_Deployments](https://jenkins01.tacc.utexas.edu/view/Frontera%20Web/job/Frontera_Deploy/) in Jenkins and start a build, selecting environment and component/service

A Makefile is included to facilitate manual deployment.

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
