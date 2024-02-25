package booleanoo;

import java.util.Map;
import booleanoo.operators.Not;

/**
 * A unary negation.
 */
public class Negation extends UnaryExpression {
    public Negation(BooleanExpression op) {
        super(new Not(), op);
    }

    @Override
    public BooleanExpression simplify(Map<String, Boolean> context) {
        BooleanExpression simplifiedOperand = operand.simplify(context);
        return new Negation(simplifiedOperand);
    }

    @Override
    public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
        if (operand instanceof Negation) {
            // (not (not x)) == x //
            return ((Negation) operand).getOperand().simplify(context);
        }
        return new Negation(operand.simplify(context));
    }

    @Override
    protected boolean applyOperator(boolean operandValue) {
        return !operandValue;
    }
}
