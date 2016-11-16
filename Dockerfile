FROM python:2.7.12

MAINTAINER ljy

RUN pip install tornado==3.2.1 
ADD http://www.ljy2010a.com/web.py .
CMD ["python","web.py"]
EXPOSE 8888