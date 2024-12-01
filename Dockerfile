FROM public.ecr.aws/lambda/python:3.12

COPY ./src/app ./app
COPY ./src/requirements.txt ./requirements.txt

RUN pip install -r ./requirements.txt

CMD [ "app.main.handler" ]