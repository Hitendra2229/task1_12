#!/bin/bash

# Function to apply Kubernetes resources
apply_resources() {
    local resource_type=$1
    local resource_file=$2

    if kubectl apply -f "$resource_file" &> /dev/null; then
        echo "Successfully applied $resource_type: $resource_file"
    else
        echo "Failed to apply $resource_type: $resource_file"
        exit 1
    fi
}

# Function to check if a resource exists
resource_exists() {
    local resource_type=$1
    local resource_name=$2

    kubectl get "$resource_type" "$resource_name" &> /dev/null
}

# Deploy Deployments
apply_resources "Deployments" "path/to/frontend-deployment.yml"
apply_resources "Deployments" "path/to/backend-deployment.yml"

# Deploy Services
apply_resources "Services" "path/to/frontend-service.yaml"
apply_resources "Services" "path/to/backend-service.yaml"

# Deploy Ingress
apply_resources "Ingress" "path/to/ingress.yaml"

# Check if Ingress resource exists
if resource_exists "Ingress" "my-ingress"; then
    echo "Ingress resource 'my-ingress' already exists."
    # Additional actions if the resource exists (e.g., handle updates)
    # kubectl apply -f "path/to/updated-ingress.yaml"
else
    echo "Ingress resource 'my-ingress' does not exist."
fi

echo "Deployment completed successfully!"

