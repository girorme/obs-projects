# Use an official Elixir runtime as a parent image
FROM elixir:1.12

RUN apt-get update

# Install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force
# RUN mix archive.install hex phx_new 1.5.9 --force

# Create code directory and copy the Elixir projects into it
RUN mkdir /code
COPY ./account /code
WORKDIR /code

#CMD ["/code/entrypoint.sh"]
CMD mix deps.get && mix run --no-halt