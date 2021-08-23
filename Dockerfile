# inherit prebuilt image
FROM python:3.9.6-slim-bullseye

# env setup
RUN mkdir /Fizilion && chmod 777 /Fizilion
ENV PATH="/Fizilion/bin:$PATH"
WORKDIR /Fizilion

RUN echo 'deb http://deb.debian.org/debian bullseye main' > /etc/apt/sources.list && \
    apt-get update 
RUN apt-get -f install -y --no-install-recommends \
    curl \
    git \
    g++ \
    build-essential \
    gnupg2 \
    unzip \
    ffmpeg \
    jq \
    libpq-dev \
    neofetch

# clone repo
RUN git clone https://github.com/DunggVN/Forkzilion -b DunggVNTest /Fizilion

# Copies session and config(if it exists)
COPY ./sample_config.env ./userbot.session* ./config.env* /Fizilion/

# install required pypi modules
RUN pip3 install -r requirements.txt

# Finalization
CMD ["python3","-m","userbot"]
