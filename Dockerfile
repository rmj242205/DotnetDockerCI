# Use the official .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /app
COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "DotnetDockerCI.dll"]