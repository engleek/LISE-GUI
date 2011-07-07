OCAMLMAKEFILE = OCamlMakefile

SOURCES = v2t2/services_yacc.mly v2t2/services_lex.mll v2t2/protagonists_yacc.mly v2t2/protagonists_lex.mll v2t2/log.ml v2t2/log_yacc.mly v2t2/log_lex.mll v2t2/kripke.ml v2t2/formula.ml v2t2/formula_yacc.mly v2t2/formula_lex.mll v2t2/ctl.ml tools.ml dialogs.ml lang.ml logView.ml formulaEditor.ml formulaBook.ml actorTree.ml mainWindow.ml main.ml

RESULT = LISE
INCDIRS = +lablgtk2 
THREADS = no

OCAMLBLDFLAGS = lablgtk.cma  xml-light.cma gtkInit.cmo
OCAMLNLDFLAGS = lablgtk.cmxa xml-light.cmxa gtkInit.cmx gtkThread.cmx

include $(OCAMLMAKEFILE)
