From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Sat, 6 Nov 2004 23:17:25 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0411062301590.5414@frog.athome>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome>
 <200411031958.47910.christian.hesse@linuxob.de>  <Pine.LNX.4.60.0411032322410.4984@frog.athome>
 <1099534267.3991.52.camel@desktop.cunninghams> <Pine.LNX.4.60.0411041242210.1565@frog.athome>
 <Pine.LNX.4.60.0411041729180.4727@frog.athome>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811592-1500968427-1099779445=:5414"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0411041729180.4727-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>, Christian Hesse <christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811592-1500968427-1099779445=:5414
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Folks,
On Thu, 4 Nov 2004 liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> Let us know if this gets you any further. When I find time, I will give 
> swsusp 2.1 another try myself!
sadly I found out, that my suspend successes where with Linux 2.6.8, but 
none the less, it works the same with 2.6.9, as well as with 2.6.9 patched 
with swsusp-2.1.1
Regarding stability I had a bit more luck with the vanilla-kernels - so 
one time with swsusp 2.1.1 I could not revive the screen. finaly I 
logged-in through the network and issued a "shutdown -r now". As the X was 
going down, the virtual-console did show up again. So maybe I had the bad 
luck, that the keyboard did hang then. I sometimes needed to change to a 
virtual-console, or back to X to get a restored screen, but sometimes it 
worked without doing anything.
I tryed today Linux-2.6.10-rc1 (without Swsusp-2.1.1). To get the 
prorietary Nvidia-driver compiled, you may want to apply the attached 
patch nv-2.9.10-rc1-incl-haggis.diff. I did not try, to have only the 
changes needed for 2.6.9- 2.6.10-rc1 (which is the other attached patch). 
Don't even know, if the compiler likes it. Both patches are aginst the 
Nvidia-driver...
But for me, I could not get the machine going down to suspend. It shutdown 
the screen, and then sit there as long as you let it. By issuing some ACPI 
event, I always got it back to live, e.g. lid-switch, power-button ...

So besides the problem described in 
http://bugme.osdl.org/show_bug.cgi?id=3669, that the laptop does no long 
poweroff, since 2.6.9, S4 as such broke for me with 2.6.10-rc1.

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBjU159bBoTzOf1pMRAjx+AJ0WXZhZLsIJ+fxVeGYlwW4uT4oLNACfY9/q
oJ8dV4ZYKacSSZzOmRESBVc=
=1BqI
-----END PGP SIGNATURE-----
---1463811592-1500968427-1099779445=:5414
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="nv-2.9.10-rc1-incl-haggis.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0411062317250.5414-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Content-Description: 
Content-Disposition: attachment; filename="nv-2.9.10-rc1-incl-haggis.diff"

