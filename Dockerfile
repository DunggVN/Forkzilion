# inherit prebuilt image
FROM debian:latest

# env setup
RUN mkdir /Fizilion && chmod 777 /Fizilion
ENV PATH="/Fizilion/bin:$PATH"
WORKDIR /Fizilion

RUN echo 'deb http://deb.debian.org/debian bullseye main' > /etc/apt/sources.list.d/backports.list && \
    apt-get update 
RUN apt-get install -y --no-install-recommends \
    curl \
    git \
    gcc \
    g++ \
    build-essential \
    gnupg2 \
    unzip \
    wget \
    ffmpeg \
    jq \
    libpq-dev \
    neofetch \
    python-pip \
    python3-pip

# clone repo
RUN git clone https://github.com/DunggVN/Forkzilion -b DunggVNTest /Fizilion

# Copies session and config(if it exists)
COPY ./sample_config.env ./userbot.session* ./config.env* /Fizilion/

# install required pypi modules
RUN pip install -r requirements.txt

# Finalization
CMD ["python3","-m","userbot"]
