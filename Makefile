PREFIX = $(DESTDIR)/usr

.PHONY : clean dist deb

dist: names.txt.gz dict_en.dat.gz manual.html
	python setup.py sdist

deb: dist
	debuild -us -uc -b

names.txt.gz: names.txt
	gzip -c names.txt > names.txt.gz

dict_en.dat.gz: dict_en.dat
	gzip -c dict_en.dat > dict_en.dat.gz

manual.html: doc/*
	make -C doc && mv doc/manual.html .

rpm: dist
	python setup.py bdist_rpm

clean:
	rm -f bin/*.pyc src/*.pyc tests/*.pyc names.txt.gz dict_en.dat.gz manual.html MANIFEST
	rm -rf build dist
	dh_clean

install: dist
	python setup.py install
