FROM dunggvn/forkzilion:latest

RUN mkdir /Forkzilion && chmod 777 /Forkzilion && git clone https://github.com/dunggvn/Forkzilion -b SuperLite /Forkzilion
ENV PATH="/Forkzilion/bin:$PATH"
WORKDIR /Forkzilion

COPY ./sample_config.env ./userbot.session* ./config.env* /Forkzilion/

CMD ["python3","-m","userbot"]
