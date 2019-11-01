FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 3001

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY . ElectricityService/
RUN dotnet restore ElectricityService
WORKDIR  /src/ElectricityService
RUN dotnet build

FROM build AS publish
RUN dotnet publish -o /app
FROM base AS final
WORKDIR /app

COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ElectricityService.dll"]

