#!/usr/bin/env bash

# Install Docker (only needed once)
if ! command -v docker &>/dev/null; then
    echo "Installing Docker..."
    sudo apt update
    sudo apt install -y docker.io curl ca-certificates
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker installed successfully."
else
    echo "Docker already installed."
fi

# Create working dir
mkdir -p nexus-docker && cd nexus-docker || exit 1

# Create Dockerfile
cat <<'EOL' > Dockerfile
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Install dependencies
RUN apt update && apt install -y \
    curl build-essential pkg-config libssl-dev \
    git protobuf-compiler ca-certificates bash && \
    rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Add riscv target
RUN /root/.cargo/bin/rustup target add riscv32i-unknown-none-elf

# Default interactive shell
CMD ["/bin/bash"]
EOL

# Determine instance number safely
existing_instances=$(docker ps -a --filter "name=nexus-docker-" --format "{{.Names}}" | grep -Eo '[0-9]+' | sort -n | tail -1)
existing_instances=${existing_instances:-0}
instance_number=$((existing_instances + 1))
container_name="nexus-docker-$instance_number"

# Create persistent data folder in $HOME
data_dir="$HOME/nexus-data/$container_name"
mkdir -p "$data_dir"

# Build the image
docker build -t "$container_name" "$PWD"

# Print instructions
echo -e "\e[32mSetup complete. To run your Nexus container interactively:\e[0m"
echo "docker run -it --name $container_name -v $data_dir:/root/.nexus $container_name"
echo -e "\n\e[33mInside the container, run the following:\e[0m"
echo -e "  source ~/.cargo/env"
echo -e "  curl https://cli.nexus.xyz/ | bash"
echo -e "  source ~/.bashrc"
echo -e "  nexus-network start --node-id <your-node-id>"
echo -e "\nUse \e[36mCtrl + P + Q\e[0m to detach after it's running."