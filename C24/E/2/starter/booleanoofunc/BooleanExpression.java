package booleanoofunc;

import java.util.Map;

/**
 * A boolean expression: the top of our hierarchy.
 */
public abstract class BooleanExpression {
    public abstract boolean evaluate(Map<String, Boolean> context);
    public abstract BooleanExpression simplify(Map<String, Boolean> context);
    public abstract BooleanExpression simplifyOnce(Map<String, Boolean> context);
    public abstract boolean equals(Object other);
    public abstract String toString();
}
