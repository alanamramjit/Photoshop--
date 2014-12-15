OBJS = parser.cmo scanner.cmo ast.cmo pmmc.cmo
 
pmmc: $(OBJS)
	ocamlc -o pmmc $(OBJS)

scanner.ml: scanner.mll
	ocamllex scanner.mll

parser.ml parser.mli: parser.mly
	ocamlyacc parser.mly

%.cmo: %.ml
	ocamlc -w A -c $<

%.cmi: %.mli
	ocamlc -w A -c $<
	
.PHONY: clean
clean:
	rm -f pmmc parser.ml parser.mli scanner.ml *.cmo *.cmi

ast.cmo:
ast.cmx:
pmmc.cmo: scanner.cmo parser.cmi ast.cmo
pmmc.cmx: scanner.cmx parser.cmx ast.cmx
parser.cmo: ast.cmo parser.cmi
parser.cmx: ast.cmx parser.cmi
scanner.cmo: parser.cmi
scanner.cmx: parser.cmx
parser.cmi: ast.cmo
