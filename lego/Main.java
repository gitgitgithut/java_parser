// CISC422, Assignment 1, Juergen Dingel
// Top-level program for parsing and evaluation of Lego formulas
// From command line, invoke with e.g., "java lego.Main lego/formulas/f1"
package lego;

import lego.parser.*;

public class Main {

    public static void main(String argv[]) throws java.lang.Exception {
	if (java.lang.reflect.Array.getLength(argv) == 0) {
	    System.out.println("Error: No file name provided. Terminating\n" );
	    // System.exit(1);
	}
	else {
          String fn = argv[0];
	    try {
		// parse formula
		Formula f = Parse.parse(fn);
		// print formula
		System.out.println("Here's the formula:");
		System.out.println(f.toString());
		// evaluate formula
		System.out.println("Here's its value:");
		System.out.println(Eval.eval(f));
	    }
	    catch (java.lang.Exception e) {
		System.out.println("Error: Content of file "+fn+" syntactically incorrect. Terminating");
		// System.exit(1);
	    }
	}
    }
} // class Main

