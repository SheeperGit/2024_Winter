package booleanoofunc;

import java.util.Map;

public class BooleanValue extends BooleanExpression {
    private boolean value;

    public BooleanValue(boolean val) {
        this.value = val;
    }

    @Override
    public boolean evaluate(Map<String, Boolean> context) {
        return value;
    }

    @Override
    public BooleanExpression simplify(Map<String, Boolean> context) {
        return this;
    }

    @Override
    public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
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
        
        BooleanValue that = (BooleanValue) other;
        return value == that.value;
    }

    @Override
    public String toString() {
        return Boolean.toString(value);
    }
}
