#include <stdio.h>
#include <stdlib.h>

#include "stack.h"

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

void main(void) {
	
	stack_test();

}
