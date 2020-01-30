#include <stdio.h>
#include <stdlib.h>

typedef struct _adj_node_s {
	int dest;
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
 
 void add_edge(graph_s *graph, int src, int dest)
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
  
    return 0; 
} 
