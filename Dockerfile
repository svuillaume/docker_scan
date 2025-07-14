FROM ubuntu:18.04

# Insecure secrets
RUN echo "AWS_SECRET_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE" > /root/.aws/credentials && \
    echo "PRIVATE_KEY=very-insecure-key" > /root/.env

# Exposed SSH private key
RUN mkdir -p /root/.ssh && \
    printf '%s\n' \
"-----BEGIN RSA PRIVATE KEY-----" \
"MIIEowIBAAKCAQEAsamplefakekeycontenthere" \
"MoreLinesOfFakePrivateKeyMaterial" \
"-----END RSA PRIVATE KEY-----" \
> /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa

# Add secrets to exposed location
RUN cp /root/.env /secrets.env && \
    cp /root/.ssh/id_rsa /ssh-key.pem && \
    chmod 644 /secrets.env /ssh-key.pem

CMD ["/bin/bash"]
