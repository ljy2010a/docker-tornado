FROM python:2.7.12

RUN pip install tornado  --no-cache-dir
ADD http://54.238.210.81/web.py .
CMD ["python","web.py"]
EXPOSE 8888