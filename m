From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: [Patch] DSDT in initrd
Date: Mon, 5 May 2003 22:48:24 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0305052221420.8540@tweety.gaugusch.at>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-88864896-1052166248=:8540"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-ID: <Pine.LNX.4.53.0305052246360.1263-qopfHk9/S+VQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime-oOUblnuQwHKola3qYQ6TW/IULO3mGbRi9nwVQlTi/Pw@public.gmane.org for more info.

--8323584-88864896-1052166248=:8540
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.53.0305052224191.9302-qopfHk9/S+VQK2oVCIMtW7NldLUNz+W/@public.gmane.org>

Hi,
I've implemented my patch to put the DSDT into the initial ramdisk.
It uses the same approach as bootsplash: just use the raw initrd data.

A "magic" signature ("INITRDDSDT123DSDT123") seperates the normal initrd
content from the DSDT. To use it, apply my patch (it's against 2.4.21-rc1
+ acpi-20030424) and do the following:
1.) enable CONFIG_BLK_DEV_INITRD and CONFIG_ACPI_INITRD
2.) recompile
3.) Create the initrd (or modify an existing)

echo "INITRDDSDT123DSDT123" >> /boot/initrd.dsdt
cat DSDT.aml >> /boot/initrd.dsdt

If you don't have an initrd yet, don't worry. Just perform the steps
above and everything will be fine. Don't forget to update your bootloader
(lilo needs this, grub not).

Then reboot.
The message "Looking for DSDT in initrd... found!" should be in your dmesg
after next boot. (for some reason <6> is before "found", but I'm sure
that someone will be able to give me the right pointers to fix that).

This is my first kernel patch, please be gentle :)
But I would really appreciate, if it was applied to official ACPI.

