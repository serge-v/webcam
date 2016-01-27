/*
 * Compress jpegs from surveilance camera into movies.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <err.h>
#include <dirent.h>
#include <time.h>
#include <limits.h>

static char *cam_dir;        /* directory with source annotated jpegs */
static char *processed_dir;  /* directory with processed jpegs */
static char *movies_dir;     /* result mp4 movies dir */

enum Eloglevel {
	LL_NONE,
	LL_ERROR,
	LL_WARN,
	LL_INFO,
	LL_TRACE
};

//static enum Eloglevel log_level = LL_ERROR;

static int
get_curr_timestamp()
{
	time_t now = time(NULL);
	struct tm *tm = gmtime(&now);
	return (tm->tm_year + 1900) * 10000 + (tm->tm_mon + 1) * 100 + tm->tm_mday;
}

static int
get_earliest_picture_timestamp(const char *dirname)
{
	DIR *dir = opendir(dirname);
	if (dir == NULL)
		err(1, "cannot open dir %s", dirname);

	int ts = 0;
	int now = get_curr_timestamp();
	struct dirent *entry = readdir(dir);

	while (entry != NULL) {
		if (strncmp(entry->d_name, "ann-20", 6) == 0 && strstr(entry->d_name, ".jpg") != NULL) {
			ts = atoi(&entry->d_name[4]);
			if (ts > 20160101 && ts <= now) {
				break;
			}
			ts = 0;
		}
		entry = readdir(dir);
	}

	closedir(dir);

	return ts;
}

static void
run_ffmpeg(int ts)
{
	int rc;
	char cmd[500];

	snprintf(cmd, 500,
		 "ffmpeg -v error "
		 "-y -framerate 8 "
		 "-pattern_type glob -i \"%s/ann-%d-*.jpg\" "
		 "-c:v libxvid %s/%d.mp4",
		 cam_dir, ts, movies_dir, ts);

	printf("%s\n", cmd);
	rc = system(cmd);
	if (rc != 0)
		errx(1, "cannot run ffmpeg: %d", rc);

}

static void
move_to_processed_dir(int ts)
{
	DIR *dir = opendir(cam_dir);
	if (dir == NULL)
		err(1, "cannot open dir %s", cam_dir);

	char prefix[50];
	int pxlen = snprintf(prefix, 50, "ann-%d-", ts);

	struct dirent *entry = readdir(dir);

	while (entry != NULL) {
		if (strncmp(entry->d_name, prefix, pxlen) == 0 && strstr(entry->d_name, ".jpg") != NULL) {
			char newname[PATH_MAX];
			char oldname[PATH_MAX];
			snprintf(newname, PATH_MAX, "%s/%s", processed_dir, entry->d_name);
			snprintf(oldname, PATH_MAX, "%s/%s", cam_dir, entry->d_name);
			if (rename(oldname, newname) != 0)
				err(1, "cannot move %s to %s", oldname, newname);
			printf("%s moved to %s\n", oldname, newname);
		}
		entry = readdir(dir);
	}

	closedir(dir);
}

static void
init()
{
	char *home = getenv("HOME");

	asprintf(&cam_dir, "%s/cam", home);
	asprintf(&processed_dir, "%s/cam-processed", home);
	asprintf(&movies_dir, "%s/cam-movies", home);
}

static void
deinit()
{
	free(cam_dir);
	free(processed_dir);
	free(movies_dir);
}

int main()
{
	init();

	int ts = get_earliest_picture_timestamp(cam_dir);
	if (ts == 0)
		errx(0, "no jpg files");

	printf("process ts: %d\n", ts);

	run_ffmpeg(ts);
	move_to_processed_dir(ts);

	deinit();

	return 0;
}
