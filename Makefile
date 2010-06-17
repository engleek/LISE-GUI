OCC=ocamlc
CC=ocaml
EXEC=ANRLISEGUI
SOURCES=tools.ml logView.ml formulaEditor.ml actorTree.ml main.ml
MODULES=lablgtk.cma gtkInit.cmo
INCLUDES=+lablgtk2

all: formulaEditor actorTree logView
	$(OCC) -I $(INCLUDES) -o $(EXEC) $(MODULES) $(SOURCES)

formulaEditor: tools
	$(OCC) -I $(INCLUDES) -o $(EXEC) $(MODULES) $(SOURCES)

%: %.ml
	$(CC) -I $(INCLUDES) $(MODULES) $^

clean:
	rm -rf *.cm*
