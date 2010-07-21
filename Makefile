OCC=ocamlc
CC=ocaml
EXEC=LISE
SOURCES=tools.ml dialogs.ml lang.ml logView.ml formulaEditor.ml formulaBook.ml actorTree.ml mainWindow.ml main.ml
MODULES=lablgtk.cma lablgtksourceview2.cma gtkInit.cmo
INCLUDES=+lablgtk2

all: mainWindow
	$(OCC) -I $(INCLUDES) -o $(EXEC) $(MODULES) $(SOURCES)

mainWindow: formulaBook actorTree logView dialogs lang
	$(OCC) -I $(INCLUDES) -o $(EXEC) $(MODULES) $(SOURCES)

logView: lang
	$(OCC) -I $(INCLUDES) -o $(EXEC) $(MODULES) $(SOURCES)

formulaBook: formulaEditor
	$(OCC) -I $(INCLUDES) -o $(EXEC) $(MODULES) $(SOURCES)

formulaEditor: tools
	$(OCC) -I $(INCLUDES) -o $(EXEC) $(MODULES) $(SOURCES)

%: %.ml
	$(CC) -I $(INCLUDES) $(MODULES) $^

clean:
	rm -rf *.cm*
