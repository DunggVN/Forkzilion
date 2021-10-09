# Host OS Image
FROM dunggvn/forkzilion:latest

# Setup ENV
RUN mkdir /Forkzilion && chmod 777 /Forkzilion
ENV PATH="/Forkzilion/bin:$PATH"
WORKDIR /Forkzilion

# Clone Forkzilion Repo
RUN git clone https://github.com/dunggvn/Forkzilion -b DunggVN /Forkzilion

# Copy Session and Config
COPY ./sample_config.env ./userbot.session* ./config.env* /Forkzilion/

# Run your bot
CMD ["python3","-m","userbot"]
