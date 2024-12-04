FROM python:alpine

RUN apk --no-cache add gcc musl-dev python3-dev libffi-dev openssl-dev cargo make curl wget netcat-openbsd iputils tcpdump bind-tools htop git file zsh busybox-extras postgresql-client

RUN pip install --upgrade pip && \
    pip install azure-cli azure-storage-blob azure-storage-queue urllib3 pillow

RUN apk --update add --virtual build-dependencies --no-cache wget tar && \
    apk --update add libc6-compat ca-certificates && \
    wget -O azcopyv10.tar https://aka.ms/downloadazcopy-v10-linux && \
    tar -xf azcopyv10.tar && \
    cp azcopy_linux*/azcopy /usr/local/bin/azcopy && \
    rm -rf azcopy* && \
    apk del build-dependencies

CMD zsh
