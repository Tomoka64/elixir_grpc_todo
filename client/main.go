package main

import (
	todo "example.com/m/proto"
	"golang.org/x/net/context"

	"flag"
	"fmt"
	"os"

	"google.golang.org/grpc"
)

var (
	detail = flag.String("d", "clean up my room", "put your todo-list")
	id     = flag.String("i", "a", "put id")
	isDone = flag.Bool("done", false, "is done")
)

func main() {
	flag.Parse()

	conn, err := grpc.Dial(":50051", grpc.WithInsecure())
	if err != nil {
		fmt.Printf("could not connect%v\n", err)
		os.Exit(1)
	}
	client := newClient(todo.NewTodoServiceClient(conn))
	ctx := context.Background()

	switch cmd := flag.Arg(0); cmd {
	case "list":
		err = client.list(ctx)
	case "add":
		err = client.save(ctx, *detail)
	case "update":
		err = client.update(ctx, *id, *detail, *isDone)
	case "get":
		err = client.get(ctx, *id)
	default:
		err = fmt.Errorf("unknown subcommand %s", cmd)
	}
	if err != nil {
		os.Exit(1)
	}
}
