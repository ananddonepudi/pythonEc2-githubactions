# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /app

# Copy csproj file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the source code
COPY . ./

# Build and publish the app to /app/publish
RUN dotnet publish -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app

# Copy published app from build stage
COPY --from=build /app/publish .

# Expose port for container
EXPOSE 8080

# Run the app
ENTRYPOINT ["dotnet", "dotnet-api.dll"]

