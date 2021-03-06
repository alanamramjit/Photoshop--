OBJS = parser.cmo scanner.cmo ast.cmo codegen.cmo semantic.cmo pmmc.cmo
 
pmmc: $(OBJS)
	ocamlc -o gen $(OBJS)

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
	rm -f parser.ml *.class *.java gen parser.mli scanner.ml *.cmo *.cmi

ast.cmo:
ast.cmx:
pmmc.cmo: scanner.cmo parser.cmi ast.cmo codegen.cmo semantic.cmo
pmmc.cmx: scanner.cmx parser.cmx ast.cmx codegen.cmx semantic.cmx
parser.cmo: ast.cmo parser.cmi
parser.cmx: ast.cmx parser.cmi
scanner.cmo: parser.cmi
scanner.cmx: parser.cmx
parser.cmi: ast.cmo
