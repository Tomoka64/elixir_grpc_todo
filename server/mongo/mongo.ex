defmodule Mongo.CRUD do
  @mongo_url "mongodb://localhost:27017/db-1"
  @table_name "todo"

  def get(id) do
    {:ok, conn} = Mongo.start_link(url: @mongo_url)
    result = Mongo.find_one(conn, @table_name, %{_id: id})
    result
  end

  def insert(detail) do
    {:ok, conn} = Mongo.start_link(url: @mongo_url)
    uuid = Ecto.UUID.generate()
    now = :os.system_time(:millisecond)
    {:ok, result} = Mongo.insert_one(conn, @table_name, %{_id: uuid, detail: detail, is_done: false, updated_at: now, created_at: now})
    Map.from_struct(result)
  end

  def list() do
    {:ok, conn} = Mongo.start_link(url: @mongo_url)
    cursor = Mongo.find(conn, @table_name, %{})
    cursor
    |> Enum.to_list()
  end

  def update(id, detail, is_done) do
    {:ok, conn} = Mongo.start_link(url: @mongo_url)
    now = :os.system_time(:millisecond)
    {:ok, updated} = Mongo.update_one(conn, @table_name, %{_id: id}, ["$set": [detail: detail, is_done: is_done, updated_at: now]])
    Map.from_struct(updated)
  end
end