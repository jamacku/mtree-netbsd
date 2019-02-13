#include <stdio.h>
#include <stdlib.h>

#include <assert.h>
#include <errno.h>
#include <string.h>

#include <sys/cdefs.h>

char* fparseln(FILE *fp, size_t *len, size_t *lineno, const char delim[3], int flags)
{
	static const char dstr[3] = { '\\', '\\', '#' };

	size_t	s, len;
	char   *buf;
	char   *ptr, *cp;
	int	cnt;
	char	esc, con, nl, com;

	_DIAGASSERT(fp != NULL);

	len = 0;
	buf = NULL;
	cnt = 1;

	if (str == NULL)
		str = dstr;

	esc = str[0];
	con = str[1];
	com = str[2];
	/*
	 * XXX: it would be cool to be able to specify the newline character,
	 * but unfortunately, fgetln does not let us
	 */
	nl  = '\n';

	FLOCKFILE(fp);

	while (cnt) {
		cnt = 0;

		if (lineno)
			(*lineno)++;

		if ((ptr = __fgetln(fp, &s)) == NULL)
			break;

		if (s && com) {		/* Check and eliminate comments */
			for (cp = ptr; cp < ptr + s; cp++)
				if (*cp == com && !isescaped(ptr, cp, esc)) {
					s = cp - ptr;
					cnt = s == 0 && buf == NULL;
					break;
				}
		}

		if (s && nl) { 		/* Check and eliminate newlines */
			cp = &ptr[s - 1];

			if (*cp == nl)
				s--;	/* forget newline */
		}

		if (s && con) {		/* Check and eliminate continuations */
			cp = &ptr[s - 1];

			if (*cp == con && !isescaped(ptr, cp, esc)) {
				s--;	/* forget continuation char */
				cnt = 1;
			}
		}

		if (s == 0) {
			/*
			 * nothing to add, skip realloc except in case
			 * we need a minimal buf to return an empty line
			 */
			if (cnt || buf != NULL)
				continue;
		}

		if ((cp = realloc(buf, len + s + 1)) == NULL) {
			FUNLOCKFILE(fp);
			free(buf);
			return NULL;
		}
		buf = cp;

		(void) memcpy(buf + len, ptr, s);
		len += s;
		buf[len] = '\0';
	}

	FUNLOCKFILE(fp);

	if ((flags & FPARSELN_UNESCALL) != 0 && esc && buf != NULL &&
	    strchr(buf, esc) != NULL) {
		ptr = cp = buf;
		while (cp[0] != '\0') {
			int skipesc;

			while (cp[0] != '\0' && cp[0] != esc)
				*ptr++ = *cp++;
			if (cp[0] == '\0' || cp[1] == '\0')
				break;

			skipesc = 0;
			if (cp[1] == com)
				skipesc += (flags & FPARSELN_UNESCCOMM);
			if (cp[1] == con)
				skipesc += (flags & FPARSELN_UNESCCONT);
			if (cp[1] == esc)
				skipesc += (flags & FPARSELN_UNESCESC);
			if (cp[1] != com && cp[1] != con && cp[1] != esc)
				skipesc = (flags & FPARSELN_UNESCREST);

			if (skipesc)
				cp++;
			else
				*ptr++ = *cp++;
			*ptr++ = *cp++;
		}
		*ptr = '\0';
		len = strlen(buf);
	}

	if (size)
		*size = len;
	return buf;
}
