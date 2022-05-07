structure Driver = struct
  fun test_1 _ =
    let val l1 = [1, 2, 3]
        val l2 = [4, 5]
    in List'.++ l1 l2; print "OK: test_1\n"; () end

  fun test_2 _ =
    (* Exercise 2.1 *)
    let fun suffixes []                     = [[]]
          | suffixes (matched as [x])       = [matched, []]
          | suffixes (matched as (x :: xs)) = matched :: (suffixes xs)
        val l1 = [1, 2, 3]
    in suffixes l1; print "OK: test_2\n"; () end

  fun test_3 _ =
    let val l1 = CustomStack.cons (1, (CustomStack.cons (2, (CustomStack.cons (3, CustomStack.empty)))))
        val l2 = CustomStack.cons (4, CustomStack.empty)
    in CustomStack.++ l1 l2; print "OK: test_3\n"; () end

  fun main (prog_name, args) =
    let val _ = test_1 ()
        val _ = test_2 ()
        val _ = test_3 ()
    in 0 end
end
