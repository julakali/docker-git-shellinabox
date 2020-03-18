#!/usr/bin/dumb-init /bin/bash
set -e

# Start SIAB
chmod +x /home/${SHELL_USER}/.bashrc
shellinaboxd --disable-ssl --css=/white-on-black.css -s "/:${SHELL_USER}:${SHELL_GROUP}:/home/${SHELL_USER}:/bin/bash --login"
