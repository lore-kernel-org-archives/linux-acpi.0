From: "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Subject: [PATCH] Active cooling devices bug (thermal.c)
Date: Thu, 25 Jul 2002 21:18:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B900970C7DD9474C972986EB3EC7C58F04E9F4@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C23410.1B15512F"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C23410.1B15512F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20

Activating ACPI on a Compaq Armada E500 I have found a bug in the
thermal zone.
The CPU fans are activated only if the enable flag of the active zone is
cleared.
But these flags are always set in acpi_thermal_check during checking the
temperature
against the trip points. Therefore, the fans are only turned off and
never turned=20
on if it is necessary :-(
In the attached patch this is solved by manipulating a local copy of the
thermal
state. Furthermore, the function acpi_thermal_active has allways to be
called if=20
one of the active cooling devices is activated to allow turning them
off. The=20
current code incorrectly calls this function only if the temperature is
higher=20
than one of the trip points, hence never when it is safe to completely
turn off
the fan.
Additionally, the sort order of the trip points is not specified, in
fact on this
notebook they are listed from higher temperatures to lower. Therefore,
to correctly
show the active colling state, the index of the entry with the highest
threshold
must be detected.

Best regards,
Herbert.

PS.: The DSDT needs patching like on all Compaq notebooks. If anybody is
     interested I can provide my patched version.

------------------------------------------------------------------------
-------
Herbert Nachtnebel                     Gusshausstr. 27/E384, 1040 Wien,
AUSTRIA
Vienna University of Technology                          Tel:
+43-1-58801-38437
Institute of Computer Technology                         Fax:
+43-1-58801-38499

------_=_NextPart_001_01C23410.1B15512F
Content-Type: application/octet-stream;
	name="thermal.patch"
Content-Transfer-Encoding: base64
Content-Description: thermal.patch
Content-Disposition: attachment;
	filename="thermal.patch"

LS0tIGxpbnV4LW9yaWcvZHJpdmVycy9hY3BpL3RoZXJtYWwuYwlUaHUgSnVsIDI1IDIwOjE1OjE0
IDIwMDIKKysrIGxpbnV4LWFjcGkvZHJpdmVycy9hY3BpL3RoZXJtYWwuYwlUaHUgSnVsIDI1IDIw
OjA5OjAxIDIwMDIKQEAgLTQ3Myw2ICs0NzMsNyBAQCBhY3BpX3RoZXJtYWxfcGFzc2l2ZSAoCiAJ
CQl0cmVuZCwgcGFzc2l2ZS0+dGMxLCB0ei0+dGVtcGVyYXR1cmUsIAogCQkJdHotPmxhc3RfdGVt
cGVyYXR1cmUsIHBhc3NpdmUtPnRjMiwgCiAJCQl0ei0+dGVtcGVyYXR1cmUsIHBhc3NpdmUtPnRl
bXBlcmF0dXJlKSk7CisJCXR6LT50cmlwcy5wYXNzaXZlLmZsYWdzLmVuYWJsZWQgPSAxOwogCQkv
KiBIZWF0aW5nIHVwPyAqLwogCQlpZiAodHJlbmQgPiAwKQogCQkJZm9yIChpPTA7IGk8cGFzc2l2
ZS0+ZGV2aWNlcy5jb3VudDsgaSsrKQpAQCAtNTE4LDYgKzUxOSw3IEBAIGFjcGlfdGhlcm1hbF9h
Y3RpdmUgKAogCXN0cnVjdCBhY3BpX3RoZXJtYWxfYWN0aXZlICphY3RpdmUgPSBOVUxMOwogCWlu
dCAgICAgICAgICAgICAgICAgICAgIGkgPSAwOwogCWludAkJCWogPSAwOworCXVuc2lnbmVkIGxv
bmcJCW1heHRlbXAgPSAwOwogCiAJQUNQSV9GVU5DVElPTl9UUkFDRSgiYWNwaV90aGVybWFsX2Fj
dGl2ZSIpOwogCkBAIC01MzcsNyArNTM5LDggQEAgYWNwaV90aGVybWFsX2FjdGl2ZSAoCiAJCSAq
IGFzc29jaWF0ZWQgd2l0aCB0aGlzIGFjdGl2ZSB0aHJlc2hvbGQuCiAJCSAqLwogCQlpZiAodHot
PnRlbXBlcmF0dXJlID49IGFjdGl2ZS0+dGVtcGVyYXR1cmUpIHsKLQkJCXR6LT5zdGF0ZS5hY3Rp
dmVfaW5kZXggPSBpOworCQkJaWYgKGFjdGl2ZS0+dGVtcGVyYXR1cmUgPiBtYXh0ZW1wKQorCQkJ
CXR6LT5zdGF0ZS5hY3RpdmVfaW5kZXggPSBpLCBtYXh0ZW1wID0gYWN0aXZlLT50ZW1wZXJhdHVy
ZTsKIAkJCWlmICghYWN0aXZlLT5mbGFncy5lbmFibGVkKSB7CiAJCQkJZm9yIChqID0gMDsgaiA8
IGFjdGl2ZS0+ZGV2aWNlcy5jb3VudDsgaisrKSB7CiAJCQkJCXJlc3VsdCA9IGFjcGlfYnVzX3Nl
dF9wb3dlcihhY3RpdmUtPmRldmljZXMuaGFuZGxlc1tqXSwgQUNQSV9TVEFURV9EMCk7CkBAIC01
OTEsNiArNTk0LDcgQEAgYWNwaV90aGVybWFsX2NoZWNrICgKIAlzdHJ1Y3QgYWNwaV90aGVybWFs
CSp0eiA9IChzdHJ1Y3QgYWNwaV90aGVybWFsICopIGRhdGE7CiAJdW5zaWduZWQgbG9uZwkJc2xl
ZXBfdGltZSA9IDA7CiAJaW50CQkJaSA9IDA7CisJc3RydWN0IGFjcGlfdGhlcm1hbF9zdGF0ZSBz
dGF0ZSA9IHR6LT5zdGF0ZTsKIAogCUFDUElfRlVOQ1RJT05fVFJBQ0UoImFjcGlfdGhlcm1hbF9j
aGVjayIpOwogCkBAIC02MTMsMTUgKzYxNywxNSBAQCBhY3BpX3RoZXJtYWxfY2hlY2sgKAogCSAq
IHRoaXMgZnVuY3Rpb24gZGV0ZXJtaW5lcyB3aGVuIGEgc3RhdGUgaXMgZW50ZXJlZCwgYnV0IHRo
ZSAKIAkgKiBpbmRpdmlkdWFsIHBvbGljeSBkZWNpZGVzIHdoZW4gaXQgaXMgZXhpdGVkIChlLmcu
IGh5c3RlcmVzaXMpLgogCSAqLwotCWlmICgodHotPnRyaXBzLmNyaXRpY2FsLmZsYWdzLnZhbGlk
KSAmJiAodHotPnRlbXBlcmF0dXJlID49IHR6LT50cmlwcy5jcml0aWNhbC50ZW1wZXJhdHVyZSkp
Ci0JCXR6LT50cmlwcy5jcml0aWNhbC5mbGFncy5lbmFibGVkID0gMTsKLQlpZiAoKHR6LT50cmlw
cy5ob3QuZmxhZ3MudmFsaWQpICYmICh0ei0+dGVtcGVyYXR1cmUgPj0gdHotPnRyaXBzLmhvdC50
ZW1wZXJhdHVyZSkpCi0JCXR6LT50cmlwcy5ob3QuZmxhZ3MuZW5hYmxlZCA9IDE7Ci0JaWYgKCh0
ei0+dHJpcHMucGFzc2l2ZS5mbGFncy52YWxpZCkgJiYgKHR6LT50ZW1wZXJhdHVyZSA+PSB0ei0+
dHJpcHMucGFzc2l2ZS50ZW1wZXJhdHVyZSkpCi0JCXR6LT50cmlwcy5wYXNzaXZlLmZsYWdzLmVu
YWJsZWQgPSAxOworCWlmICh0ei0+dHJpcHMuY3JpdGljYWwuZmxhZ3MudmFsaWQpCisJCXN0YXRl
LmNyaXRpY2FsIHw9ICh0ei0+dGVtcGVyYXR1cmUgPj0gdHotPnRyaXBzLmNyaXRpY2FsLnRlbXBl
cmF0dXJlKTsKKwlpZiAodHotPnRyaXBzLmhvdC5mbGFncy52YWxpZCkKKwkJc3RhdGUuaG90IHw9
ICh0ei0+dGVtcGVyYXR1cmUgPj0gdHotPnRyaXBzLmhvdC50ZW1wZXJhdHVyZSk7CisJaWYgKHR6
LT50cmlwcy5wYXNzaXZlLmZsYWdzLnZhbGlkKQorCQlzdGF0ZS5wYXNzaXZlIHw9ICh0ei0+dGVt
cGVyYXR1cmUgPj0gdHotPnRyaXBzLnBhc3NpdmUudGVtcGVyYXR1cmUpOwogCWZvciAoaT0wOyBp
PEFDUElfVEhFUk1BTF9NQVhfQUNUSVZFOyBpKyspCi0JCWlmICgodHotPnRyaXBzLmFjdGl2ZVtp
XS5mbGFncy52YWxpZCkgJiYgKHR6LT50ZW1wZXJhdHVyZSA+PSB0ei0+dHJpcHMuYWN0aXZlW2ld
LnRlbXBlcmF0dXJlKSkKLQkJCXR6LT50cmlwcy5hY3RpdmVbaV0uZmxhZ3MuZW5hYmxlZCA9IDE7
CisJCWlmICh0ei0+dHJpcHMuYWN0aXZlW2ldLmZsYWdzLnZhbGlkKQorCQkJc3RhdGUuYWN0aXZl
IHw9ICh0ei0+dGVtcGVyYXR1cmUgPj0gdHotPnRyaXBzLmFjdGl2ZVtpXS50ZW1wZXJhdHVyZSk7
CiAKIAkvKgogCSAqIEludm9rZSBQb2xpY3kKQEAgLTYyOSwxMyArNjMzLDEzIEBAIGFjcGlfdGhl
cm1hbF9jaGVjayAoCiAJICogU2VwYXJhdGVkIGZyb20gdGhlIGFib3ZlIGNoZWNrIHRvIGFsbG93
IGluZGl2aWR1YWwgcG9saWN5IHRvIAogCSAqIGRldGVybWluZSB3aGVuIHRvIGV4aXQgYSBnaXZl
biBzdGF0ZS4KIAkgKi8KLQlpZiAodHotPnRyaXBzLmNyaXRpY2FsLmZsYWdzLmVuYWJsZWQpCisJ
aWYgKHN0YXRlLmNyaXRpY2FsKQogCQlhY3BpX3RoZXJtYWxfY3JpdGljYWwodHopOwotCWlmICh0
ei0+dHJpcHMuaG90LmZsYWdzLmVuYWJsZWQpCisJaWYgKHN0YXRlLmhvdCkKIAkJYWNwaV90aGVy
bWFsX2hvdCh0eik7Ci0JaWYgKHR6LT50cmlwcy5wYXNzaXZlLmZsYWdzLmVuYWJsZWQpCisJaWYg
KHN0YXRlLnBhc3NpdmUpCiAJCWFjcGlfdGhlcm1hbF9wYXNzaXZlKHR6KTsKLQlpZiAodHotPnRy
aXBzLmFjdGl2ZVswXS5mbGFncy5lbmFibGVkKQorCWlmIChzdGF0ZS5hY3RpdmUpCiAJCWFjcGlf
dGhlcm1hbF9hY3RpdmUodHopOwogCiAJLyoK

------_=_NextPart_001_01C23410.1B15512F--


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
