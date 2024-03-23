# Use Arch Linux as the base image
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /minecraft

# Copy everything from the project's root directory to the working directory
COPY .. /minecraft

# Install necessary packages (e.g., wget, java)
RUN apk update && \
    apk add --no-cache openjdk21-jre-headless wget jq bash curl eudev rcon && \
    rm -rf /var/cache/apk/*

# Run the launcher script to set up the Minecraft server
RUN chmod +x ./launcher && \
    ./launcher setup

# Expose the Minecraft server port
EXPOSE 25565

# Start the Minecraft server using the launcher script
ENTRYPOINT ["/minecraft/launcher"]