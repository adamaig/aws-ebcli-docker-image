FROM amazonlinux:2 as installer

ENV LANG="C.UTF-8" LC_ALL="C.UTF-8" LANGUAGE="C.UTF-8"
# ensure both python and ebcli are in the path
ENV PATH="/root/.ebcli-virtual-env/executables:/root/.pyenv/versions/3.7.2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
CMD ["/root/.ebcli-virtual-env/executables/eb"]

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
       git \
       python37 \
       python3-pip \
       python-virtualenv

RUN pip3 install --upgrade pip \
    && pip3 install wheel --upgrade \
    && pip3 install awsebcli --upgrade

# clean up yum cache
RUN yum -y -q clean all \
    && rm -rf /var/cache/yum
