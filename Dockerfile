#Use the official .NET Core SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copy the csproj file and restore any dependencies (via nuget)
COPY src/*.csproj ./
RUN dotnet restore

# Copy the rest of the application code and build the application
COPY src/. ./
RUN dotnet publish -c Release -o out

# Use the official ASP.NET Core runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Expose the port the application runs on
EXPOSE 80

# Run the application
ENTRYPOINT ["dotnet", "src.dll"]

