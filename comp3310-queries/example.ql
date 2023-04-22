/**
 * @name Comp3310 workshop 6 query
 * @kind problem
 * @problem.severity warning
 * @id java/example/empty-block
 */

import java

predicate getMessageResult(MethodAccess ma, string message) {
  exists(MethodAccess printlnCall, MethodAccess getMessageCall |
    ma = printlnCall and
    printlnCall.getMethod().hasName("println") and
    printlnCall.getMethod().getDeclaringType().hasQualifiedName("java.io", "PrintStream") and
    getMessageCall.getMethod().hasName("getMessage") and
    getMessageCall.getMethod().getDeclaringType().getASupertype*().hasQualifiedName("java.lang", "Throwable") and
    printlnCall.getAnArgument().getAChildExpr*() = getMessageCall
  )
  and message = "Method access to printing getMessage() of a Throwable object."
}

predicate printStackTraceResult(MethodAccess ma, string message) {
  ma.getMethod().getDeclaringType().hasQualifiedName("java.lang", "Throwable") and
  ma.getMethod().hasName("printStackTrace") and
  ma.getNumArgument() = 0 and
  message = "Method access to printStackTrace() of a Throwable object."
}

from MethodAccess ma, string message
where printStackTraceResult(ma, message) or getMessageResult(ma, message)
select ma, message

