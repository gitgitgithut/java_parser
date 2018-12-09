package lego.parser;

public class Domain {
    public Int from;
    public Int to;
    public Domain (Int f, Int t) {
	from = f;
	to = t;
    }
    public String toString () {
	String fromStr = from.toString();
	String toStr = to.toString();
	return "["+fromStr+".."+toStr+"]";
    }
} // public class Domain


