From: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] overriding tables via initramfs in 2.6.1
Date: Mon, 19 Jan 2004 03:43:32 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Law11-F41tPGmYMUBsS0003da22@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_1676_3913_1377"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_1676_3913_1377
Content-Type: text/plain; format=flowed

Hello people,
I wrote a little patch to override multiple tables.
I ended up having to do this, because the DSDT patch out there wasn't enough 
- I wanted to modify the FACP table as well, so that throttling would work, 
as well as C3.
The patch is a patchwork of what I know about kernel programming and what 
I've seen around. It seems to be working fine (at least on my machine), but 
I can't guarantee anything.

First, here's a quickstart of how to use it:
1) make a directory - $DIR
2) cp $YOUR_INITRD_IMAGE $DIR/initrd.image
3) copy any table that you wish to replace into $DIR, and make sure that it 
is named according to it's signature; that is - if you want to change your 
DSDT, then make sure that the file you put in $DIR is named DSDT (all 
uppercase).
4) create a file $DIR/list that will contain a listing of all the files in 
$DIR (excluding "list"), each entry on a single line
5) cpio -o -c < list > new.cpio
6) gzip -9 new.cpio
7) cp new.cpio.gz /boot
8) now you use the new.cpio.gz as the initrd image that is passed to the 
boot loader (yep, that's it)

This works, and you get to keep your initrd image as well. This is because 
of the handling of the file passed off to the kernel _as_ the initrd image. 
It checks if it is a CPIO archive, and if it is, then it is unpacked onto 
the filesystem (rootfs). If it were the standard initrd image, then it would 
be copied to "/initrd.image", and later on used for inital mounts. In a 
nutshell, the initrd mounting code expects "/initrd.image", so using that 
little trick we are providing it.
However, in our CPIO archive we also have tables that we wish to override; 
they also will be created as files under "/", and later be used by the code 
I added to "drivers/acpi/osl.c". Whenever the ACPI subsystem(?) asks the OS 
whether it wants to override a particular table, the added code checks 
whether a file exists in "/" named as the signature of the table; if it 
exists, then the file is loaded into memory, then unlinked, and the table is 
returned to the ACPI subsystem.

Some catche/s:
If you start messing arround with the CPIO archive that resides in 
$KERNEL/usr, then you might get burned - it took me a while to figure out 
what is going on: the default archive created therre contains the entries 
"/dev", "/dev/console", and "/root". Apparently, that is the only way they 
are created, and the initrd code depends on it indirectly (it assumes "/dev" 
exists).

Well, hope this proves useful to someone.

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

------=_NextPart_000_1676_3913_1377
Content-Type: application/octet-stream; name="acpi-table-override-patch-20040119.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpi-table-override-patch-20040119.diff"

ZGlmZiAtTnJ1IGxpbnV4LTIuNi4xLm9yaWcvZHJpdmVycy9hY3BpL29zbC5j
IGxpbnV4LTIuNi4xL2RyaXZlcnMvYWNwaS9vc2wuYwotLS0gbGludXgtMi42
LjEub3JpZy9kcml2ZXJzL2FjcGkvb3NsLmMJMjAwNC0wMS0wOSAwMTo1OTo1
Ni4wMDAwMDAwMDAgLTA1MDAKKysrIGxpbnV4LTIuNi4xL2RyaXZlcnMvYWNw
aS9vc2wuYwkyMDA0LTAxLTE4IDIyOjQ0OjA2LjI0NDIyNTA5NiAtMDUwMApA
QCAtNDMsNiArNDMsMTMgQEAKIAogI2luY2x1ZGUgPGxpbnV4L2VmaS5oPgog
CisjaW5jbHVkZSA8bGludXgvZnMuaD4KKyNpbmNsdWRlIDxsaW51eC91bmlz
dGQuaD4KK2FzbWxpbmthZ2UgbG9uZyBzeXNfdW5saW5rKGNvbnN0IGNoYXIg
Km5hbWUpOworYXNtbGlua2FnZSBsb25nIHN5c19uZXdzdGF0KGNoYXIgKiBm
aWxlbmFtZSwgc3RydWN0IHN0YXQgKiBzdGF0YnVmKTsKK2FzbWxpbmthZ2Ug
bG9uZyBzeXNfcmVhZChpbnQgZmQsIHZvaWQgKiBidWYsIHNpemVfdCBjb3Vu
dCk7CisKKwogCiAjZGVmaW5lIF9DT01QT05FTlQJCUFDUElfT1NfU0VSVklD
RVMKIEFDUElfTU9EVUxFX05BTUUJKCJvc2wiKQpAQCAtMjI2LDEwICsyMzMs
NTYgQEAKIGFjcGlfb3NfdGFibGVfb3ZlcnJpZGUgKHN0cnVjdCBhY3BpX3Rh
YmxlX2hlYWRlciAqZXhpc3RpbmdfdGFibGUsCiAJCQlzdHJ1Y3QgYWNwaV90
YWJsZV9oZWFkZXIgKipuZXdfdGFibGUpCiB7CisJY2hhciBmaWxlX25hbWVb
Nl07CisJaW50IGZkOworCisKIAlpZiAoIWV4aXN0aW5nX3RhYmxlIHx8ICFu
ZXdfdGFibGUpCiAJCXJldHVybiBBRV9CQURfUEFSQU1FVEVSOwogCisKIAkq
bmV3X3RhYmxlID0gTlVMTDsKKwkvLyBjb3B5IHRoZSB0YWJsZSdzIG5hbWUK
KwlmaWxlX25hbWVbMF0gPSAnLyc7CisJbWVtY3B5KGZpbGVfbmFtZSsxLCBl
eGlzdGluZ190YWJsZSwgNCk7CisJZmlsZV9uYW1lWzVdID0gMDsKKwlwcmlu
dGsoS0VSTl9OT1RJQ0UgImxvb2tpbmcgZm9yIHRhYmxlIHJlcGxhY2VtZW50
OiAlc1xuIiwgZmlsZV9uYW1lKzEpOworCS8vIGF0dGVtcHQgdG8gb3BlbiB0
aGUgZmlsZQorCWZkID0gc3lzX29wZW4oZmlsZV9uYW1lLCBPX1JET05MWSwg
NzAwKTsKKwlpZiAoZmQ+PTApCisJeworCQlzdHJ1Y3Qgc3RhdCBzdDsKKwkJ
aW50IHJldDsKKworCisJCS8vIGZpbmQgb3V0IHRoZSBzaXplCisJCXJldCA9
IHN5c19uZXdzdGF0KGZpbGVfbmFtZSwgJnN0KTsKKwkJaWYgKHJldD09MCkK
KwkJeworCQkJLy8gYWxsb2NhdGUgc3BhY2UgZm9yIHRoZSB0YWJsZQorCQkJ
Km5ld190YWJsZSA9IGttYWxsb2Moc3Quc3Rfc2l6ZSwgR0ZQX0FUT01JQyk7
CisJCQlpZiAoKm5ld190YWJsZSE9TlVMTCkKKwkJCXsKKwkJCQkvLyByZWFk
IGluIHRoZSB0YWJsZQorCQkJCXJldCA9IHN5c19yZWFkKGZkLCAqbmV3X3Rh
YmxlLCBzdC5zdF9zaXplKTsKKwkJCQlpZiAocmV0PT1zdC5zdF9zaXplKQor
CQkJCXsKKwkJCQkJcHJpbnRrKEtFUk5fTk9USUNFICJTdWNjc2Vzc2Z1bHkg
bG9hZGVkIHRhYmxlICVzIHdpdGggJWQgYnl0ZXNcbiIsIGZpbGVfbmFtZSsx
LCAoaW50KXN0LnN0X3NpemUpOworCQkJCQlnb3RvIHRhYmxlX292ZXJyaWRl
X3N1Y2Nlc3M7CisJCQkJfQorCQkJCWVsc2UgcHJpbnRrKEtFUk5fRVJSICJm
YWlsZWQgdG8gcmVhZCgpOyByZXN1bHQgLSAlZFxuIiwgcmV0KTsKKwkJCQlr
ZnJlZSgqbmV3X3RhYmxlKTsKKwkJCQkqbmV3X3RhYmxlID0gTlVMTDsKKwkJ
CX0KKwkJCWVsc2UgcHJpbnRrKEtFUk5fRVJSICJmYWlsZWQgdG8ga21hbGxv
YygpICVkIGJ5dGVzXG4iLCAoaW50KXN0LnN0X3NpemUpOworCQl9CisJCWVs
c2UgcHJpbnRrKEtFUk5fRVJSICJmYWlsZWQgdG8gc3RhdCAlc1xuIiwgZmls
ZV9uYW1lKTsKK3RhYmxlX292ZXJyaWRlX3N1Y2Nlc3M6CisJCXN5c19jbG9z
ZShmZCk7CisJCXN5c191bmxpbmsoZmlsZV9uYW1lKTsKKwl9CisJZWxzZSBw
cmludGsoS0VSTl9JTkZPICJubyByZXBsYWNlbWVudCBmb3IgdGFibGUgJXNc
biIsIGZpbGVfbmFtZSsxKTsKKwogCXJldHVybiBBRV9PSzsKIH0KIAo=


------=_NextPart_000_1676_3913_1377--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
