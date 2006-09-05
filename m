From: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Subject: [PATCH]: acpi sbs driver
Date: Tue, 5 Sep 2006 19:49:13 +0400
Message-ID: <8E389A5F2FEABA4CB1DEC35A25CB39CE3DBB26@mssmsx411>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6D102.D7754907"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2887 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965142AbWIEPtp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Sep 2006 11:49:45 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6D102.D7754907
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Unchecked pointer dereference is fixed.



------_=_NextPart_001_01C6D102.D7754907
Content-Type: application/octet-stream;
	name="sbs_patch"
Content-Transfer-Encoding: base64
Content-Description: sbs_patch
Content-Disposition: attachment;
	filename="sbs_patch"

U3ViamVjdDogZml4IHVuY2hlY2tlZCBwb2ludGVyIGRlcmVmZXJlbmNlCgotLS0KIGRyaXZlcnMv
YWNwaS9zYnMuYyB8ICAgMTAgKysrKysrKystLQogMSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtMi42LjE4LXJjNS1kZWZhdWx0L2Ry
aXZlcnMvYWNwaS9zYnMuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMTgtcmM1LWRlZmF1bHQu
b3JpZy9kcml2ZXJzL2FjcGkvc2JzLmMKKysrIGxpbnV4LTIuNi4xOC1yYzUtZGVmYXVsdC9kcml2
ZXJzL2FjcGkvc2JzLmMKQEAgLTE2ODUsMTAgKzE2ODUsMTYgQEAgc3RhdGljIGludCBhY3BpX3Ni
c19hZGQoc3RydWN0IGFjcGlfZGV2aQogCiBpbnQgYWNwaV9zYnNfcmVtb3ZlKHN0cnVjdCBhY3Bp
X2RldmljZSAqZGV2aWNlLCBpbnQgdHlwZSkKIHsKLQlzdHJ1Y3QgYWNwaV9zYnMgKnNicyA9IChz
dHJ1Y3QgYWNwaV9zYnMgKilhY3BpX2RyaXZlcl9kYXRhKGRldmljZSk7CisJc3RydWN0IGFjcGlf
c2JzICpzYnMgPSBOVUxMOwogCWludCBpZDsKIAotCWlmICghZGV2aWNlIHx8ICFzYnMpIHsKKwlp
ZiAoIWRldmljZSkgeworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisKKwlzYnMgPSAoc3RydWN0IGFj
cGlfc2JzICopYWNwaV9kcml2ZXJfZGF0YShkZXZpY2UpOworCisJaWYgKCFzYnMpIHsKIAkJcmV0
dXJuIC1FSU5WQUw7CiAJfQogCg==

------_=_NextPart_001_01C6D102.D7754907--
