From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Thu, 4 Nov 2004 12:59:16 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0411041242210.1565@frog.athome>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome>
 <200411031958.47910.christian.hesse@linuxob.de>  <Pine.LNX.4.60.0411032322410.4984@frog.athome>
 <1099534267.3991.52.camel@desktop.cunninghams>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811592-1966626912-1099569556=:1565"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1099534267.3991.52.camel-r49W/1Cwd2ff0s6lnCXPXw0QcLn3kwYh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: Christian Hesse <christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811592-1966626912-1099569556=:1565
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Nigel,
On Thu, 4 Nov 2004, Nigel Cunningham wrote:
> Hi.
>
> On Thu, 2004-11-04 at 09:29, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Salut Christian,
>> On Wed, 3 Nov 2004, Christian Hesse wrote:
>>> I'm using software suspend 2.1. For me suspend works fine, but the system
>>> freezes as soon as it is resumed, I only see a black screen then. Driver nv
>>> works without any problems. Any hints what could be the cause?
>> I did not patch in anything into the kernel. I used a vanilla 2.6.9 (only
>> the Makefile was patched to show 2.6.9 instead of 8 ... maybe somebody
>> watched a bit too much tv... :-)
>> So I did not use swsusp 2.1. And I could not manage to freeze on resume
>> this time. So, why didn't you try the vanilla-kernel, with the
>> Haggi' s patch for the nvidia driver?
>> When you test - be sure to sync before suspending. It's the second best,
>> besides having a jung backup handy.
>
> I guess I'm doing something driver related that Pavel isn't or vv :>.
> Can I get a pointer to the driver source?

The closed source driver from Nvidia is at
http://download.nvidia.com/XFree86/Linux-x86/1.0-6111/NVIDIA-Linux-x86-1.0-6111-pkg1.run
For me to make it work, you first needed to extract it with --extract-only
Then apply Haggi's patch (attached). Otherwise it refused to suspend:
  Could not suspend device 0000:01:00.0: error -1
But all this is not with Swsusp 2.1, but with the 2.6.9-kernel, and works 
as it should.
I think Christian is also using 6.111??? nvidia driver with Swsusp 2.1.

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBihmk9bBoTzOf1pMRAnM1AJ4rWSQfKGi9jWO9HMO7i53djIQKmACcCdiB
DzMLUtyQ4P0IBDxhoA8ICgM=
=ZSKy
-----END PGP SIGNATURE-----
---1463811592-1966626912-1099569556=:1565
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="nv-acpi.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0411041259160.1565-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
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

---1463811592-1966626912-1099569556=:1565--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
