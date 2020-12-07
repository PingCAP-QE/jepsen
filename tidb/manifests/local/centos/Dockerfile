FROM centos:centos7.6.1810

ENV AUTHORIZED_KEYS **None**
ADD entrypoint.sh /entrypoint.sh
ADD install-requirements.sh /install-requirements.sh

RUN tar -cf save.tar -C / var/lib/{rpm,yum} \
 && yum install -y openssh-server openssh-clients \
 && /install-requirements.sh \
 && rm -r /var/cache/yum/* /var/lib/{rpm,yum} \
 && tar -xf save.tar -C / \
 && rm save.tar
RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \
 && sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config

EXPOSE 22
CMD ["/entrypoint.sh"]

# hub.pingcap.net/qa/jepsen-node:centos7.6
