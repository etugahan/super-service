# super-service

A. Automated Deployment
Instructions:
1. Clone the source code https://github.com/etugahan/super-service.git
2. Run the powershell script Deploy.ps1 with below command.
   ./Deploy.ps1

   - The script will first run the test. If the test fails, the script will exit and will not proceed with the next step.
   - If the test is successful, the script will build the application into a docker image.
   - If the build is successful, the script will deploy the containerized application locally. Else it will exit.
   - Sample commands are included in the script to deploy in the cloud if connection to the cloud resources such as Azure Container Registry and Azure App Services is available.
   - NOTE: Updated the .Net Framework version to net8.0



B. Kubernetes Cluster
1. Hosting Provider

The deployment will be on Microsoft Azure, using Azure Kubernetes Service (AKS) for the Kubernetes cluster.

2. Cluster Configuration

Azure Kubernetes Service (AKS)
Resource Group: Create a resource group for organizing all resources.
AKS Cluster: Deploy an AKS cluster within this resource group. Ensure that it is set up with multiple nodes across different availability zones for high availability.
Node Pools: Use node pools to separate workloads if needed, such as for frontend services, backend services, and database services.

3. Networking

Public Web Services
Azure Load Balancer: Use an Azure Load Balancer to expose the Kubernetes services to the internet. This will distribute incoming traffic across the nodes in the AKS cluster.
Ingress Controller: Deploy an NGINX Ingress Controller in the AKS cluster to manage incoming HTTP/HTTPS traffic and route it to the appropriate services.
Secure Access to Internal Systems
Virtual Network Peering: Peer the AKS virtual network with the "internal-assets" virtual network to allow secure communication between the AKS cluster and the internal systems.
Network Security Groups (NSGs): Configure NSGs to control inbound and outbound traffic to the AKS nodes. Only allow necessary traffic to and from the internal systems.
Private Link/Endpoints: Use Azure Private Link to create private endpoints for the services in the "internal-assets" network. This ensures that the traffic between the AKS cluster and the internal systems does not go over the public internet.
![alt text](<K8S Cluster.jpg>)


4. Monitoring and Notifications

Azure Monitor: Use Azure Monitor and Azure Log Analytics to collect and analyze logs and metrics from the AKS cluster.
Azure Alerts: Set up alerts in Azure Monitor to notify the support team if there are connectivity issues between the web services and the internal systems. Alerts can be configured to send notifications via email, SMS, or integration with incident management tools like PagerDuty or Slack.


5. Automated Deployments

Azure DevOps: Use Azure DevOps for CI/CD pipelines. Set up pipelines to automate the build, test, and deployment processes for the web services.
GitOps: Implement GitOps practices using tools like Github Actions or Azure DevOps Pipelines to automate deployments based on changes in the Git repository.

![alt text](<CICD with Monitoring.png>)

![alt text](<CICD Diagram-Backend.jpg>)