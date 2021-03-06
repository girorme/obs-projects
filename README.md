Obs Projects
---

This simple project show how some observability can be applied to web app / services

> In this case, this repository has (in progress...) applications surrounded by logs, metrics, and traces that are often known as the three pillars of observability

### Stack
- Applications in
  - Golang
  - Nodejs
  - Elixir
- ELK to logs / apm

### Start project
```
$ docker-compose up
```

### Logs
After containers starts you can visit `localhost:5601` to access `kibana`, so in Menu > Observability > Logs you're able to see log writing:

![kibana](assets/kibana.png)


### Todo
- [X] Emit logs with filebeat
- [ ] Add metrics system
- [ ] Add tracing
- [ ] ELK Apm system via agents
- [ ] Add kubernetes example
