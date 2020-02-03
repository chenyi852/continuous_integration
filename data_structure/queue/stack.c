#include <stdio.h>
#include <stdlib.h>

#include "stack.h"

#define dbgprn	printf

static uint32_t stack_size = 0;

int stack_get_size(void)
{
	return stack_size;
}

/*
 * return 1 if stack is empty, otherwise return 0.
 */
int stack_is_empty(node_s *top)
{
	if (top == NULL){
		return 1;
	}
	
	return 0;
}

int stack_push(node_s **top_ref, data_t data)
{
	node_s *node = (node_s *)malloc(sizeof(node_s));
	if (node == NULL) {
		printf("malloc failed!\n");
		return -1;
	}
	
	node->d = data;
	node->next = *top_ref;
	stack_size++;
	
	*top_ref = node;
	
	return 0;
}

int stack_pop(node_s **top_ref, data_t *ret_data)
{
	node_s *node;
	
	if (stack_is_empty(*top_ref) == 1){
		dbgprn("stack is empty!\n");
		return -1;
	}
	
	if (ret_data == NULL){
		dbgprn("ret_data is NULL!\n");
		return -2;
	}
	
	node = *top_ref;
	*ret_data =  node->d;
	stack_size--;
	
	*top_ref = (*top_ref)->next;
	return 0;
}