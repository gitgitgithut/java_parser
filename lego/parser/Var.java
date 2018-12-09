package lego.parser;

public class Var extends Exp {
    public String s;
    public Var(String s) {
	this.s = s;
    }
    public String toString() {
	return s;
    }
} // public class Var extends Exp

