From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Shutdown APIC at poweroff
Date: Wed, 20 Oct 2004 13:04:12 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6EDC9204B3704C4C8522539D5C1185E54022CC@mssmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4B683.C2CF67B3"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4B683.C2CF67B3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Len,
Here is consolidated patch.
I'm not quite sure where should I open bug?

Thanks,
	Alex.

------_=_NextPart_001_01C4B683.C2CF67B3
Content-Type: application/octet-stream;
	name="apic-shutdown.patch"
Content-Transfer-Encoding: base64
Content-Description: apic-shutdown.patch
Content-Disposition: attachment;
	filename="apic-shutdown.patch"

IyBUaGlzIGlzIGEgQml0S2VlcGVyIGdlbmVyYXRlZCBkaWZmIC1OcnUgc3R5bGUgcGF0Y2guCiMK
IyBDaGFuZ2VTZXQKIyAgIDIwMDQvMTAvMTUgMTc6MjU6NDIrMDQ6MDAgYXlzdGFyaWtAbXN0cmNz
ZDAwMy5pbXMuaW50ZWwuY29tIAojICAgYXBpYy5jOgojICAgICBmaXggY29tcGlsZSB0aW1lIHdh
cm5pbmcuCiMgCiMgYXJjaC9pMzg2L2tlcm5lbC9hcGljLmMKIyAgIDIwMDQvMTAvMTUgMTc6MjQ6
NTUrMDQ6MDAgYXlzdGFyaWtAbXN0cmNzZDAwMy5pbXMuaW50ZWwuY29tICsxIC0xCiMgICBmaXgg
Y29tcGlsZSB0aW1lIHdhcm5pbmcuCiMgCiMgQ2hhbmdlU2V0CiMgICAyMDA0LzEwLzE1IDE3OjIw
OjI2KzA0OjAwIGF5c3RhcmlrQG1zdHJjc2QwMDMuaW1zLmludGVsLmNvbSAKIyAgIGFwaWMuYzoK
IyAgICAgbWFrZSBMQVBJQyBzaHV0ZG93biBhdCBwb3dlcm9mZi4KIyAKIyBhcmNoL2kzODYva2Vy
bmVsL2FwaWMuYwojICAgMjAwNC8xMC8xNSAxNzoxMDowNiswNDowMCByb290QG1zdHJjc2QwMDMu
aW1zLmludGVsLmNvbSArMTYgLTQKIyAgIG1ha2UgTEFQSUMgc2h1dGRvd24gYXQgcG93ZXJvZmYu
CiMgCmRpZmYgLU5ydSBhL2FyY2gvaTM4Ni9rZXJuZWwvYXBpYy5jIGIvYXJjaC9pMzg2L2tlcm5l
bC9hcGljLmMKLS0tIGEvYXJjaC9pMzg2L2tlcm5lbC9hcGljLmMJMjAwNC0xMC0yMCAxMjo1Njo0
MiArMDQ6MDAKKysrIGIvYXJjaC9pMzg2L2tlcm5lbC9hcGljLmMJMjAwNC0xMC0yMCAxMjo1Njo0
MiArMDQ6MDAKQEAgLTUxNCwxMyArNTE0LDI3IEBACiAJdW5zaWduZWQgaW50IGFwaWNfdGhtcjsK
IH0gYXBpY19wbV9zdGF0ZTsKIAotc3RhdGljIGludCBsYXBpY19zdXNwZW5kKHN0cnVjdCBzeXNf
ZGV2aWNlICpkZXYsIHUzMiBzdGF0ZSkKK3N0YXRpYyBpbnQgbGFwaWNfc2h1dGRvd24oc3RydWN0
IHN5c19kZXZpY2UgKmRldikKIHsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCiAJaWYgKCFhcGlj
X3BtX3N0YXRlLmFjdGl2ZSkKIAkJcmV0dXJuIDA7CiAKKwkKKwlsb2NhbF9pcnFfc2F2ZShmbGFn
cyk7CisJZGlzYWJsZV9sb2NhbF9BUElDKCk7CisJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwor
CQorCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IGxhcGljX3N1c3BlbmQoc3RydWN0IHN5c19k
ZXZpY2UgKmRldiwgdTMyIHN0YXRlKQoreworCisJaWYgKCFhcGljX3BtX3N0YXRlLmFjdGl2ZSkK
KwkJcmV0dXJuIDA7CisKIAlhcGljX3BtX3N0YXRlLmFwaWNfaWQgPSBhcGljX3JlYWQoQVBJQ19J
RCk7CiAJYXBpY19wbV9zdGF0ZS5hcGljX3Rhc2twcmkgPSBhcGljX3JlYWQoQVBJQ19UQVNLUFJJ
KTsKIAlhcGljX3BtX3N0YXRlLmFwaWNfbGRyID0gYXBpY19yZWFkKEFQSUNfTERSKTsKQEAgLTUz
NSwxMCArNTQ5LDcgQEAKIAlhcGljX3BtX3N0YXRlLmFwaWNfdGRjciA9IGFwaWNfcmVhZChBUElD
X1REQ1IpOwogCWFwaWNfcG1fc3RhdGUuYXBpY190aG1yID0gYXBpY19yZWFkKEFQSUNfTFZUVEhN
Uik7CiAJCi0JbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOwotCWRpc2FibGVfbG9jYWxfQVBJQygpOwot
CWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKLQlyZXR1cm4gMDsKKwlyZXR1cm4gbGFwaWNfc2h1
dGRvd24oZGV2KTsKIH0KIAogc3RhdGljIGludCBsYXBpY19yZXN1bWUoc3RydWN0IHN5c19kZXZp
Y2UgKmRldikKQEAgLTU4Nyw2ICs1OTgsNyBAQAogCiBzdGF0aWMgc3RydWN0IHN5c2Rldl9jbGFz
cyBsYXBpY19zeXNjbGFzcyA9IHsKIAlzZXRfa3NldF9uYW1lKCJsYXBpYyIpLAorCS5zaHV0ZG93
bgk9IGxhcGljX3NodXRkb3duLAogCS5yZXN1bWUJCT0gbGFwaWNfcmVzdW1lLAogCS5zdXNwZW5k
CT0gbGFwaWNfc3VzcGVuZCwKIH07Cg==

------_=_NextPart_001_01C4B683.C2CF67B3--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
