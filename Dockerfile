# inherit prebuilt image
FROM ubuntu:20.04

# env setup
RUN mkdir /Fizilion && chmod 777 /Fizilion
ENV PATH="/Fizilion/bin:$PATH"
WORKDIR /Fizilion

RUN deb http://us.archive.ubuntu.com/ubuntu/ focal universe
RUN apt-get update && apt-get upgrade -y
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
    neofetch

# clone repo
RUN git clone https://github.com/DunggVN/ProjectFizilion -b DunggVNTest /Fizilion

# Copies session and config(if it exists)
COPY ./sample_config.env ./userbot.session* ./config.env* /Fizilion/

# install required pypi modules
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

# Finalization
CMD ["python3","-m","userbot"]
