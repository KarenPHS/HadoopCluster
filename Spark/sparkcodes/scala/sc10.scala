// Maps
val m = Map("one" -> 1, "two" -> 2 )

m("one")

m("two") + 3

val nestedmap = Map("one" -> Map("s1" -> "sub1",
                                 "s2" -> "sub2"
                                )
                    )

nestedmap("one")

nestedmap("one")("s2")
