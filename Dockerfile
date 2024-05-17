FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /src

COPY ./src/*.csproj ./
RUN dotnet restore

COPY ./src/. ./
RUN dotnet publish -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

WORKDIR /app

# Update the package manager and install security updates
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/out ./

EXPOSE 80

ENTRYPOINT [ "dotnet", "SuperService.dll" ]