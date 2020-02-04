CC=$(CROSS_COMPILE)gcc

LIBSDIR = .
## libdatastructure.so
LIBTARGET = libds.so 
TARGET = test.elf
CFLAGS   = -Wall -g -O -fPIC
LFLAGS += -L$(LIBSDIR) -lds

INCLUDE = -I. -I./queue -I./graph
QUEUE_SRC = $(wildcard ./queue/*.c)
QUEUE_OBJ = m_queue.o
GRAPH_SRC = $(wildcard ./graph/*.c)

OBJS = $(QUEUE_OBJ)




OUT = .


default:
	echo $(SRC)
	$(CC) -o  $(QUEUE_OBJ) $(QUEUE_SRC) $(INCLUDE)
	$(CC) -shared -fpic -o $(LIBTARGET) $(OBJS) 
	$(CC) -o $(TARGET) $(GRAPH_SRC) $(CFLAGS) $(INCLUDE) $(LFLAGS)
	

clean:
	rm *.o
	rm $(TARGET) $(LIBTARGET)
