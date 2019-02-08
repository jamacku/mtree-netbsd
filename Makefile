#	$NetBSD: Makefile.in,v 1.9 2012/03/08 01:11:21 joerg Exp $

srcdir=		.

prefix=		/usr/local
exec_prefix=	${prefix}
sbindir=	${exec_prefix}/sbin
mandir=		${prefix}/share/man

man8dir=	$(mandir)/man8

CC=		gcc
CCLD=		$(CC)
LIBS=		
CPPFLAGS=	 -I. -I$(srcdir)
DEFS=		-DHAVE_CONFIG_H
CFLAGS=		-g -O2
LDFLAGS=	

INSTALL=	/usr/bin/install -c

PROG=		mtree

OBJS=	compare.o crc.o create.o excludes.o misc.o mtree.o spec.o verify.o \
	getid.o stat_flags.o pack_dev.o

all: $(PROG)

.c.o:
	$(CC) $(DEFS) $(CPPFLAGS) $(CFLAGS) -c $<

$(PROG): $(OBJS)
	$(CCLD) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)

clean:
	rm -f $(OBJS) $(PROG)

distclean: clean
	rm -f Makefile config.cache config.h config.status
	rm -f configure.lineno config.log

install:
	$(INSTALL) -m 755 -d ${DESTDIR}$(sbindir)
	$(INSTALL) -m 755 -d ${DESTDIR}$(man8dir)
	$(INSTALL) $(PROG) ${DESTDIR}$(sbindir)
	$(INSTALL) -m 444 $(PROG).8 ${DESTDIR}$(man8dir)/$(PROG).8
