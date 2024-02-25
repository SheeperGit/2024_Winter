package booleanoo;

import java.util.Map;
import booleanoo.operators.UnaryOperator;

/**
 * A unary boolean expression.
 */
public abstract class UnaryExpression extends BooleanExpression {
    protected UnaryOperator operator;
    protected BooleanExpression operand;

    public UnaryExpression(UnaryOperator operator, BooleanExpression operand) {
        this.operator = operator;
        this.operand = operand;
    }

    public final BooleanExpression getOperand() {
        return operand;
    }

    public final UnaryOperator getOperator() {
        return operator;
    }

    @Override
    public boolean evaluate(Map<String, Boolean> context) {
        boolean operandValue = operand.evaluate(context);
        return applyOperator(operandValue);
    }

    protected abstract boolean applyOperator(boolean operandValue);

    @Override
    public boolean equals(Object other) {
        if (other == null || getClass() != other.getClass()){
          return false;
        }
        UnaryExpression otherExpr = (UnaryExpression) other;
        return operator.equals(otherExpr.operator) && operand.equals(otherExpr.operand);
    }

    @Override
    public String toString() {
        return String.format("(%s %s)", operator, operand);
    }
}
