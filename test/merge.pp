define testcase($one = "", $two = "", $expect = "") {
     $got = properties_merge($one, $two)
     if $got != $expect {
       notice( "FAILED ${name}: '${got}' != '${expect}'" )
     }
     else {
       notice( "OK ${name}" )
     }
}

testcase { "merge_with_nothing":
   one    => "ONE_PROPERTY      'one'",
   expect => "ONE_PROPERTY      'one'\n",
}

testcase { "append perl style":
  one    => "ONE_PROPERTY      'one'",
  two    => "SECOND_PROPERTY 'two'",
  expect => "ONE_PROPERTY      'one'\nSECOND_PROPERTY 'two'\n",
}

testcase { "override perl style":
  one    => "ONE_PROPERTY      'one'",
  two    => "ONE_PROPERTY 'two'",
  expect => "ONE_PROPERTY 'two'\n",
}

testcase { "append java style":
  one => "foo.bar=one\n",
  two => "foo.baz=two\n",
  expect => "foo.bar=one\nfoo.baz=two\n"
}

testcase { "override java style":
  one => "foo.bar=one\n",
  two => "foo.bar=two\n",
  expect => "foo.bar=two\n",
}
