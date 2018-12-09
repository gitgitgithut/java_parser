package lego.parser;

public class Atomic extends Formula {
    public String rel_op;
    public Exp e1;
    public Exp e2;
    public Atomic(String rel_op, Exp e1, Exp e2) {
	this.e1 = e1;
	this.e2 = e2;
	this.rel_op = rel_op;
    }
    public String toString() {
	String e1Str = e1.toString();
	String e2Str = e2.toString();
	return "("+e1Str+" "+rel_op+" "+e2Str+")";
    }
} // public class Atomic extends Formula 
