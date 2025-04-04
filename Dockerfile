FROM python:3.13-slim

WORKDIR /code

COPY ./dependencies/requirements.txt /code/dependencies/requirements.txt
COPY ./dependencies/apt_requirements.txt /code/dependencies/apt_requirements.txt

RUN apt-get update && \
    # xargs -a /code/dependencies/apt_requirements.txt apt-get install -y && \
    apt install -y git && \
    apt-get clean

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /code/dependencies/requirements.txt

RUN rm /code/dependencies/requirements.txt /code/dependencies/apt_requirements.txt

COPY . /code/
RUN chmod +x /code/entrypoint.sh

ENTRYPOINT [ "/code/entrypoint.sh" ]
