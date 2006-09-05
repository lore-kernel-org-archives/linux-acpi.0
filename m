From: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Subject: [PATCH]: acpi sbs driver
Date: Tue, 5 Sep 2006 19:59:22 +0400
Message-ID: <8E389A5F2FEABA4CB1DEC35A25CB39CE3DBB2A@mssmsx411>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6D104.41B79045"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62725 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965127AbWIEQEi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Sep 2006 12:04:38 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6D104.41B79045
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Invalid module_param() call is fixed.


------_=_NextPart_001_01C6D104.41B79045
Content-Type: application/octet-stream;
	name="sbs_patch-2"
Content-Transfer-Encoding: base64
Content-Description: sbs_patch-2
Content-Disposition: attachment;
	filename="sbs_patch-2"

U3ViamVjdDogRml4IG1vZHVsZV9wYXJhbSgpIGNhbGwgYXJndW1lbnRzCgotLS0KIGRyaXZlcnMv
YWNwaS9zYnMuYyB8ICAgMTAgKysrKystLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtMi42LjE4LXJjNS1kZWZhdWx0L2Ry
aXZlcnMvYWNwaS9zYnMuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMTgtcmM1LWRlZmF1bHQu
b3JpZy9kcml2ZXJzL2FjcGkvc2JzLmMKKysrIGxpbnV4LTIuNi4xOC1yYzUtZGVmYXVsdC9kcml2
ZXJzL2FjcGkvc2JzLmMKQEAgLTk4LDExICs5OCwxMSBAQCBzdGF0aWMgaW50IHVwZGF0ZV9pbmZv
X21vZGUgPSBVUERBVEVfSU5GCiBzdGF0aWMgaW50IHVwZGF0ZV90aW1lID0gVVBEQVRFX1RJTUU7
CiBzdGF0aWMgaW50IHVwZGF0ZV90aW1lMiA9IFVQREFURV9USU1FMjsKIAotbW9kdWxlX3BhcmFt
KGNhcGFjaXR5X21vZGUsIGludCwgQ0FQQUNJVFlfVU5JVCk7Ci1tb2R1bGVfcGFyYW0odXBkYXRl
X21vZGUsIGludCwgVVBEQVRFX01PREUpOwotbW9kdWxlX3BhcmFtKHVwZGF0ZV9pbmZvX21vZGUs
IGludCwgVVBEQVRFX0lORk9fTU9ERSk7Ci1tb2R1bGVfcGFyYW0odXBkYXRlX3RpbWUsIGludCwg
VVBEQVRFX1RJTUUpOwotbW9kdWxlX3BhcmFtKHVwZGF0ZV90aW1lMiwgaW50LCBVUERBVEVfVElN
RTIpOworbW9kdWxlX3BhcmFtKGNhcGFjaXR5X21vZGUsIGludCwgMCk7Cittb2R1bGVfcGFyYW0o
dXBkYXRlX21vZGUsIGludCwgMCk7Cittb2R1bGVfcGFyYW0odXBkYXRlX2luZm9fbW9kZSwgaW50
LCAwKTsKK21vZHVsZV9wYXJhbSh1cGRhdGVfdGltZSwgaW50LCAwKTsKK21vZHVsZV9wYXJhbSh1
cGRhdGVfdGltZTIsIGludCwgMCk7CiAKIHN0YXRpYyBpbnQgYWNwaV9zYnNfYWRkKHN0cnVjdCBh
Y3BpX2RldmljZSAqZGV2aWNlKTsKIHN0YXRpYyBpbnQgYWNwaV9zYnNfcmVtb3ZlKHN0cnVjdCBh
Y3BpX2RldmljZSAqZGV2aWNlLCBpbnQgdHlwZSk7Cg==

------_=_NextPart_001_01C6D104.41B79045--
