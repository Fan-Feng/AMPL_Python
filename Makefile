# For Macintosh under OS X
# See http://docs.python.org/extending/embedding.html#linking-requirements

CC = gcc
ARCH = -m32    # The AMPL engine doesn't recognize x86_64.
DEFS =
ifdef DEBUG
DEFS = -DDEBUG -DLOGGING
endif

# It shouldn't be necessary to modify anything below.

.SUFFIXES: .c .o

PY_INC = "C:/Users/fengf/Desktop/Python/include"
PY_LIB = "C:/Users/fengf/Desktop/Python/libs"
PY_LDFLAGS = $(shell python -c "from distutils import sysconfig; print(sysconfig.get_config_var('LINKFORSHARED'))")
ASL_INC = "C:\Users\fengf\Desktop\Learning\AMPL_C_Python\asl"
ASL_LIB = "C:\Users\fengf\Desktop\Learning\AMPL_C_Python\asl"

CFLAGS = -I$(PY_INC) -I$(PY_INC2) -I$(ASL_INC) -O2 $(ARCH) $(DEFS) 

all: viewconfig amplfunc.dll

viewconfig:
	@echo PY_INC: $(PY_INC)
	@echo PY_LIB: $(PY_LIB)
	@echo PY_LDFLAGS: $(PY_LDFLAGS)
	@echo ASL_INC: $(ASL_INC)
	@echo ASL_LIB: $(ASL_LIB)

%.o: %.c # compile and Link
	$(CC) -c $(CFLAGS) $<

# The extension library must be named "amplfunc.dll" on all systems.
amplfunc.dll: funcadd.o
	$(CC) $< $(ARCH) -shared -o amplfunc.dll  -L$(ASL_LIB) -lamplsolv -L$(PY_LIB) -lpython27 

clean:
	rm -f funcadd.o

mrclean: clean
	rm -f amplfunc.dll
