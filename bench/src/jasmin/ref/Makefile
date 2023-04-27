.PHONY: libkyber768_ref.a clean distclean

libkyber768_ref.a: jkem.s
	$(CC) $(CFLAGS) -c jkem.s
	$(AR) -r $@ jkem.o

.PHONY: jkem.s
jkem.s: jkem.jazz
	jasminc -nowarning $< -o $@

clean:
	rm -f *.o *.a

distclean: clean
	rm -f *.s
