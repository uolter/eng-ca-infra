FROM hashicorp/vault:1.14

COPY vault-server.hcl /etc/vault/config.hcl

ENTRYPOINT ["/vault", "server", "-config", "/etc/vault/config.hcl"]