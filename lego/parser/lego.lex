// CISC422, Winter 2004, Assignment 1, Juergen Dingel.
// Definition file of Lego for lexer generator.
// Generate parser with 
//	>> java JLex.Main lego.lex

package lego.parser;

import java.io.*;
import java_cup.runtime.Symbol;  // definition of scanner/parser interface

class LegoLex {
    // reads from System.in and produces token on System.out
    // invoke with "lego.parser.LegoLex < f"
    public static void main(String argv[]) throws java.io.IOException {
	try {
	    lexer theLexer = new lexer(System.in);
	    Symbol s = theLexer.next_token();
	    while (s.sym != sym.EOF) {
		System.out.println("Token: "+Utility.symToString(s.sym)+
				   "("+s.sym+") "+s.value);
		s = theLexer.next_token();
	    }
	    System.out.println("Token: "+Utility.symToString(s.sym)+
			       "("+s.sym+") "+s.value);
	}
	catch (IOException e) {
	    System.out.println("I/O error occurred while reading from stdin");
	    System.exit(1);
	} // end try/catch
    }
}

/* semantic value of token returned by scanner */
class TokenValue {          
    public String text;
    public int lineBegin;
    public int charBegin;
    public int charEnd;
    public String filename;   

    TokenValue() {
    }

    TokenValue(String text, int lineBegin, int charBegin, int charEnd) {
	this.text = text; 
	this.lineBegin = lineBegin; 
	this.charBegin = charBegin;
	this.charEnd = charEnd;
	this.filename = null;
    }

   // some functions to convert the value
   public String toString() { 
     return text;
   }
   
   public int toInt() {
       if (text.equals("MAX"))
	   return Integer.MAX_VALUE;
       return Integer.valueOf(text).intValue();
   }
} // TokenValue

/* some useful helper functions */
class Utility {

    public static int findKeyWord(String str) {
      if (str.equals("forall")) return sym.T_FORALL;
      else if (str.equals("exists")) return sym.T_EXISTS;
      else if (str.equals("Int")) return sym.T_INT;
      else if (str.equals("mod")) return sym.T_MOD;
      else if (str.equals("MAX")) return sym.T_INT;
      else return sym.T_IDENTIFER;
    }

 static public String symToString(int i) {
        switch (i) {
	case sym.T_IDENTIFER : return "IDENTIFER";

	case sym.T_PLUS : return "PLUS";
	case sym.T_MINUS : return "MINUS";
	case sym.T_DIVIDE : return "DIVIDE";
	case sym.T_TIMES : return "TIMES";
	case sym.T_MOD : return "MOD";

	case sym.T_GREATER : return "GREATER";
	case sym.T_GREATEREQ : return "GREATEREQ";
	case sym.T_EQ : return "EQ";

	case sym.T_NOT : return "NOT";
	case sym.T_AND : return "AND";
	case sym.T_OR : return "OR";
	case sym.T_IMPLIES : return "IMPLIES";
	case sym.T_EQUIV : return "EQUIV";
	case sym.T_FORALL : return "FORALL";
	case sym.T_EXISTS : return "EXISTS";

	case sym.T_INT : return "INT";
	case sym.T_LPAREN : return "LPAREN";
	case sym.T_RPAREN : return "RPAREN";
	case sym.T_LSQBRACE: return "LSQBRACE";
	case sym.T_RSQBRACE: return "RSQBRACE";
	case sym.T_DOT: return "DOT";
	case sym.T_COLON: return "COLON";

	case sym.T_ERROR: return "ERROR";
	case sym.EOF: return "EOF";
	case sym.T_EOF: return "EOF";
        default: return "unknown token";
        }
    } 

 // public static void assert( boolean expr ) { 
 // if (false == expr) {
 //	  throw (new Error("Error: Assertion failed."));
 //	}
 // }
  
  private static final String errorMsg[] = {
    "Error: Illegal character."
  };

  public static final int E_UNMATCHED = 0; 

  public static void error( int code ) {
      System.out.println(errorMsg[code]);
  }
} // Utility

%%
%class lexer
%cup

// Value returned on EOF should be special value defined by CUP
%eofval{
    return (new Symbol(sym.EOF, yychar, yychar, (new TokenValue(null,yyline,yychar,yychar))));
%eofval}

%{
    public String sourceFilename;
%}
%line
%char

ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
WHITE_SPACE_CHAR=[\n\ \t\b\012]

%% 

<YYINITIAL> ":"		{ return (new Symbol(sym.T_COLON, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> "("		{ return (new Symbol(sym.T_LPAREN, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> ")"		{ return (new Symbol(sym.T_RPAREN, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> "["		{ return (new Symbol(sym.T_LSQBRACE, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> "]"		{ return (new Symbol(sym.T_RSQBRACE, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> "."		{ return (new Symbol(sym.T_DOT, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> "+"		{ return (new Symbol(sym.T_PLUS, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> "-"		{ return (new Symbol(sym.T_MINUS, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> "*"		{ return (new Symbol(sym.T_TIMES, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> "/"		{ return (new Symbol(sym.T_DIVIDE, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> "="		{ return (new Symbol(sym.T_EQ, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> ">"		{ return (new Symbol(sym.T_GREATER, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> ">="	{ return (new Symbol(sym.T_GREATEREQ, yychar, yychar+2, new TokenValue(yytext(), yyline, yychar, yychar+2))); }
<YYINITIAL> "!"		{ return (new Symbol(sym.T_NOT, yychar, yychar+1, new TokenValue(yytext(), yyline, yychar, yychar+1))); }
<YYINITIAL> "&&"	{ return (new Symbol(sym.T_AND, yychar, yychar+2, new TokenValue(yytext(), yyline, yychar, yychar+2))); }
<YYINITIAL> "||"	{ return (new Symbol(sym.T_OR, yychar, yychar+2, new TokenValue(yytext(), yyline, yychar, yychar+2))); }
<YYINITIAL> "->"	{ return (new Symbol(sym.T_IMPLIES, yychar, yychar+2, new TokenValue(yytext(), yyline, yychar, yychar+2))); }
<YYINITIAL> "<->"	{ return (new Symbol(sym.T_EQUIV, yychar, yychar+3, new TokenValue(yytext(), yyline, yychar, yychar+3))); }

<YYINITIAL>{NONNEWLINE_WHITE_SPACE_CHAR}+ {}

<YYINITIAL> {DIGIT}+ { 
        String s = new String(yytext()); 
	return (new Symbol(sym.T_INT, yychar, yychar+s.length(), 
	          new TokenValue(s, yyline, yychar, yychar + s.length()))); }

<YYINITIAL> "-"{DIGIT}+ { 
        String s = new String(yytext()); 
	return (new Symbol(sym.T_INT, yychar, yychar+s.length(), 
	          new TokenValue(s, yyline, yychar, yychar + s.length()))); }

<YYINITIAL> {ALPHA}+ {
        String str = yytext();
        int sym = Utility.findKeyWord(str);
	return (new Symbol(sym, yychar, yychar+yytext().length(),
	       new TokenValue(yytext(), yyline, yychar, yychar + yytext().length()))); }

<YYINITIAL> {ALPHA}({ALPHA}|{DIGIT}|_)* {
	return (new Symbol(sym.T_IDENTIFER, yychar, yychar+yytext().length(),
			   new TokenValue(yytext(), yyline, yychar, 
					yychar + yytext().length()))); }
					
<YYINITIAL> . {
        System.out.println("Illegal character: <" + yytext() + ">");
	Utility.error(Utility.E_UNMATCHED); }




