TARGET = test.elf
CC = gcc
SRC_DIR = .
SRC = $(wildcard $(SRC_DIR)/*.c)
CFLAGS = -g3
CFLAGS += -lpthread -lm
default:
	$(CC) -o $(TARGET) $(SRC) $(CFLAGS)


