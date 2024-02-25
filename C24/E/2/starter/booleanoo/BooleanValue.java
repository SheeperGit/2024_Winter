package booleanoo;
import java.util.Map;

/**
 * A boolean value: true or false.
 */
public class BooleanValue extends BooleanExpression {
    private boolean value;

    public BooleanValue(boolean val) {
        this.value = val;
    }

    @Override
    public String toString() {
        return Boolean.toString(value); // Returns "true" if true, and vice versa //
    }

    @Override
    public boolean equals(Object other) {
        return other != null && other.getClass().equals(BooleanValue.class) && ((BooleanValue) other).value == value;
    }

    @Override
    public boolean evaluate(Map<String, Boolean> context) {
        return value;
    }

    @Override
    public BooleanValue simplify(Map<String, Boolean> context) {
        return this;
    }

    @Override
    public BooleanValue simplifyOnce(Map<String, Boolean> context) {
        return this;
    }
}