LS0tIHVzci9zcmMvbnYvbnYuYy5vcmkJMjAwNC0xMS0wNiAxNjoxNDoyNi4w
MDAwMDAwMDAgKzAxMDANCisrKyB1c3Ivc3JjL252L252LmMJMjAwNC0xMS0w
NiAxNjoxNDoyNi4wMDAwMDAwMDAgKzAxMDANCkBAIC0xOSw2ICsxOSw5IEBA
DQogTU9EVUxFX0FMSUFTX0NIQVJERVZfTUFKT1IoTlZfTUFKT1JfREVWSUNF
X05VTUJFUik7DQogI2VuZGlmDQogDQorLyogZml4IGZvciAyLjYuOS1yYyMg
a2VybmVscyB3aGVyZSBfX1ZNQUxMT0NfUkVTRVJWRSBpcyBub3QgZXhwb3J0
ZWQgKi8NCisjZGVmaW5lIF9fVk1BTExPQ19SRVNFUlZFICgxMjggPDwgMjAp
DQorDQogLyoNCiAgKiBvdXIgZ2xvYmFsIHN0YXRlOyBvbmUgcGVyIGRldmlj
ZQ0KICAqLw0KQEAgLTYzOSw3ICs2NDIsNyBAQA0KICAgICB1OCAgICAgY2Fw
X3B0cjsNCiAgICAgaW50ICAgIGZ1bmMsIHNsb3Q7DQogDQotICAgIGRldiA9
IHBjaV9maW5kX2NsYXNzKGNsYXNzIDw8IDgsIE5VTEwpOw0KKyAgICBkZXYg
PSBwY2lfZ2V0X2NsYXNzKGNsYXNzIDw8IDgsIE5VTEwpOw0KICAgICBkbyB7
DQogICAgICAgICBmb3IgKGZ1bmMgPSAwOyBmdW5jIDwgODsgZnVuYysrKSB7
DQogICAgICAgICAgICAgc2xvdCA9IFBDSV9TTE9UKGRldi0+ZGV2Zm4pOw0K
QEAgLTY1MCw3ICs2NTMsNyBAQA0KICAgICAgICAgICAgIGlmIChjYXBfcHRy
KQ0KICAgICAgICAgICAgICAgICByZXR1cm4gZm47DQogICAgICAgICB9DQot
ICAgICAgICBkZXYgPSBwY2lfZmluZF9jbGFzcyhjbGFzcyA8PCA4LCBkZXYp
Ow0KKyAgICAgICAgZGV2ID0gcGNpX2dldF9jbGFzcyhjbGFzcyA8PCA4LCBk
ZXYpOw0KICAgICB9IHdoaWxlIChkZXYpOw0KIA0KICAgICByZXR1cm4gTlVM
TDsNCkBAIC0zNDgzLDEyICszNDg2LDEyIEBADQogICAgIHN0cnVjdCBwY2lf
ZGV2ICpkZXYgPSBOVUxMOw0KICAgICBpbnQgY291bnQgPSAwOw0KIA0KLSAg
ICBkZXYgPSBwY2lfZmluZF9jbGFzcyhQQ0lfQ0xBU1NfRElTUExBWV9WR0Eg
PDwgOCwgZGV2KTsNCisgICAgZGV2ID0gcGNpX2dldF9jbGFzcyhQQ0lfQ0xB
U1NfRElTUExBWV9WR0EgPDwgOCwgZGV2KTsNCiAgICAgd2hpbGUgKGRldikN
CiAgICAgew0KICAgICAgICAgaWYgKChkZXYtPnZlbmRvciA9PSAweDEwZGUp
ICYmIChkZXYtPmRldmljZSA+PSAweDIwKSkNCiAgICAgICAgICAgICBjb3Vu
dCsrOw0KLSAgICAgICAgZGV2ID0gcGNpX2ZpbmRfY2xhc3MoUENJX0NMQVNT
X0RJU1BMQVlfVkdBIDw8IDgsIGRldik7DQorICAgICAgICBkZXYgPSBwY2lf
Z2V0X2NsYXNzKFBDSV9DTEFTU19ESVNQTEFZX1ZHQSA8PCA4LCBkZXYpOw0K
ICAgICB9DQogICAgIHJldHVybiBjb3VudDsNCiB9DQpAQCAtMzY5NCwxOSAr
MzY5NywyNCBAQA0KIA0KICAgICBzd2l0Y2ggKHN0YXRlKQ0KICAgICB7DQot
ICAgICAgICBjYXNlIFBNX1NBVkVfU1RBVEU6DQotICAgICAgICAgICAgbnZf
cHJpbnRmKE5WX0RCR19JTkZPLCAiTlZSTTogQUNQSTogcmVjZWl2ZWQgc3Rh
bmRieSBldmVudFxuIik7DQorICAgICAgLy8gICAgICAgIGNhc2UgUE1fU0FW
RV9TVEFURToNCisgICAgICAvLyAgICAgICAgICAgIG52X3ByaW50ZihOVl9E
QkdfSU5GTywgIk5WUk06IEFDUEk6IHJlY2VpdmVkIHN0YW5kYnkgZXZlbnRc
biIpOw0KKyAgICAgICAgY2FzZSBOVl9QTV9BQ1BJX1NUQU5EQlk6DQorICAg
ICAgICAgICAgbnZfcHJpbnRmKE5WX0RCR19JTkZPLCAiTlZSTTogQUNQSTog
cmVjZWl2ZWQgc3RhbmRieSBldmVudDogJWRcbiIsIHN0YXRlKTsNCiAgICAg
ICAgICAgICBzdGF0dXMgPSBybV9wb3dlcl9tYW5hZ2VtZW50KG52LCAwLCBO
Vl9QTV9BQ1BJX1NUQU5EQlkpOw0KICAgICAgICAgICAgIGJyZWFrOw0KIA0K
LSAgICAgICAgY2FzZSBQTV9SRVNVTUU6DQotICAgICAgICAgICAgbnZfcHJp
bnRmKE5WX0RCR19JTkZPLCAiTlZSTTogQUNQSTogcmVjZWl2ZWQgcmVzdW1l
IGV2ZW50XG4iKTsNCisJICAgIC8vICAgICAgICBjYXNlIFBNX1JFU1VNRToN
CisJICAgIC8vICAgICAgICAgICBudl9wcmludGYoTlZfREJHX0lORk8sICJO
VlJNOiBBQ1BJOiByZWNlaXZlZCByZXN1bWUgZXZlbnRcbiIpOw0KKw0KKyAg
ICAgZGVmYXVsdDoNCisgICAgICAgIG52X3ByaW50ZihOVl9EQkdfSU5GTywg
Ik5WUk06IEFDUEk6IHJlY2VpdmVkIHJlc3VtZSBldmVudDogJWRcbiIsIHN0
YXRlKTsNCiAgICAgICAgICAgICBzdGF0dXMgPSBybV9wb3dlcl9tYW5hZ2Vt
ZW50KG52LCAwLCBOVl9QTV9BQ1BJX1JFU1VNRSk7DQogICAgICAgICAgICAg
YnJlYWs7DQogDQotICAgICAgICBkZWZhdWx0Og0KLSAgICAgICAgICAgIG52
X3ByaW50ZihOVl9EQkdfV0FSTklOR1MsICJOVlJNOiBBQ1BJOiB1bnN1cHBv
cnRlZCBldmVudDogJWRcbiIsIHN0YXRlKTsNCi0gICAgICAgICAgICByZXR1
cm4gLTE7DQorCSAgICAvLyAgICAgICAgZGVmYXVsdDoNCisJICAgIC8vICAg
ICAgICAgICAgbnZfcHJpbnRmKE5WX0RCR19XQVJOSU5HUywgIk5WUk06IEFD
UEk6IHVuc3VwcG9ydGVkIGV2ZW50OiAlZFxuIiwgc3RhdGUpOw0KKwkgICAg
Ly8gICAgICAgICAgICByZXR1cm4gLTE7DQogICAgIH0NCiANCiAgICAgaWYg
KHN0YXR1cyAhPSBSTV9PSykNCg==

