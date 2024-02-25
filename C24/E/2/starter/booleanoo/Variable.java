package booleanoo;
import java.util.Map;

/**
 * A boolean-valued variable.
 */
public class Variable extends BooleanExpression {
    private String id;

    public Variable(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    @Override
    public boolean evaluate(Map<String, Boolean> context) {
        return context.getOrDefault(id, false); // idk if this isn't allowed, but I don't want evaluate to break if a var is unassigned... //
    }

    @Override
    public BooleanExpression simplify(Map<String, Boolean> context) {
        return this;  // Boolean variables simplify to themselves //
    }

    @Override
    public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
        return this;  // Boolean variables simplify to themselves //
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
          return true;
        }
        if (!(other instanceof Variable)) {
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
