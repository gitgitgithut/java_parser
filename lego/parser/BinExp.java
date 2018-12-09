package lego.parser;

public class BinExp extends Exp {
    public String bin_op;
    public Exp e1;
    public Exp e2;
    public BinExp(String bin_op, Exp e1, Exp e2) {
	this.bin_op = bin_op;
	this.e1 = e1;
	this.e2 = e2;
    }
    public String toString() {
	String e1Str = e1.toString();
	String e2Str = e2.toString();
	return "("+e1Str+" "+bin_op+" "+e2Str+")";
    }
} // public class BinExp extends Exp
