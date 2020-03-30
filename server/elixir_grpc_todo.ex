defmodule ElixirGrpcTodo do
  @moduledoc """
  Documentation for `ElixirGrpcTodo`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ElixirGrpcTodo.hello()
      :world

  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(GRPC.Server.Supervisor, [{ElixirGrpcTodo.Endpoint, 50051}])
    ]

    opts = [strategy: :one_for_one, name: ElixirGrpcTodo]
    Supervisor.start_link(children, opts)
  end
end
