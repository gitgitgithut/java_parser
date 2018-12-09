// Evaluator for Lego formulas
package lego;

import lego.parser.*;
import java.util.Stack;


// data structure to store values of free variables
class Env {
   public String var;
   public int Vvar;
    public Env(String var, int Vvar){
        this.var = var;
        this.Vvar = Vvar;
    }
}



public class Eval {
    /////////////////////////////////////////////////////////////////
    public static boolean eval(Formula f) throws IllegalArgumentException{
        return eval(f, new Stack<>());
    }
////////////////////////////////////////////////////////////////////////////////
    /*
    @param f:
     */
    public static boolean eval(Formula f, Stack<Env> stack)throws IllegalArgumentException {
        // Atomic Evaluation
        if (f instanceof Atomic){
            int e1 = exp_eval(((Atomic) f).e1, stack);
            int e2 = exp_eval(((Atomic) f).e2, stack);
            switch (((Atomic) f).rel_op){
                case ">":
                    return e1 > e2;
                case ">=":
                    return e1 >= e2;
                case "=":
                    return e1 == e2;
            }
        }

        //Unary Evaluation
        else if (f instanceof  Unary){
            return !eval(((Unary) f).f, stack);
        }

        // Binary Evaluation
        else if (f instanceof Binary){
            boolean e1 = eval(((Binary) f).f1, stack);
            boolean e2 = eval(((Binary) f).f2, stack);
            switch (((Binary) f).bin_conn){
                case "&&":
                    return e1 && e2;
                case "||":
                    return e1 || e2;
                case "->":
                    return !e1 || e2;
                case "<->":
                    return (e1 && e2) || (!e1 && !e2);
            }
        }

        //Quantified Evaluation
        else if (f instanceof Quantified){
            String var = ((Quantified) f).var.toString();
            int from = exp_eval(((Quantified) f).dom.from, stack);
            int to = exp_eval(((Quantified) f).dom.to, stack);
            int n;
            switch (((Quantified) f).quant){
                case "forall":
                    for (n = from; n <= to; n++){
                        stack.push(new Env(var, n));
                        if (eval(((Quantified) f).f, stack) == false)
                            return false;
                    }
                    return true;
                case "exists":
                    for (n = from; n <= to; n++){
                        stack.push(new Env(var, n));
                        if (eval(((Quantified) f).f, stack) == true)
                            return true;
                    }
                    return false;
            }
            return true;
        }
        throw new IllegalArgumentException("");
    }
    ///////////////////////////////////////////////////////////////////////

    private static int exp_eval(Exp e, Stack<Env> stack) throws IllegalArgumentException{
        //Integer
        if (e instanceof  Int){
            return  ((Int) e).n;
        }

        //BinExp
        else if (e instanceof  BinExp){
            int e1 = exp_eval(((BinExp) e).e1, stack);
            int e2 = exp_eval(((BinExp) e).e2, stack);
            switch(((BinExp) e).bin_op){
                case "+":
                    return e1 + e2;
                case "-":
                    return e1 - e2;
                case "*":
                    return e1 * e2;
                case "/":
                    if (e2 == 0) {
                        System.out.println("Divider is zero");
                        throw new IllegalArgumentException("Divider is zero");
                    }
                    return e1 / e2;
                case "mod":
                    if (e2 == 0){
                        System.out.println("Modulus is zero");
                        throw new IllegalArgumentException("Modulus is zero");
                    }
                    return e1 % e2;
            }
        }

        //Varexp
        else if (e instanceof Var){
            Stack<Env> local = (Stack<Env>) stack.clone();
            while (!local.empty()){
                Env env = local.pop();
                if (((Var) e).s.compareTo(env.var) == 0)
                    return env.Vvar;
            }
            System.out.println("Variable " + ((Var) e).s + " is unbounded");
            throw new IllegalArgumentException("Variable " + ((Var) e).s + " is unbounded");
        }

        throw new IllegalArgumentException("");
    }


}

