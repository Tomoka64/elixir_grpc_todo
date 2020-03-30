.PHONY: protogen
protogen:
	protoc --go_out=plugins=grpc:./client/ proto/*.proto
	protoc --elixir_out=plugins=grpc:./server/ proto/todo.proto

.PHONY: run-db
run-db:
	docker-compose up -d mongodb

.PHONY: stop-db
stop-db:
	docker-compose stop

run:
	MIX_ENV=prod mix grpc.server