From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Success with kernel-swsusp and Nvidia-closed-source
Date: Wed, 3 Nov 2004 12:25:45 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0411031215260.1187@frog.athome>
Reply-To: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811592-1570766258-1099481145=:1187"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811592-1570766258-1099481145=:1187
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Folks,
just had a bit of spare time to re-iterate the test, if my Acer TM634 
(with it's Nvidia 2 Go) would now be ready for suspend-to-disk.

Since some time ago, it is no problem to suspend to disk, if using the 
open-source (i.e. nv) driver for X. As it has problems with perfomance, 
e.g. DVD-playback is so slow, that the audio stops playing... I need to 
use the closed source driver.
With plain Linux 2.6.9 it nearly worked. It reported:
Could not suspend device 0000:01:00.0: error -1

After a quick search on Nvidia's forums I steped over Haggis dirty hack 
for the NVIDIA-Linux-x86-1.0-6111-pkg1. I attached this. Now suspending to 
disk works relyably for me.

Cheers
   hartwig felger

Hartwig Felger informatics
P.S.: with mplayer I use the gl2 device with the nvidia-driver.
- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBiMBD9bBoTzOf1pMRAj1cAKDjGomgzQFyoxXBQ+lhQODItBRdTwCg0s6R
tQp8JIj4hrb+4Wn8Sr2HAjE=
=/olf
-----END PGP SIGNATURE-----
---1463811592-1570766258-1099481145=:1187
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="nv-acpi.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0411031225450.1187-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Content-Description: 
Content-Disposition: attachment; filename="nv-acpi.diff"

LS0tIE5WSURJQS1MaW51eC14ODYtMS4wLTYxMTEtcGtnMS91c3Ivc3JjL252
L252LmMub3JpCTIwMDQtMTEtMDIgMjE6MDM6MzguMDAwMDAwMDAwICswMTAw
DQorKysgTlZJRElBLUxpbnV4LXg4Ni0xLjAtNjExMS1wa2cxL3Vzci9zcmMv
bnYvbnYuYwkyMDA0LTExLTAyIDIxOjAzOjM4LjAwMDAwMDAwMCArMDEwMA0K
QEAgLTE5LDYgKzE5LDkgQEANCiBNT0RVTEVfQUxJQVNfQ0hBUkRFVl9NQUpP
UihOVl9NQUpPUl9ERVZJQ0VfTlVNQkVSKTsNCiAjZW5kaWYNCiANCisvKiBm
aXggZm9yIDIuNi45LXJjIyBrZXJuZWxzIHdoZXJlIF9fVk1BTExPQ19SRVNF
UlZFIGlzIG5vdCBleHBvcnRlZCAqLw0KKyNkZWZpbmUgX19WTUFMTE9DX1JF
U0VSVkUgKDEyOCA8PCAyMCkNCisNCiAvKg0KICAqIG91ciBnbG9iYWwgc3Rh
dGU7IG9uZSBwZXIgZGV2aWNlDQogICovDQpAQCAtMzY5NCwxOSArMzY5Nywy
NCBAQA0KIA0KICAgICBzd2l0Y2ggKHN0YXRlKQ0KICAgICB7DQotICAgICAg
ICBjYXNlIFBNX1NBVkVfU1RBVEU6DQotICAgICAgICAgICAgbnZfcHJpbnRm
KE5WX0RCR19JTkZPLCAiTlZSTTogQUNQSTogcmVjZWl2ZWQgc3RhbmRieSBl
dmVudFxuIik7DQorICAgICAgLy8gICAgICAgIGNhc2UgUE1fU0FWRV9TVEFU
RToNCisgICAgICAvLyAgICAgICAgICAgIG52X3ByaW50ZihOVl9EQkdfSU5G
TywgIk5WUk06IEFDUEk6IHJlY2VpdmVkIHN0YW5kYnkgZXZlbnRcbiIpOw0K
KyAgICAgICAgY2FzZSBOVl9QTV9BQ1BJX1NUQU5EQlk6DQorICAgICAgICAg
ICAgbnZfcHJpbnRmKE5WX0RCR19JTkZPLCAiTlZSTTogQUNQSTogcmVjZWl2
ZWQgc3RhbmRieSBldmVudDogJWRcbiIsIHN0YXRlKTsNCiAgICAgICAgICAg
ICBzdGF0dXMgPSBybV9wb3dlcl9tYW5hZ2VtZW50KG52LCAwLCBOVl9QTV9B
Q1BJX1NUQU5EQlkpOw0KICAgICAgICAgICAgIGJyZWFrOw0KIA0KLSAgICAg
ICAgY2FzZSBQTV9SRVNVTUU6DQotICAgICAgICAgICAgbnZfcHJpbnRmKE5W
X0RCR19JTkZPLCAiTlZSTTogQUNQSTogcmVjZWl2ZWQgcmVzdW1lIGV2ZW50
XG4iKTsNCisJICAgIC8vICAgICAgICBjYXNlIFBNX1JFU1VNRToNCisJICAg
IC8vICAgICAgICAgICBudl9wcmludGYoTlZfREJHX0lORk8sICJOVlJNOiBB
Q1BJOiByZWNlaXZlZCByZXN1bWUgZXZlbnRcbiIpOw0KKw0KKyAgICAgZGVm
YXVsdDoNCisgICAgICAgIG52X3ByaW50ZihOVl9EQkdfSU5GTywgIk5WUk06
IEFDUEk6IHJlY2VpdmVkIHJlc3VtZSBldmVudDogJWRcbiIsIHN0YXRlKTsN
CiAgICAgICAgICAgICBzdGF0dXMgPSBybV9wb3dlcl9tYW5hZ2VtZW50KG52
LCAwLCBOVl9QTV9BQ1BJX1JFU1VNRSk7DQogICAgICAgICAgICAgYnJlYWs7
DQogDQotICAgICAgICBkZWZhdWx0Og0KLSAgICAgICAgICAgIG52X3ByaW50
ZihOVl9EQkdfV0FSTklOR1MsICJOVlJNOiBBQ1BJOiB1bnN1cHBvcnRlZCBl
dmVudDogJWRcbiIsIHN0YXRlKTsNCi0gICAgICAgICAgICByZXR1cm4gLTE7
DQorCSAgICAvLyAgICAgICAgZGVmYXVsdDoNCisJICAgIC8vICAgICAgICAg
ICAgbnZfcHJpbnRmKE5WX0RCR19XQVJOSU5HUywgIk5WUk06IEFDUEk6IHVu
c3VwcG9ydGVkIGV2ZW50OiAlZFxuIiwgc3RhdGUpOw0KKwkgICAgLy8gICAg
ICAgICAgICByZXR1cm4gLTE7DQogICAgIH0NCiANCiAgICAgaWYgKHN0YXR1
cyAhPSBSTV9PSykNCg==

---1463811592-1570766258-1099481145=:1187--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
