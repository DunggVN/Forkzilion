# Host OS Image
FROM dunggvn/forkzilion:latest

# Setup ENV
RUN mkdir /Fizilion && chmod 777 /Fizilion
ENV PATH="/Fizilion/bin:$PATH"
WORKDIR /Fizilion

# Clone Forkzilion Repo
RUN git clone https://github.com/dunggvn/Forkzilion -b DunggVN /Fizilion

# Copy Session and Config
COPY ./sample_config.env ./userbot.session* ./config.env* /Fizilion/

# Install Required Pypi Modules
RUN pip install -r requirements.txt

# Run your bot
CMD ["python3","-m","userbot"]
