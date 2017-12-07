#!/bin/bash

sem-apply --url postgresql://dev:devpass@localhost:5432/dev
sem-apply --url postgresql://test:testpass@localhost:5432/test

rm -rf ./data/*
