# Download this repo.
    git clone https://github.com/R1ghTsS/Nexus-Cli-Multiple-Docker.git && cd Nexus-Cli-Multiple-Docker
# Install nexus
    sed -i 's/\r$//' nexus_setup.sh && chmod +x nexus_setup.sh && ./nexus_setup.sh
# If working (mining) fine, ctrl P + Q to exit
# To run the 2nd instance, 3rd instance ...
    ./nexus.sh
