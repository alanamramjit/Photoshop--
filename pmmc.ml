let filename = (Sys.argv(1)) in
        let lexbuf = Lexing.from_channel (open_in filename) in
        let src = Parser.program Scanner.token lexbuf in
        Ast.check_program src
