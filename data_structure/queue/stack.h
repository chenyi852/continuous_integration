#ifndef _MANGO_STACK_H
#define _MANGO_STACK_H
#include "data_types.h"

typedef struct _node_s{
	data_t d;
	struct _node_s *next;	
}node_s;

int stack_get_size(void);
int stack_is_empty(node_s *top);
int stack_push(node_s **top_ref, data_t data);
int stack_pop(node_s **top_ref, data_t *ret_data);

#endif
