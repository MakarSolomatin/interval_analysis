function cnd = mincond( A, testcnt )
  cnd = -1
  if size(A)(1) == 3
      for i1=inf(A(1,1)):(sup(A(1,1))-inf(A(1,1))) / testcnt:sup(A(1,1))
          for i2=inf(A(1,2)):(sup(A(1,2))-inf(A(1,2))) / testcnt:sup(A(1,2))
              for j1=inf(A(2,1)):(sup(A(2,1))-inf(A(2,1))) / testcnt:sup(A(2,1))
                  for j2=inf(A(2,2)):(sup(A(2,2))-inf(A(2,2))) / testcnt:sup(A(2,2))
                      for k1=inf(A(3,1)):(sup(A(3,1))-inf(A(3,1))) / testcnt:sup(A(3,1))
                          for k2=inf(A(3,2)):(sup(A(3,2))-inf(A(3,2))) / testcnt:sup(A(3,2))
                              cndnew = cond([i1 i2;j1 j2;k1 k2]);
                              if cndnew <= cnd || cnd < 0
                                  cnd = cndnew;
                              end
                          end
                      end
                  end
              end
          end
      end
  end
  if size(A)(1) == 2
      for i1=inf(A(1,1)):(sup(A(1,1))-inf(A(1,1))) / testcnt:sup(A(1,1))
          for i2=inf(A(1,2)):(sup(A(1,2))-inf(A(1,2))) / testcnt:sup(A(1,2))
              for i3=inf(A(1,3)):(sup(A(1,3))-inf(A(1,3))) / testcnt:sup(A(1,3))
                  for j1=inf(A(2,1)):(sup(A(2,1))-inf(A(2,1))) / testcnt:sup(A(2,1))
                         for j2=inf(A(2,2)):(sup(A(2,2))-inf(A(2,2))) / testcnt:sup(A(2,2))
                              for j3=inf(A(2,3)):(sup(A(2,3))- inf(A(2,3))) / testcnt:sup(A(2,3))
                                  cndnew = cond([i1 i2 i3;j1 j2 j3]);
                                  if cndnew <= cnd || cnd < 0
                                      cnd = cndnew;
                                  end
                              end
                         end
                  end
              end
          end
      end
  end
endfunction

