defmodule ElixirGrpcTodo.Todo.Server do
  use GRPC.Server, service: Todo.TodoService.Service

  @spec save(Todo.SaveRequest.t(), GRPC.Server.Stream.t()) :: Todo.SaveResponse.t()
  def save(request, _stream) do
    result = Mongo.CRUD.insert(request.detail)
    Todo.SaveResponse.new(id: result.inserted_id)
  end

  @spec get(Todo.GetRequest.t(), GRPC.Server.Stream.t()) :: Todo.GetResponse.t()
  def get(request, _stream) do
    result = Mongo.CRUD.get(request.id)
    Todo.GetResponse.new(todo: convert_to_grpc_todo(result))
  end

  @spec update(Todo.UpdateRequest.t(), GRPC.Server.Stream.t()) :: Todo.UpdateResponse.t()
  def update(request, _stream) do
    _ = Mongo.CRUD.update(request.id, request.detail, request.is_done)
    Todo.UpdateResponse.new()
  end

  @spec list(Todo.ListRequest.t(), GRPC.Server.Stream.t()) :: Todo.ListResponse.t()
  def list(_request, _stream) do
    results = Mongo.CRUD.list()
    ret = Enum.map(results, fn result -> convert_to_grpc_todo(result) end)
    Todo.ListResponse.new(todos: ret)
  end

  defp convert_to_grpc_todo(map) do
    Todo.Todo.new(id: map["_id"],
    detail: map["detail"],
    is_done: map["is_done"],
    updated_at: map["updated_at"])
  end
end
