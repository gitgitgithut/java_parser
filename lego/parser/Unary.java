package lego.parser;

public class Unary extends Formula {
    public String unary_conn;
    public Formula f;
    public Unary(String uc, Formula f) {
	this.unary_conn = uc;
	this.f = f;
    }
    public String toString() {
	String fStr = f.toString();
	return unary_conn+"("+fStr+")";
    }
} // public class Unary extends Formula

