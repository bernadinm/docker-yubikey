## Docker Yubikey Integration

This shows how to use the Yubikey with a docker container.

This code below is required to get prompted for the Yubikey pin on the cli.
```bash
GPG_TTY=$(tty)
export GPG_TTY
```

### init.sh
This section below is required to perform ssh access via gpg-agent.

Without this, you won't be able to use the yubikey when attempting to ssh from github.

```bash
gpg-connect-agent updatestartuptty /bye
```

### .ssh/config
This is `COPY` into docker to allow it to stop prompting for the following message to make it less interactive:

```
The authenticity of host 'github.com (192.30.255.112)' can't be established.
ECDSA key fingerprint is SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com,192.30.255.112' (ECDSA) to the list of known hosts.
```

```bash
#!/bin/bash

docker run -ti --rm \
    -v /dev/bus/usb:/dev/bus/usb \
    -v /sys/bus/usb/:/sys/bus/usb/ \
    -v /sys/devices/:/sys/devices/ \
    -v /dev/hidraw12/:/dev/hidraw12/ \ # Disconnect and reconnect to get device (it changes)
    --privileged \
    name_of_docker_image \
    name_of_command_to_run_inside_image --some-parameters
```

This is my example that I use locally:

```bash
docker run -ti --rm \
    -v /dev/bus/usb:/dev/bus/usb \
    -v /sys/bus/usb/:/sys/bus/usb/ \
    -v /sys/devices/:/sys/devices/ \
    -v /dev/hidraw12/:/dev/hidraw12/ \
    --privileged \
    yubikey-test \
    bash
```
