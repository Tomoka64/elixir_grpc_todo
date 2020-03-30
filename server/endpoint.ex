defmodule ElixirGrpcTodo.Endpoint do
  use GRPC.Endpoint

  intercept GRPC.Logger.Server
  run ElixirGrpcTodo.Todo.Server
end