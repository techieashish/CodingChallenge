# CodingChallenge

### Written a terraform modules that deploys django application on AWS ECS

### How it works?

1. Created a CI/CD pipeline in github workflows.
2. Terraform module to proivision resources in AWS. All the modules are in terraform folder.
3. A simple Django app with a rest API endpoint.

### It does the following :-
       * Private and Public Subnets
       * SSH Key Setup
       * Creates Postgres DB in RDS
       * Adds the task defination.
       * Creates the fargate cluster.
       * Created the service
       * Deploys the same.

SSL certs were locally generated so are not part of the repo.
