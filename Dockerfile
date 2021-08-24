# Host OS Image
FROM python:3.9.6-slim-bullseye

# Setup ENV
RUN mkdir /Fizilion && chmod 777 /Fizilion
ENV PATH="/Fizilion/bin:$PATH"
WORKDIR /Fizilion

# Install Some Package
RUN echo 'deb http://deb.debian.org/debian bullseye main' > /etc/apt/sources.list.d/docker.list && \
    apt-get update 
RUN apt-get install -y --no-install-recommends \
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

# Clone Forkzilion Repo
RUN git clone https://github.com/DunggVN/Forkzilion -b DunggVN /Fizilion

# Copy Session and Config
COPY ./sample_config.env ./userbot.session* ./config.env* /Fizilion/

# Install Required Pypi Modules
RUN pip install -r requirements.txt

# Run your bot
CMD ["python3","-m","userbot"]
