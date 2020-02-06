#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "data_types.h"
#include "queue.h"

typedef struct _adj_node_s {
	data_t dest;
	struct _adj_node_s *next;
}adj_node_s;

typedef struct _adj_list_s {
	adj_node_s *head;
}adj_list_s;

typedef struct _graph_s {
	int v;
	adj_list_s *adj_list;
}graph_s;

/*
 * utility function that create a new ajacency list node
 */
adj_node_s *new_adj_list_node(int dest)
{
	adj_node_s *node = (adj_node_s *)malloc(sizeof(adj_node_s));
	
	if (node == NULL) {
		return NULL;
	}
	
	node->dest = dest;
	node->next = NULL;
	
	return node;
}

/*
 * utility function that creates a graph of v verices
 */
 graph_s *create_graph(int v)
 {
	graph_s *graph = (graph_s *)malloc(sizeof(graph_s));
	int i;

	if (graph == NULL) {
		printf("malloc failed!\n");
		return NULL;
	}
	graph->v = v;
	graph->adj_list = (adj_list_s *)malloc(v * sizeof(adj_list_s));
	
	for (i = 0; i < v; i++){
		graph->adj_list[i].head = NULL;	
	}
	
	return graph;
 }
 
 void add_edge(graph_s *graph, data_t src, data_t dest)
 {
	/* add edge from dest to src */
	adj_node_s *dest_node = new_adj_list_node(dest);
	dest_node->next = graph->adj_list[src].head;
	graph->adj_list[src].head = dest_node;

	adj_node_s *src_node = new_adj_list_node(src);
	src_node->next = graph->adj_list[dest].head;
	graph->adj_list[dest].head = src_node;
	
 }
 
 void print_graph(graph_s *graph)
 {
	int i;
	
	for(i = 0; i < graph->v; i++) {
		adj_node_s *node = graph->adj_list[i].head;
		printf("\nvertex is %d\nhead", i);
		while (node) {
			printf("->%d", node->dest);
			node = node->next;
		}
		printf("\n");
	}
 }
 
 void graph_bfs(graph_s *graph, data_t v)
 {
	 data_t data;
	 queue_s *q = (queue_s *)malloc(sizeof(queue_s));
	 int err;
	 adj_node_s *node;
	 int i;
	 int *visited = (int *)malloc(v * sizeof(int));
	 
	 if (q == NULL)
		 return ;
	 
	 for (i = 0; i < graph->v; i++) {
		 visited[i] = 0;
	 }
	 queue_init(q, graph->v);
	 queue_enqueue(q, v);
	 visited[v] = 1;
	 printf("start from %d ", v);
	 
	 while (1) {
		 err = queue_dequeue(q, &data);
		 if (err != 0) 
			 break;
		 for (node = graph->adj_list[data].head; node != NULL; node = node->next) {
			 data = node->dest;
			 if (visited[data] != 1) {
				 printf("->%d ", data);
				 err = queue_enqueue(q, data);
				 visited[data] = 1;
			 }
			 
		 }
		 
	 }
 }

static void graph_dfsutil(graph_s *graph, int v, int visited[])
{
	adj_node_s *node;
	
	visited[v] = 1;
	printf("%d ", v);
	
	for (node = graph->adj_list[v].head; node != NULL; node = node->next) {
		if (visited[node->dest] != 1) {
			graph_dfsutil(graph, node->dest, visited);
		}
	}
	
}

void graph_dfs(graph_s *graph, data_t v)
{
	int *visited = (int *)malloc(sizeof(int) * graph->v);
	
	if (visited == NULL) {
		return;
	}
	
	memset(visited, 0, sizeof(int) * graph->v);
	
	graph_dfsutil(graph, v, visited);
}
 
 // Driver program to test above functions 
int main() 
{ 
    // create the graph given in above fugure 
    int V = 5; 
    graph_s *graph = create_graph(V); 
    add_edge(graph, 0, 1); 
    add_edge(graph, 0, 4); 
    add_edge(graph, 1, 2); 
    add_edge(graph, 1, 3); 
    add_edge(graph, 1, 4); 
    add_edge(graph, 2, 3); 
    add_edge(graph, 3, 4); 
  
    // print the adjacency list representation of the above graph 
    print_graph(graph); 
  
	graph_bfs(graph, 4);
	
	graph_dfs(graph, 2);
	
	printf("finished!\n");
    return 0; 
} 
