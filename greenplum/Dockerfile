FROM ubuntu:18.04

LABEL maintainer="Dmytro Kazanzhy"

ARG DEBIAN_FRONTEND="noninteractive"
ARG HOME="/home/gpadmin"

COPY start.sh $HOME/

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    HOME=$HOME \
    MASTER_DATA_DIRECTORY=$HOME/master/gpseg-1

RUN apt-get update -y && \
    apt-get install -y software-properties-common gnupg locales sudo openssh-server iputils-ping && \
    locale-gen en_US.UTF-8 && \
    add-apt-repository -y ppa:greenplum/db && \
    apt-get update && \
    apt-get install -y greenplum-db && \
    groupadd gpadmin && \
    useradd -r -g gpadmin -G sudo -m gpadmin && \
    echo "gpadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "source /opt/greenplum-db-*/greenplum_path.sh;" >> $HOME/.bashrc && \
    mkdir -p $HOME/gpdata && \
    mkdir -p $HOME/master && \
    mkdir -p $HOME/.ssh && \
    chown -R gpadmin:gpadmin $HOME && \
    chown -R gpadmin:gpadmin /opt/greenplum-db-*/ && \
    apt-get remove -y gnupg && \
    apt-get autoremove -yqq --purge && \
    apt-get clean -s && \
    rm -rf /var/lib/apt/lists

WORKDIR $HOME

USER gpadmin:gpadmin

ENTRYPOINT ["/bin/bash"]

CMD ["start.sh"]