
#start docker - starting database and web database frontend
db-run:
	docker-compose up

#configure database
db-setup:
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

#ecto is an orm tool 
db-create:
	mix ecto.create

#execute an migration:
user-create-table-migration:
	mix ecto.gen.migration 	create_user_table

# drop database
db-drop:
	mix ecto.drop

accout-create-table-migration:
	mix ecto.gen.migration create_account_table

check-cover-coberture
	mix test --cover	