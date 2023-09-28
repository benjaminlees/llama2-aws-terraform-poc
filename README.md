# llama2 demo

This repo contains a basic demo for deploying a [Llama 2](https://ai.meta.com/llama/) model using [AWS](https://aws.amazon.com/what-is-aws/) and [Terraform](https://developer.hashicorp.com/terraform/intro).
 

### Getting started with terraform

This first step creates a [SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/whatis.html) domain and user profile. It also creates a lambda that has the permissions to invoke a SageMaker endpoint made publicly accessible via [API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html).


Before running terraform apply make sure that the choosen region has access to [Llama 2](https://ai.meta.com/llama/) models in [SageMaker Jumpstart](https://aws.amazon.com/blogs/machine-learning/llama-2-foundation-models-from-meta-are-now-available-in-amazon-sagemaker-jumpstart/)

* `terraform init`
* `terraform apply`

### Deploying a model and setting up an end point

Now that you have the correct infrastructure set up you need to deploy a model in Sagemaker and create a new endpoint for the lambda to call.

* Go to 
[How to Use Llama 2 with an API on AWS to Power Your AI Apps](https://ai.plainenglish.io/how-to-use-llama-2-with-an-api-on-aws-to-power-your-ai-apps-3e5f93314b54) and follow Part I steps 3 and 4.
* Once you have set up the model and the endpoint update the `model_endpoint` variable with your value.
* `terraform apply`

### References

[How to Use Llama 2 with an API on AWS to Power Your AI Apps](https://ai.plainenglish.io/how-to-use-llama-2-with-an-api-on-aws-to-power-your-ai-apps-3e5f93314b54)