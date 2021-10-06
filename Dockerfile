# inherit prebuilt image
FROM dunggvn/forkzilion:latest

# env setup
RUN mkdir /Forkzilion && chmod 777 /Forkzilion
ENV PATH="/Forkzilion/bin:$PATH"
WORKDIR /Forkzilion

# clone repo
RUN git clone https://github.com/dunggvn/Forkzilion -b DunggVNTest /Forkzilion

# Copies session and config(if it exists)
COPY ./sample_config.env ./userbot.session* ./config.env* /Forkzilion/

# Finalization
CMD ["python3","-m","userbot"]
