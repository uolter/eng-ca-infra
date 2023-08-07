FROM hashicorp/vault:1.14

COPY vault-server.hcl /etc/vault/config.hcl

CMD ["server", "-config", "/etc/vault/config.hcl"]
