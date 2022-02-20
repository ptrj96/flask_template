FROM  tiangolo/uwsgi-nginx-flask:python3.9 as base

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

FROM base AS pipenv-deps

# Install pipenv and compilation dependencies
RUN pip install pipenv
RUN apt-get update && apt-get install -y --no-install-recommends gcc

# Install python dependencies
COPY Pipfile .
COPY Pipfile.lock .
RUN pipenv lock -r > requirements.txt

FROM base AS run

COPY --from=pipenv-deps /app/requirements.txt .
RUN pip install -r requirements.txt

# Install application into container
COPY . .
