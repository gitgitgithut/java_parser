package lego.parser;

public class Binary extends Formula {
    public String bin_conn;
    public Formula f1;
    public Formula f2;
    public Binary(String bc, Formula f1, Formula f2) {
	this.bin_conn = bc;
	this.f1 = f1;
	this.f2 = f2;
    }
    public String toString() {
	String f1Str = f1.toString();
	String f2Str = f2.toString();
	return "("+f1Str+" "+bin_conn+" "+f2Str+")";
    }
} // public class Binary extends Formula

