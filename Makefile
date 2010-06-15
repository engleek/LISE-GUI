OCC=ocamlc
CC=ocaml
EXEC=ANRLISEGUI
SOURCES=tools.ml formulaEditor.ml actorTree.ml main.ml
MODULES=lablgtk.cma gtkInit.cmo
INCLUDES=+lablgtk2

all: formulaEditor actorTree
	$(OCC) -I $(INCLUDES) -o $(EXEC) $(MODULES) $(SOURCES)

formulaEditor: tools
	$(OCC) -I $(INCLUDES) -o $(EXEC) $(MODULES) $(SOURCES)

%: %.ml
	$(CC) -I $(INCLUDES) $(MODULES) $^

clean:
	rm -rf *.cm*
