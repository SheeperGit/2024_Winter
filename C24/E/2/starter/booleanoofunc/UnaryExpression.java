package booleanoofunc;

import java.util.Map;
import java.util.function.UnaryOperator;

public abstract class UnaryExpression extends BooleanExpression {
    private UnaryOperator<Boolean> operator;
    protected BooleanExpression operand;

    public UnaryExpression(UnaryOperator<Boolean> operator, BooleanExpression operand) {
        this.operator = operator;
        this.operand = operand;
    }

    @Override
    public boolean evaluate(Map<String, Boolean> context) {
        boolean operandValue = operand.evaluate(context);
        return operator.apply(operandValue);
    }

    @Override
    public BooleanExpression simplify(Map<String, Boolean> context) {
        BooleanExpression simplifiedOperand = operand.simplify(context);
        return simplifyUnaryExpression(operator, simplifiedOperand);
    }

    @Override
    public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
        BooleanExpression simplifiedOperand = operand.simplifyOnce(context);
        return simplifyUnaryExpression(operator, simplifiedOperand);
    }

    private BooleanExpression simplifyUnaryExpression(UnaryOperator<Boolean> op, BooleanExpression operand) {
        return this;
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
          return true;
        }
        if (other == null || getClass() != other.getClass()) {
          return false;
        }
        UnaryExpression that = (UnaryExpression) other;
        return operand.equals(that.operand);
    }

    @Override
    public String toString() {
        return String.format("(%s %s)", toStringOp(), operand.toString());
    }

    protected abstract String toStringOp();

    protected BooleanExpression getOperand() {
        return operand;
    }

    protected UnaryOperator<Boolean> getOperator() {
        return operator;
    }
}
