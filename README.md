# SSH Configuration Project

This repository contains scripts and configurations for setting up secure SSH connections to servers.

---

## Contents

- **0-use_a_private_key**  
  Bash script to connect to a server using a specific private key.

- **1-create_ssh_key_pair**  
  Bash script to generate a 4096-bit RSA key pair (`school`/`school.pub`) with passphrase `betty`.

- **2-ssh_config**  
  SSH client configuration file for all hosts, using `~/.ssh/school` and disabling password authentication.

- **100-puppet_ssh_config.pp**  
  Puppet manifest to manage system-wide SSH client configuration (`/etc/ssh/ssh_config`).

---

## Usage

### 1. Generate SSH Key Pair

```bash
./1-create_ssh_key_pair
```

- Creates `school` (private) and `school.pub` (public) keys in the current directory.

### 2. Configure SSH Client

```bash
cp 2-ssh_config ~/.ssh/config
chmod 600 ~/.ssh/config
```

### 3. Apply System-wide SSH Config (Optional)

```bash
sudo puppet apply 100-puppet_ssh_config.pp
```

### 4. Test SSH Connection

```bash
./0-use_a_private_key
```

---

## Best Practices

- **Keep private keys secure:**  
  `chmod 600 ~/.ssh/*`
- **Use passphrases** for added security.
- **Rotate keys** regularly.
- **Use different keys** for different environments.

---

## Troubleshooting

- **Permission denied errors:**  
  Check key permissions:  
  `chmod 600 ~/.ssh/*`
- **Connection refused:**  
  Verify server IP and SSH service status.
- **Authentication failures:**  
  Confirm your public key is in the server's `authorized_keys`.