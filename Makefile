
#start docker - starting database and web database frontend
db-run:
	docker-compose up

#configure database
db-create:
	mix ecto.setup

#call to update project dependencies
update-deps:
	mix deps.get

#generate credo config files
credo-config:
	mix credo gen.config

#start up phoenix server
server-up:
	mix phx.server 

#using relp in scope of project
ixe-project:
	iex -S mix	

#running unit tests
unit-test:
	mix test