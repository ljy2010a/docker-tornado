FROM python:2.7.12

RUN pip install tornado  --no-cache-dir
ADD https://raw.githubusercontent.com/ljy2010a/docker-tornado/master/web.py .
CMD ["python","web.py"]
EXPOSE 8888