kind regards
Markus Gaugusch
-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \
--8323584-88864896-1052166248=:8540
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=acpi-dsdt-initrd-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0305052243400.1211-qopfHk9/S+VQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=acpi-dsdt-initrd-patch

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9hY3BpL29zbC5jCTIwMDMtMDUtMDUg
MTg6MDA6MjUuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgvZHJpdmVycy9h
Y3BpL29zbC5jCTIwMDMtMDUtMDUgMjE6NTk6MTkuMDAwMDAwMDAwICswMjAw
DQpAQCAtMzMsNiArMzMsMTAgQEANCiAjaW5jbHVkZSA8bGludXgvaW50ZXJy
dXB0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2ttb2QuaD4NCiAjaW5jbHVkZSA8
bGludXgvZGVsYXkuaD4NCisjaWZkZWYgQ09ORklHX0FDUElfSU5JVFJEDQor
I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCisjaW5jbHVkZSA8bGludXgvdm1h
bGxvYy5oPg0KKyNlbmRpZg0KICNpbmNsdWRlIDxhc20vaW8uaD4NCiAjaW5j
bHVkZSA8YWNwaS9hY3BpX2J1cy5oPg0KICNpbmNsdWRlIDxhY3BpL2FjcGku
aD4NCkBAIC0yMjIsMTQgKzIyNiw1MiBAQA0KIAlyZXR1cm4gQUVfT0s7DQog
fQ0KIA0KKw0KKyNpZmRlZiBDT05GSUdfQUNQSV9JTklUUkQNCit1bnNpZ25l
ZCBjaGFyIHNpZ25hdHVyZVtdID0gIklOSVRSRERTRFQxMjNEU0RUMTIzIjsN
CisNCit1bnNpZ25lZCBjaGFyKiBnZXRfZHNkdF9mcm9tX2luaXRyZCh1bnNp
Z25lZCBjaGFyICpzdGFydCwgdW5zaWduZWQgY2hhciAqZW5kKQ0KK3sNCisJ
dW5zaWduZWQgY2hhciAqZGF0YTsNCisNCisJaWYgKHN0YXJ0ID09IE5VTEwp
DQorCQlyZXR1cm4gTlVMTDsNCisJcHJpbnRrKEtFUk5fSU5GTyAiTG9va2lu
ZyBmb3IgRFNEVCBpbiBpbml0cmQgLi4uIik7DQorCWZvciAoZGF0YT1zdGFy
dDsgZGF0YSA8IGVuZCA7ICsrZGF0YSkgew0KKwkJaWYgKCFtZW1jbXAoZGF0
YSwgc2lnbmF0dXJlLCBzaXplb2Yoc2lnbmF0dXJlKS0xKSkgew0KKwkJCXBy
aW50ayhLRVJOX0lORk8gIiBmb3VuZCEiKTsNCisJCQlyZXR1cm4gZGF0YStz
aXplb2Yoc2lnbmF0dXJlKTsNCisJCX0NCisJfQ0KKwlwcmludGsoS0VSTl9J
TkZPICIgbm90IGZvdW5kISIpOw0KKw0KKwlyZXR1cm4gTlVMTDsNCit9DQor
I2VuZGlmDQorDQogYWNwaV9zdGF0dXMNCiBhY3BpX29zX3RhYmxlX292ZXJy
aWRlIChzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIgKmV4aXN0aW5nX3RhYmxl
LA0KIAkJCXN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAqKm5ld190YWJsZSkN
CiB7DQorI2lmZGVmIENPTkZJR19BQ1BJX0lOSVRSRA0KKwlleHRlcm4gdW5z
aWduZWQgbG9uZyBpbml0cmRfc3RhcnQsIGluaXRyZF9lbmQ7DQorCXVuc2ln
bmVkIGNoYXIqIG5ld19kc2R0PU5VTEw7DQorDQorI2VuZGlmDQogCWlmICgh
ZXhpc3RpbmdfdGFibGUgfHwgIW5ld190YWJsZSkNCiAJCXJldHVybiBBRV9C
QURfUEFSQU1FVEVSOw0KIA0KKyNpZmRlZiBDT05GSUdfQUNQSV9JTklUUkQN
CisJaWYgKHN0cm5jbXAoZXhpc3RpbmdfdGFibGUtPnNpZ25hdHVyZSwgIkRT
RFQiLCA0KSA9PSAwICYmDQorCQkobmV3X2RzZHQ9Z2V0X2RzZHRfZnJvbV9p
bml0cmQoKHVuc2lnbmVkIGNoYXIqKWluaXRyZF9zdGFydCwgDQorCQkJKHVu
c2lnbmVkIGNoYXIqKWluaXRyZF9lbmQpKSAhPSBOVUxMKQ0KKwkJKm5ld190
YWJsZSA9IChzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIqKW5ld19kc2R0Ow0K
KwllbHNlDQorCQkqbmV3X3RhYmxlID0gTlVMTDsNCisjZWxzZQ0KIAkqbmV3
X3RhYmxlID0gTlVMTDsNCisjZW5kaWYNCisNCiAJcmV0dXJuIEFFX09LOw0K
IH0NCiANCi0tLSBsaW51eC5vcmlnL2RyaXZlcnMvYWNwaS9Db25maWcuaW4J
MjAwMy0wNS0wNSAxODo0NDo0MS4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51
eC9kcml2ZXJzL2FjcGkvQ29uZmlnLmluCTIwMDMtMDUtMDUgMjA6MTk6MDYu
MDAwMDAwMDAwICswMjAwDQpAQCAtMTIsNiArMTIsMTAgQEANCiAgICAgICBi
b29sICAgICAgICAgJ0NQVSBFbnVtZXJhdGlvbiBPbmx5JyBDT05GSUdfQUNQ
SV9IVF9PTkxZDQogICAgIGZpDQogDQorICAgIGlmIFsgIiRDT05GSUdfQkxL
X0RFVl9JTklUUkQiID0gInkiIF07IHRoZW4NCisgICAgICBib29sICAgICAg
ICAgJ1JlYWQgRFNEVCBmcm9tIGluaXRyZCcgQ09ORklHX0FDUElfSU5JVFJE
DQorICAgIGZpDQorDQogICAgIGlmIFsgIiRDT05GSUdfQUNQSV9IVF9PTkxZ
IiA9ICJ5IiBdOyB0aGVuDQogICAgICAgZGVmaW5lX2Jvb2wgQ09ORklHX0FD
UElfQk9PVAkJeQ0KICAgICBlbHNlDQotLS0gbGludXgub3JpZy9Eb2N1bWVu
dGF0aW9uL0NvbmZpZ3VyZS5oZWxwCTIwMDMtMDUtMDUgMTk6NTE6MDkuMDAw
MDAwMDAwICswMjAwDQorKysgbGludXgvRG9jdW1lbnRhdGlvbi9Db25maWd1
cmUuaGVscAkyMDAzLTA1LTA1IDIwOjE4OjU2LjAwMDAwMDAwMCArMDIwMA0K
QEAgLTE4NjAyLDYgKzE4NjAyLDEzIEBADQogICBoYW5kbGVzIFBuUCBtZXNz
YWdlcy4gIEFsbCBBQ1BJIGRldmljZXMgdXNlIGl0cyBzZXJ2aWNlcywgc28g
dXNpbmcNCiAgIHRoZW0gcmVxdWlyZXMgc2F5aW5nIFkgaGVyZS4NCiANCitB
Q1BJIERTRFQgaW4gaW5pdHJkDQorQ09ORklHX0FDUElfSU5JVFJEDQorICBU
aGUgRFNEVCAoRGlmZmVyZW50aWF0ZWQgU3lzdGVtIERlc2NyaXB0aW9uIFRh
YmxlKSBvZnRlbiBuZWVkcyB0byBiZSANCisgIG92ZXJyaWRkZW4gYmVjYXVz
ZSBvZiBhIGJyb2tlbiBCSU9TIGltcGxlbWVudGF0aW9uLiBJZiB5b3Ugd2Fu
dCB0byBwdXQNCisgIHRoZSBvdmVycmlkZW4gRFNEVCBpbnRvIHRoZSBpbml0
cmQsIHNlZSBodHRwOi8vZ2F1Z3VzY2guYXQva2VybmVsLnNodG1sDQorICBm
b3IgbW9yZSBpbmZvLiBJZiB1bnN1cmUsIHNheSBOIGhlcmUuDQorDQogQUNQ
SSBTeXN0ZW0gRHJpdmVyDQogQ09ORklHX0FDUElfU1lTDQogICBUaGlzIGRy
aXZlciB3aWxsIGVuYWJsZSB5b3VyIHN5c3RlbSB0byBzaHV0IGRvd24gdXNp
bmcgQUNQSSwgYW5kDQo=

--8323584-88864896-1052166248=:8540--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
