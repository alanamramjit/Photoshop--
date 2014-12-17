let filename = Sys.argv.(1) in
	let lexbuf = Lexing.from_channel (open_in filename) in
		let src = Parser.program Scanner.token lexbuf in
        	let string_split = Ast.program_string_split src in
        		ignore(Semantic.check_program src);
        		Codegen.generate_code string_split