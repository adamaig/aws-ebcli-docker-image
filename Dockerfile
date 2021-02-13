FROM amazonlinux:2 as installer

ENV LANG="C.UTF-8" LC_ALL="C.UTF-8" LANGUAGE="C.UTF-8"

# install base packages
RUN set -ex \
    && yum -y -q group install "Development Tools" \
    && yum -y -q install \
       zlib-devel \
       openssl-devel \
       ncurses-devel \
       libffi-devel \
       sqlite-devel.x86_64 \
       readline-devel.x86_64 \
       bzip2-devel.x86_64 \
    && yum -y -q clean all && rm -rf /var/cache/yum

RUN git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git \
    && ./aws-elastic-beanstalk-cli-setup/scripts/bundled_installer \
    # clean up yum cache
    && yum -y -q clean all \
    && rm -rf /var/cache/yum

FROM amazonlinux:2

WORKDIR /root
# ensure both python and ebcli are in the path
ENV PATH="/root/.ebcli-virtual-env/executables:/root/.pyenv/versions/3.7.2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

COPY --from=installer /root/.ebcli-virtual-env/ /root/.ebcli-virtual-env/
COPY --from=installer /root/.pyenv/ /root/.pyenv/

CMD ["/root/.ebcli-virtual-env/executables/eb"]