---1463811592-1500968427-1099779445=:5414
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="nv-2.9.10-rc1.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0411062317251.5414-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Content-Description: 
Content-Disposition: attachment; filename="nv-2.9.10-rc1.diff"

LS0tIHVzci9zcmMvbnYvbnYuYy5vcmkyCTIwMDQtMTEtMDYgMTY6MTQ6MjYu
MDAwMDAwMDAwICswMTAwDQorKysgdXNyL3NyYy9udi9udi5jCTIwMDQtMTEt
MDYgMTY6MTQ6MjYuMDAwMDAwMDAwICswMTAwDQpAQCAtNjQyLDcgKzY0Miw3
IEBADQogICAgIHU4ICAgICBjYXBfcHRyOw0KICAgICBpbnQgICAgZnVuYywg
c2xvdDsNCiANCi0gICAgZGV2ID0gcGNpX2ZpbmRfY2xhc3MoY2xhc3MgPDwg
OCwgTlVMTCk7DQorICAgIGRldiA9IHBjaV9nZXRfY2xhc3MoY2xhc3MgPDwg
OCwgTlVMTCk7DQogICAgIGRvIHsNCiAgICAgICAgIGZvciAoZnVuYyA9IDA7
IGZ1bmMgPCA4OyBmdW5jKyspIHsNCiAgICAgICAgICAgICBzbG90ID0gUENJ
X1NMT1QoZGV2LT5kZXZmbik7DQpAQCAtNjUzLDcgKzY1Myw3IEBADQogICAg
ICAgICAgICAgaWYgKGNhcF9wdHIpDQogICAgICAgICAgICAgICAgIHJldHVy
biBmbjsNCiAgICAgICAgIH0NCi0gICAgICAgIGRldiA9IHBjaV9maW5kX2Ns
YXNzKGNsYXNzIDw8IDgsIGRldik7DQorICAgICAgICBkZXYgPSBwY2lfZ2V0
X2NsYXNzKGNsYXNzIDw8IDgsIGRldik7DQogICAgIH0gd2hpbGUgKGRldik7
DQogDQogICAgIHJldHVybiBOVUxMOw0KQEAgLTM0ODYsMTIgKzM0ODYsMTIg
QEANCiAgICAgc3RydWN0IHBjaV9kZXYgKmRldiA9IE5VTEw7DQogICAgIGlu
dCBjb3VudCA9IDA7DQogDQotICAgIGRldiA9IHBjaV9maW5kX2NsYXNzKFBD
SV9DTEFTU19ESVNQTEFZX1ZHQSA8PCA4LCBkZXYpOw0KKyAgICBkZXYgPSBw
Y2lfZ2V0X2NsYXNzKFBDSV9DTEFTU19ESVNQTEFZX1ZHQSA8PCA4LCBkZXYp
Ow0KICAgICB3aGlsZSAoZGV2KQ0KICAgICB7DQogICAgICAgICBpZiAoKGRl
di0+dmVuZG9yID09IDB4MTBkZSkgJiYgKGRldi0+ZGV2aWNlID49IDB4MjAp
KQ0KICAgICAgICAgICAgIGNvdW50Kys7DQotICAgICAgICBkZXYgPSBwY2lf
ZmluZF9jbGFzcyhQQ0lfQ0xBU1NfRElTUExBWV9WR0EgPDwgOCwgZGV2KTsN
CisgICAgICAgIGRldiA9IHBjaV9nZXRfY2xhc3MoUENJX0NMQVNTX0RJU1BM
QVlfVkdBIDw8IDgsIGRldik7DQogICAgIH0NCiAgICAgcmV0dXJuIGNvdW50
Ow0KIH0NCg==

---1463811592-1500968427-1099779445=:5414--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
