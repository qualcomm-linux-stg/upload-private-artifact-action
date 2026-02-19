FROM public.ecr.aws/docker/library/alpine:3.21

RUN apk add --no-cache curl unzip

# Install AWS CLI v2
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    elif [ "$ARCH" = "aarch64" ]; then \
        curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    unzip awscliv2.zip && \
    ./aws/install --bin-dir /usr/bin --install-dir /usr/local/aws-cli --update && \
    rm -rf aws awscliv2.zip

# Ensure aws is on PATH
ENV PATH="/usr/local/aws-cli/v2/current/bin:${PATH}"

COPY publish_artifacts.sh /
ENTRYPOINT ["/publish_artifacts.sh"]
