let filename = Sys.argv.(1) in
        let lexbuf = Lexing.from_channel (open_in filename) in
        let src = Parser.program Scanner.token lexbuf in
        print_string (Ast.program_string src)
