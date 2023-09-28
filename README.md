# Llama2 Demo Setup

This repository provides a guide for deploying a [Llama 2](https://ai.meta.com/llama/) model using [AWS](https://aws.amazon.com/what-is-aws/) and [Terraform](https://developer.hashicorp.com/terraform/intro). The process involves creating a SageMaker domain, user profile, and a Lambda function with permissions to invoke a SageMaker endpoint exposed via [API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html).

Before applying Terraform, ensure the selected region has access to [Llama 2](https://ai.meta.com/llama/) models in [SageMaker Jumpstart](https://aws.amazon.com/blogs/machine-learning/llama-2-foundation-models-from-meta-are-now-available-in-amazon-sagemaker-jumpstart/).

1. Run `terraform init`
2. Run `terraform apply`

## Deploying a Model and Endpoint

Follow Part I, steps 3 and 4 in [How to Use Llama 2 with an API on AWS to Power Your AI Apps](https://ai.plainenglish.io/how-to-use-llama-2-with-an-api-on-aws-to-power-your-ai-apps-3e5f93314b54) to deploy a model and create an endpoint in SageMaker.

Update the `model_endpoint` variable and run `terraform apply`. Now, you can post prompts to your Llama 2 model using `your-api-gateway-url/call-llm`.

Example JSON payload:

```json
{
  "inputs": "What is life?",
  "parameters": {"max_new_tokens": 256, "top_p": 0.9, "temperature": 0.6}
}
```

### References

[How to Use Llama 2 with an API on AWS to Power Your AI Apps](https://ai.plainenglish.io/how-to-use-llama-2-with-an-api-on-aws-to-power-your-ai-apps-3e5f93314b54)