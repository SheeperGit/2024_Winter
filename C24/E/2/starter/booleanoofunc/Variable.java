package booleanoofunc;

import java.util.Map;

public class Variable extends BooleanExpression {
    private String id;

    public Variable(String id) {
        this.id = id;
    }

    @Override
    public boolean evaluate(Map<String, Boolean> context) {
        return context.getOrDefault(id, false); // Might break testing. Who knows? :3 //
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
        Variable variable = (Variable) other;
        return id.equals(variable.id);
    }

    @Override
    public String toString() {
        return id;
    }
}
