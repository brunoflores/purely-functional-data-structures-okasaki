fun test_1 _ =
  let val l1 = [1, 2, 3]
      val l2 = [4, 5]
  in List'.++ l1 l2; print "OK: test_1\n"; () end;

print "begin\n";
test_1 ();
