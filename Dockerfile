FROM public.ecr.aws/docker/library/alpine:3.21

# Install dependencies
RUN apk add --no-cache aws-cli

# Copy entrypoint script into the container
COPY --chmod=0755 publish_artifacts.sh /

ENTRYPOINT ["/publish_artifacts.sh"]

