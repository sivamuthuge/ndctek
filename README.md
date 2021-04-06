

I. Build a GKE cluster with Terraform

1. clone github.
2. cd into terraform folder.
3. Currently one .var file is there for dev. If more environment needed, please add env.tfvars .
4. Change the project = "api-project-272859872313" to your project id under env / variables.
5. Do a terraform init 
6. Do a terraform plan --var-file env/dev.tfvars --out planfile
7. Do a terraform apply --out planfile

Will create a GKE cluster.

II.  Application for fetching products from a URL and building it using docker

1. cd into appBuild folder.
2. Run docker build . -t myapp
3. Image myapp:latest will be available for execution. 
4. Build image is pushed to vinodhsiva/myapp, which can be used in helm chart .


III. Helm chart & Deployment.

Deployment can be done by Jenkins and the Helm chart is created .
Helm chart is available at /helm/
to install helm chart
helm install appname pathtochart

helm install myapp ./helm/myapp

IV. Autoscaling

Autoscalining is enabled in the code. If the CPU level crosses 80% it will autoscale upto 100.

