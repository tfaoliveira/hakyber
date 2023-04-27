.PHONY: libkyber768_avx2.a clean distclean

libkyber768_avx2.a: jkem.s
	$(CC) $(CFLAGS) -c jkem.s
	$(AR) -r $@ jkem.o

.PHONY: jkem.s
jkem.s: jkem.jazz
	jasminc -nowarning -lea $< -o $@

clean:
	rm -f *.o *.a

distclean: clean
	rm -f *.s
