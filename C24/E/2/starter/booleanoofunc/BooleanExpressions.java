package booleanoofunc;

import java.util.List;
import java.util.Map;
import java.util.function.BiFunction;
import java.util.stream.Collectors;

/**
 * Working on lists of BooleanExpression's.
 */
public abstract class BooleanExpressions {

    public abstract boolean evaluate(Map<String, Boolean> context);
    public abstract BooleanExpression simplify(Map<String, Boolean> context);
    public abstract BooleanExpression simplifyOnce(Map<String, Boolean> context);
    public abstract boolean equals(Object other);
    public abstract String toString();

    /**
     * Evaluate each BooleanExpression under context and return a List of the results.
     *
     * @param expressions a List of BooleanExpressions to evaluate
     * @param context     truth assignment for all variables in expressions
     * @return a list of the results of evaluating all expressions
     */
    public static List<Boolean> evaluateAll(List<BooleanExpression> expressions,
                                             Map<String, Boolean> context) {
        return expressions.stream()
                .map(expr -> expr.evaluate(context))
                .collect(Collectors.toList());  // Alternative to just a simple `toList()` //
    }

    /**
     * Evaluate each BooleanExpression under context and return the conjunction of
     * the results.
     *
     * @param expressions a List of BooleanExpressions to evaluate
     * @param context     truth assignment for all variables in expressions
     * @return conjunction of the results of evaluating all expressions
     */
    public static Boolean evaluateAndReduce(List<BooleanExpression> expressions,
                                             Map<String, Boolean> context) {
        return expressions.stream()
                .map(expr -> expr.evaluate(context))
                .reduce(true, (acc, val) -> acc && val);
    }

    /**
     * Evaluate each BooleanExpression under context and return the conjunction of
     * the results.
     *
     * @param expressions a List of BooleanExpressions to evaluate
     * @param context     truth assignment for all variables in expressions
     * @return conjunction of the results of evaluating all expressions
     */
    public static Boolean evaluateAndMapReduce(List<BooleanExpression> expressions,
                                                Map<String, Boolean> context) {
        return expressions.stream()
                .map(expr -> expr.evaluate(context))
                .reduce(true, Boolean::logicalAnd);
    }

    /**
     * Evaluate each BooleanExpression under context and return the disjunction of
     * the results.
     *
     * @param expressions a List of BooleanExpressions to evaluate
     * @param context     truth assignment for all variables in expressions
     * @return disjunction of the results of evaluating all expressions
     */
    public static Boolean evaluateOrMapReduce(List<BooleanExpression> expressions,
                                               Map<String, Boolean> context) {
        return expressions.stream()
                .map(expr -> expr.evaluate(context))
                .reduce(false, Boolean::logicalOr);
    }

    /**
     * Evaluate each BooleanExpression under context and return the reduction of
     * the results using the reduction function func and the identity element identity.
     *
     * @param expressions a List of BooleanExpressions to evaluate
     * @param context     truth assignment for all variables in expressions
     * @return reduction using func and identity of the results of evaluating all expressions
     */
    public static Boolean evaluateMapReduce(BiFunction<Boolean, Boolean, Boolean> func,
                                            Boolean identity, List<BooleanExpression> expressions,
                                            Map<String, Boolean> context) {
        return expressions.stream()
        .map(expr -> expr.evaluate(context))
        .reduce(identity, (acc, val) -> func.apply(acc, val)); 
    }
}
