package lego.parser;

public class Int extends Exp {
    public Integer n;
    public Int(Integer n) {
	this.n = n;
    }
    public String toString() {
	return n.toString();
    }
} // public class Int extends Exp
