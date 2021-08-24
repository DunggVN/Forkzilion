# inherit prebuilt image
FROM archlinux:latest

# env setup
RUN mkdir /Fizilion && chmod 777 /Fizilion
ENV PATH="/Fizilion/bin:$PATH"
WORKDIR /Fizilion

# install some package
RUN pacman -S curl git gcc g++ build-essential gnupg2 unzip wget ffmpeg jq neofetch python-pip

# clone repo
RUN git clone https://github.com/DunggVN/Forkzilion -b DunggVN /Fizilion

# Copies session and config(if it exists)
COPY ./sample_config.env ./userbot.session* ./config.env* /Fizilion/

# install required pypi modules
RUN pip install -r requirements.txt

# Finalization
CMD ["python3","-m","userbot"]
