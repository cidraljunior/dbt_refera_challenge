FROM public.ecr.aws/lambda/python:3.8

COPY requirements.txt  .
RUN yum install -y git 
RUN  pip install -r requirements.txt

COPY . ${LAMBDA_TASK_ROOT}
CMD [ "lambda.handler" ] 