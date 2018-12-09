package lego.parser;

public class Quantified extends Formula {
    public String quant;
    public Var var;
    public Domain dom;
    public Formula f;
    public Quantified(String q, Var v, Domain d, Formula f) {
	this.quant = q;
	this.var = v;
	this.dom = d;
	this.f = f;
    }
    public String toString() {
	String varStr = var.toString();
	String domStr = dom.toString();
	String fStr = f.toString();
	return "("+quant+" "+varStr+":"+domStr+" . "+fStr+")";
    }
} // public class Quantified extends Formula

