FROM python:3
RUN apt-get update && apt-get install -y
RUN pip install requests
COPY ./products.py /tmp/products.py
CMD python3 /tmp/products.py