#include <stdio.h>
#include <stdlib.h>

#include "stack.h"
#include "queue.h"

void stack_test(void)
{
	node_s *top = NULL;
	data_t data;
	int err = 0;
	
	stack_push(&top, 1);
	stack_push(&top, 2);
	stack_push(&top, 3);
	stack_push(&top, 4);
	
	while (1){
		printf("size of %d\n", stack_get_size());
		err = stack_pop(&top, &data);
		if (err != 0)
			break;
		
		printf("%u\n", data);
	}
	
}

void queue_test(void)
{
	int i;
	int err;
	data_t data;
	queue_s *q = (queue_s *)malloc(sizeof(queue_s));
	
	if (q == NULL) 
		return;
	queue_init(q, 10);
	
	for (i = 0; i < 8; i++) {
			queue_enqueue(q, i);
	}
	
	while (1) {
		err = queue_dequeue(q, &data);
		if (err != 0) {
			break;
		}
		printf("data is %u\n", data);
	}
	
	
	for (i = 0; i < 8; i++) {
			queue_enqueue(q, i);
	}
	
	while (1) {
		err = queue_dequeue(q, &data);
		if (err != 0) {
			break;
		}
		printf("data is %u\n", data);
	}
	
}

void main(void) {
	
	stack_test();
	queue_test();

}
