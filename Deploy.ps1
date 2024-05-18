Write-Host "Running automated steps"
$testResult = dotnet test ./test/SuperService.UnitTests.csproj
# $testResult = "true"

#check if tests passed
if ($testResult -like '*Passed*') {
# if ($testResult -eq "true") {
    Write-Host "Automated tests passed. Proceeding now to build the docker image."
    

    #build docker image
    Write-Host "Building docker image"
    $dockerBuildResult = podman build -t super-service:v1.7 .

    #check if docker build succeeded
    if ($dockerBuildResult -like '*Successfully*'){
        Write-Host "Docker image built successfully. Proceeding to run container"

        podman run -d -p 8080:80 localhost/super-service:v1.7


        # For example, deploying to Azure Container Registry and Azure App Service
        # az acr login --name your-acr-name
        # docker tag your-web-api-image your-acr-name.azurecr.io/your-web-api-image:latest
        # docker push your-acr-name.azurecr.io/your-web-api-image:latest
        # az webapp config container set --name your-web-app-name --resource-group your-resource-group --docker-custom-image-name your-acr-name.azurecr.io/your-web-api-image:latest --docker-registry-server-url https://your-acr-name.azurecr.io
    
    }else {
        Write-Host "Docker image build failed. Aborting deployment"
        exit 1
    }
}else {
    Write-Host "Automated test failed. Aborting deployment"
    exit 1
}