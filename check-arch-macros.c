#include <stdio.h>
#include <stdint.h>
#include <sys/time.h>
#include <pthread.h>

int main()
{
#ifdef __LINUX__
	printf("__LINUX__ defined\n");
#endif

#ifdef __APPLE__
	printf("__APPLE__ defined\n");
#endif

#ifdef __MACH__
	printf("__MACH__ defined\n");
#endif

	printf("unsigned long size: %lu\n", sizeof(unsigned long));
	printf("unsigned int size: %lu\n", sizeof(unsigned int));

	printf("size_t size: %lu\n", sizeof(size_t));
	printf("int size: %lu\n", sizeof(int));
	printf("long int size: %lu\n", sizeof(long int));
	printf("long: %lu\n", sizeof(long));
	printf("long long: %lu\n", sizeof(long long));

	printf("unsigned long long*: %lu\n", sizeof(unsigned long long*));
	printf("unsigned long*: %lu\n", sizeof(unsigned long*));
	printf("size*: %lu\n", sizeof(size_t*));

	struct timeval tv;
	printf("timeval: %lu\n", sizeof(struct timeval));
	printf("timeval.tv_sec: %lu, offs: %llu\n", sizeof(tv.tv_sec), (uint64_t)&tv.tv_sec - (uint64_t)&tv);
	printf("timeval.tv_usec: %lu, offs: %llu\n", sizeof(tv.tv_usec), (uint64_t)&tv.tv_usec - (uint64_t)&tv);

	printf("pthread_t: %lu\n", sizeof(pthread_t));
	
	unsigned long long* p1 = 0;
	unsigned long* p2 = 0;
	
	// check -Wincompatible-pointer-types warning

	p1 = p2;
	p2 = p1;
}

