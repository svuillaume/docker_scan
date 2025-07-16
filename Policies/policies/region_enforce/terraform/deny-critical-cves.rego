package policy

violation[{"msg": msg}] {
  input.vulnerabilities[_].severity == "Critical"
  msg := "Image contains critical vulnerabilities"
}

decision = "fail" {
  count(violation) > 0
}

decision = "pass" {
  not decision = "fail"
}
