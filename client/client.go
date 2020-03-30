package main

import (
	"context"
	"fmt"

	todo "example.com/m/proto"
)

type client struct {
	todo.TodoServiceClient
}

func newClient(cli todo.TodoServiceClient) *client {
	return &client{cli}
}

func (cl *client) save(ctx context.Context, detail string) error {
	res, err := cl.Save(ctx, &todo.SaveRequest{Detail: detail})
	if err != nil {
		return err
	}
	fmt.Printf("task added successfully: %s\n", res.Id)
	return nil
}

func (cl *client) list(ctx context.Context) error {
	res, err := cl.List(ctx, &todo.ListRequest{})
	if err != nil {
		return err
	}
	for _, t := range res.Todos {
		fmt.Printf("%v\n", t)
	}
	return nil
}

func (cl *client) update(ctx context.Context, id, detail string, isDone bool) error {
	_, err := cl.Update(ctx, &todo.UpdateRequest{Id: id, Detail: detail, IsDone: isDone})
	if err != nil {
		return err
	}
	return nil
}

func (cl *client) get(ctx context.Context, id string) error {
	res, err := cl.Get(ctx, &todo.GetRequest{Id: id})
	if err != nil {
		return err
	}
	fmt.Printf("%v\n", res)
	return nil
}
