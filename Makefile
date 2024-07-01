ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif
PATH  := /usr/local/bin:$(PATH)
CC    := clang
OBJCFLAGS := $$(objfw-config --objcflags --package OGObject --package ObjGTK4 --cppflags)
LIBS := $$(objfw-config --package ObjGTK4 --rpath --libs)

OBJ := obj

SOURCES := src/SmallExampleApp.m
OBJECTS := $(patsubst %.m, $(OBJ)/%.o, $(SOURCES))

SmallExampleApp: $(OBJECTS)
	$(CC) $^ -o $@ $(LIBS)

$(OBJ)/%.o: %.m
	@mkdir -p $(@D)
	$(CC) $(OBJCFLAGS) -c $< -o $@

build: SmallExampleApp

install: SmallExampleApp
	@install -d $(DESTDIR)$(PREFIX)/bin/
	@install -m 755 SmallExampleApp $(DESTDIR)$(PREFIX)/bin/

run: SmallExampleApp
	@./SmallExampleApp
