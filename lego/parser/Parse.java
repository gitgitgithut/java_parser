package lego.parser;

import java.io.*;
import java_cup.runtime.*;

public class Parse {
    // set this flag if you want the parser to print debugging info
    static final boolean do_debug_parse = false;

    public static Formula parse(String fn) throws java.lang.Exception {
        System.out.println("Reading formula from file "+fn);
        try {
	    // create buffered reader object to read text file
            BufferedReader in = new BufferedReader(new FileReader(fn));
            // create parsing object
            lexer theLexer = new lexer(in);
            parser theParser = new parser(theLexer);
            // parse result is of type Symbol declared in java_cup/runtime/Symbol.java
            Symbol parse_result = null;
            if (do_debug_parse)
                parse_result = theParser.debug_parse();
            else
                parse_result = theParser.parse();
            Formula formula = (Formula) (parse_result.value);
            return formula;
        }
        catch (IOException e) {
            System.out.println("Error: Couldn't read from file " + fn+". Terminating");
            System.exit(1);
            return null;
        } // end try/catch
    }
} // class Parse
