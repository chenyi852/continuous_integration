#include <stdio.h>
#include <stdlib.h>

#include "queue.h"

static int queue_is_empty(queue_s *q)
{
	if (q->count == 0) {
		return 1;
	}
	
	return 0;
}

static int queue_is_full(queue_s *q)
{
	if (q->count == q->size) {
		return 1;
	}
	
	return 0;
}

int queue_init(queue_s *q, int size)
{
	q->array = (data_t *)malloc(sizeof(data_t) * size);
	if (q->array  == NULL) {
		printf("malloc failed!\n");
		return -1;
	}
		
	
	q->size = size;
	q->count = 0;
	q->head = 0;
	q->rear = 0;
	
	return 0;
}

int queue_enqueue(queue_s *q, data_t data)
{
	if (q == NULL){
		return -1;
	}
	
	if (queue_is_full(q)) {
		printf("Queue overflow!\n");
		return -2;
	}
	
	q->array[q->head] =  data;
	q->head++;
	if (q->head == q->size){
		q->head = 0;
	}
	q->count++;
	
	return 0;
}

int queue_dequeue(queue_s *q, data_t *data)
{
	if (q == NULL)
		return -1;
	
	if (queue_is_empty(q)){
		printf("queue underflow!\n");
		return -2;
	}
	
	*data = q->array[q->rear];
	q->rear++;
	if (q->rear == q->size){
		q->rear = 0;
	}
	q->count--;
		
	return 0;
}

