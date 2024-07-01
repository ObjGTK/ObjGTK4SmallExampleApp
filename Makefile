ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif
PATH  := /usr/local/bin:$(PATH)
CC    := clang
CFLAGS := $$(objfw-config --package ObjGTK4 --cppflags)
OBJCFLAGS := $$(objfw-config --objcflags)
LIBS := $$(objfw-config --package ObjGTK4 --rpath --libs)

OBJ := obj

SOURCES := src/SmallExampleApp.m
OBJECTS := $(patsubst %.m, $(OBJ)/%.o, $(SOURCES))

SmallExamppleApp: $(OBJECTS)
	$(CC) $^ -o $@ $(LIBS)

$(OBJ)/%.o: %.m
	@mkdir -p $(@D)
	$(CC) $(OBJCFLAGS) $(CFLAGS) -c $< -o $@

build: SmallExampleApp

install: SmallExampleApp
	@install -d $(DESTDIR)$(PREFIX)/bin/
	@install -m 755 SmallExamppleApp $(DESTDIR)$(PREFIX)/bin/

run: SmallExampleApp
	@./SmallExampleApp
