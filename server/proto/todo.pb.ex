defmodule Todo.SaveRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          detail: String.t()
        }
  defstruct [:detail]

  field :detail, 1, type: :string
end

defmodule Todo.SaveResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          success: boolean,
          id: String.t()
        }
  defstruct [:success, :id]

  field :success, 1, type: :bool
  field :id, 2, type: :string
end

defmodule Todo.GetRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t()
        }
  defstruct [:id]

  field :id, 1, type: :string
end

defmodule Todo.GetResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          todo: Todo.Todo.t() | nil
        }
  defstruct [:todo]

  field :todo, 1, type: Todo.Todo
end

defmodule Todo.ListRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Todo.ListResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          todos: [Todo.Todo.t()]
        }
  defstruct [:todos]

  field :todos, 1, repeated: true, type: Todo.Todo
end

defmodule Todo.UpdateRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          detail: String.t(),
          is_done: boolean
        }
  defstruct [:id, :detail, :is_done]

  field :id, 1, type: :string
  field :detail, 2, type: :string
  field :is_done, 3, type: :bool
end

defmodule Todo.UpdateResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule Todo.Todo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          detail: String.t(),
          is_done: boolean,
          updated_at: integer
        }
  defstruct [:id, :detail, :is_done, :updated_at]

  field :id, 1, type: :string
  field :detail, 2, type: :string
  field :is_done, 3, type: :bool
  field :updated_at, 4, type: :int64
end

defmodule Todo.TodoService.Service do
  @moduledoc false
  use GRPC.Service, name: "todo.TodoService"

  rpc :Save, Todo.SaveRequest, Todo.SaveResponse
  rpc :Get, Todo.GetRequest, Todo.GetResponse
  rpc :List, Todo.ListRequest, Todo.ListResponse
  rpc :Update, Todo.UpdateRequest, Todo.UpdateResponse
end

defmodule Todo.TodoService.Stub do
  @moduledoc false
  use GRPC.Stub, service: Todo.TodoService.Service
end
