FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["global.json", "UrlShortener.csproj", "./"]
RUN dotnet restore "UrlShortener.csproj"
COPY . .
RUN dotnet publish "./UrlShortener.csproj" -c $BUILD_CONFIGURATION -o /app/publish --no-restore /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
LABEL org.opencontainers.image.source="https://github.com/madtic/url-shortener" \
      org.opencontainers.image.description="A small ASP.NET Core URL shortener API"
ENTRYPOINT ["dotnet", "UrlShortener.dll"]