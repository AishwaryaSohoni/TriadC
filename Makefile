TOPDIR = .
CC        =      gcc
CXX       =      g++
CPPFLAGS  = 	-I. -g -Wall -fno-inline
CFLAGS    = 	-I. -g -Wall -fno-inline

FLAGS     = 	${CPPFLAGS} ${AC_DEFS}

SOURCE = client.c \
	test-app.cc test-app.hh \
	timers-c.cc  timers-c.h \
	timers.cc timers.hh \
	tools.cc tools.hh
SUPPORT = README Makefile
TIMERSCC_LIB_OBJS = timers.o tools.o
TIMERSC_LIB_OBJS = timers.o timers-c.o tools.o


default: all

all: client.o main link

tools.o: tools.cc tools.hh
	$(CXX) $(FLAGS) -c tools.cc
	
timers.o: timers.cc timers.hh
	$(CXX) $(FLAGS) -c timers.cc
	
timers-c.o: timers-c.cc timers-c.h
	$(CXX) $(FLAGS) -c timers-c.cc
	
client.o: tools.o timers.o timers-c.o client.c timers-c.h
	$(CC) $(FLAGS) -c client.c
	
main: $(TOPDIR)/projb.c $(TOPDIR)/projb.h $(TOPDIR)/manager.c $(TOPDIR)/manager.h $(TOPDIR)/comm.h $(TOPDIR)/comm.c $(TOPDIR)/sha1.h $(TOPDIR)/sha1.c $(TOPDIR)/log.h $(TOPDIR)/log.c $(TOPDIR)/ring.h $(TOPDIR)/ring.c
	$(CC) -c -Wall $(TOPDIR)/projb.c $(TOPDIR)/manager.c  $(TOPDIR)/comm.c $(TOPDIR)/sha1.c $(TOPDIR)/log.c $(TOPDIR)/ring.c
	
link: tools.o timers.o timers-c.o client.o projb.o manager.o comm.o sha1.o log.o ring.o
	g++ -o projc projb.o manager.o client.o comm.o sha1.o log.o ring.o timers-c.o timers.o tools.o

clean: 
	rm -f *.o core *~ test-app test-app-c projc
