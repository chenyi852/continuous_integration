#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "uthash.h"

typedef struct _mhash_s {
	int id;
	char name[10];
	UT_hash_handle hh;
}mhash_s;

typedef struct _string_hash_s {
	char *id;
	UT_hash_handle hh;
}string_hash_s;

static mhash_s *users = NULL;
int add_users(int user_id, char *name) {
	mhash_s *ms = NULL;
	
	ms = malloc(sizeof(mhash_s));
	ms->id = user_id;
	strcpy(ms->name, name);
	
	HASH_ADD_INT(users, id, ms);
}

mhash_s *find_user(int user_id) {
	mhash_s *ms;
	
	HASH_FIND_INT(users, &user_id, ms);
	
	return ms;
}

void delete_user(mhash_s *ms) {
	HASH_DEL(users, ms);
	
	free(ms);
}

/* **************************************
use char* as the key id
*****************************************
 */
static string_hash_s *dict = NULL;
int add_word(char *str) {
	string_hash_s *ss;
	
	ss = malloc(sizeof(string_hash_s));
	
	ss->id = str;
	HASH_ADD_INT(dict, id, ss);
}

string_hash_s * find_word(char *str) {
	string_hash_s *ss;
	
	HASH_FIND_INT(dict, &str, ss);
	
	return ss;
}

void uthash_test(void){
	mhash_s *search;
	string_hash_s *ss;
	
	add_users(1, "chenyi");
	add_users(3, "zhangsan");
	
	search = find_user(3);
	printf("search %s\n", search->name);
	

	add_word("chenyi");

	add_word("wangwu");

	ss = find_word("chenyi");
	if (ss != NULL)
		printf("id : %s\n", ss->id);
	
	ss = find_word("zhangsan");
	if (ss != NULL)
		printf("id : %s\n", ss->id);

}

void main(void) {
	uthash_test();
}
