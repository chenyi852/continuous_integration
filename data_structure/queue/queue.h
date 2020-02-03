
#ifndef _MANGO_QUEUE_H
#define _MANGO_QUEUE_H

#include "data_types.h"

typedef struct _queue_s {
	uint32_t head;
	uint32_t rear;
	uint32_t count;
	uint32_t size;
	data_t	*array;
}queue_s;

int queue_init(queue_s *q, int size);
int queue_enqueue(queue_s *q, data_t data);
int queue_dequeue(queue_s *q, data_t *data);

#endif
