FROM alpine/git:v2.24.1
RUN echo @testing http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
 && apk add --update-cache --no-cache \
        ca-certificates \
        dumb-init \
        bash \
        curl \
        jq \
        nano \
        bash-completion \
        git-bash-completion \
        shellinabox@testing \
 && curl -sLfo /white-on-black.css https://github.com/shellinabox/shellinabox/raw/v2.20/shellinabox/white-on-black.css

ADD https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh /usr/share/git-prompt/
RUN chmod 655 /usr/share/git-prompt/git-prompt.sh

ADD load-bashrc.sh /etc/profile.d/

ENV SHELL_USER user
ENV SHELL_GROUP user

RUN addgroup ${SHELL_GROUP}
RUN adduser -D -h /home/${SHELL_USER} -s /bin/bash -G ${SHELL_GROUP} ${SHELL_USER}
RUN echo "source /usr/share/git-prompt/git-prompt.sh" >> /home/${SHELL_USER}/.bashrc
RUN echo "GIT_PS1_SHOWCOLORHINTS=true" >> /home/${SHELL_USER}/.bashrc
RUN echo "PROMPT_COMMAND='__git_ps1 "\\\\\\u@\\\\\\h:\\\\\\w" "\\\$\\\ "'"  >> /home/${SHELL_USER}/.bashrc

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 4200
