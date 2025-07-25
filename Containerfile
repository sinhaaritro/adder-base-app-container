# Step 1: Start from the official Deno base image.
# Using a specific version is best practice for repeatable builds.
FROM denoland/deno:1.37.1

# Step 2: Set the working directory inside the container.
WORKDIR /app

# Step 3: Clone the Deno application's source code from its GitHub repository.
# This pulls the main.ts and index.html files into the container.
# IMPORTANT: Replace this URL with the correct one for your adder app repository.
RUN git clone https://github.com/sinhaaritro/adder-base-app.git .

# Step 4 (Optimization): Pre-download and cache the Deno dependencies.
# This runs 'deno cache' which analyzes the code and downloads the modules
# from URLs (like the http/server.ts module) during the image build process.
# This makes the container start faster and ensures dependencies are baked in.
RUN deno cache main.ts

# Step 5: Tell the container runtime that the application will listen on port 8000.
# This is for documentation and can be used by other tools.
EXPOSE 8000

# Step 6: Define the default command to run when the container starts.
# We must include the permissions the Deno script needs to function correctly.
# --allow-net: For starting the web server.
# --allow-read: For reading the index.html file.
# --allow-env: For reading the WELCOME_MESSAGE environment variable.
CMD ["deno", "run", "--allow-net", "--allow-read", "--allow-env", "main.ts"]