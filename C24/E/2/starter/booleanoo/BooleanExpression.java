package booleanoo;
import java.util.Map;

/**
 * A boolean expression: the top of our hierarchy.
 */
abstract public class BooleanExpression {
    abstract public boolean evaluate(Map<String, Boolean> context);
    abstract public BooleanExpression simplify(Map<String, Boolean> context);
    abstract public BooleanExpression simplifyOnce(Map<String, Boolean> context);
    abstract public boolean equals(Object other);
    abstract public String toString();
}
