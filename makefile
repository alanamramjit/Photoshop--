OBJS = parser.cmo scanner.cmo pmmc.cmo
 
calc : $(OBJS)
	ocamlc -o pmmc $(OBJS)

scanner.ml : scanner.mll
 ocamllex scanner.mll

parser.ml parser.mli : parser.mly
	ocamlyacc parser.mly

%.cmo : %.ml
	ocamlc -c $<

%.cmi : %.mli
	ocamlc -c $<
	
.PHONY : clean
clean :
	rm -f pmmc parser.ml parser.mli scanner.ml *.cmo *.cmi
