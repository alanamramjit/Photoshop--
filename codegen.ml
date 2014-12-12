open Printf

let file = "out.c"      

let translate =
        let oc = open_out file in 
               fprintf oc              
"
#include <stdlib.h>
#include <stdio.h>
#include <SDL.h>

int main(){
    
                ";
                 close_out oc;


