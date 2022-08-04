#!/bin/bash

docker rm -f frontend

docker build -t frontend:latest .

docker run -d --name frontend -p 80:5000 frontend:latest

docker logs frontend