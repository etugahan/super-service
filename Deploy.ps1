Write-Host "Running automated steps"
$testResult = dotnet test ./test/SuperService.UnitTests.csproj
# $testResult = "true"

#check if tests passed
if ($testResult -like '*Passed*') {
# if ($testResult -eq "true") {
    Write-Host "Automated tests passed. Proceeding now to build the docker image."
    

    #build docker image
    Write-Host "Building docker image"
    $dockerBuildResult = podman build -t super-service:v1.6 .

    #check if docker build succeeded
    if ($dockerBuildResult -like '*Successfully*'){
        Write-Host "Docker image built successfully. Proceeding to run container"

        podman run -d -p 8081:80 --name super-service-app localhost/super-service:v1.6
    }else {
        Write-Host "Docker image build failed. Aborting deployment"
        exit 1
    }
}else {
    Write-Host "Automated test failed. Aborting deployment"
    exit 1
}