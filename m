From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: sysfs regression on Supermicro X7DB8+ (was Re: ACPICA 20061109 regression on Supermicro X7DB8+)
Date: Sun, 17 Dec 2006 00:41:43 +0800
Message-ID: <58A36151585E4047913F40517D307BAE0171CD@pdsmsx404.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C72131.11CCB378"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15800 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161198AbWLPQvz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Dec 2006 11:51:55 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: "Li, Shaohua" <shaohua.li@intel.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C72131.11CCB378
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Yes. We do made several changes on .bind/.unbind method.
It seems that DEVICE(BPD0) doesn't have the _PRT method, which is =
required when binding BPD0.PXH0 and BPD0.PXH1. This is really strange...

Len, can you show me the ACPIDUMP and dmesg of 2.6.20-rc1 with this =
debug patch please?

Thanks,
Zhang.Rui(Ray)

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org =
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Len Brown
Sent: 2006=C4=EA12=D4=C216=C8=D5 13:07
To: linux-acpi@vger.kernel.org
Subject: Re: sysfs regression on Supermicro X7DB8+ (was Re: ACPICA =
20061109 regression on Supermicro X7DB8+)

> The failure is caused by the sysfs branch, which I'll have to drop =
from the acpi-test tree.

I think the failure comes down to the sysfs branch not finding the PRT
that is necessary to configure the SCSI controller on the PCI-X bus,
and the SCSI boot disk subsequently loses its mind.

< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0._PRT]
< ACPI: PCI Interrupt Routing Table =
[\_SB_.PCI0.P0P2.BMD0.BPD0.PXH0._PRT]
< ACPI: PCI Interrupt Routing Table =
[\_SB_.PCI0.P0P2.BMD0.BPD0.PXH1._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0.BPD2._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMF3._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
268a316,325
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0._PRT]
> ACPI Exception (pci_bind-0153): AE_NOT_FOUND, Invalid ACPI-PCI context =
for parent device BPD0 [20060707]
> ACPI Exception (pci_bind-0153): AE_NOT_FOUND, Invalid ACPI-PCI context =
for parent device BPD0 [20060707]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0.BPD2._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMF3._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]

dmesg for 2.6.20-rc1 success and 2.6.20-rc1-sysfs failure attached.

-Len

------_=_NextPart_001_01C72131.11CCB378
Content-Type: application/octet-stream;
	name="patch-debug-ACPI-PCI-bridge-driver"
Content-Transfer-Encoding: base64
Content-Description: patch-debug-ACPI-PCI-bridge-driver
Content-Disposition: attachment;
	filename="patch-debug-ACPI-PCI-bridge-driver"

LS0tCiBkcml2ZXJzL2FjcGkvcGNpX2JpbmQuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQoKSW5kZXg6IGxpbnV4LTIuNi4xOS9kcml2ZXJzL2FjcGkvcGNpX2JpbmQu
Ywo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMTkub3JpZy9kcml2ZXJzL2FjcGkvcGNpX2JpbmQu
YwkyMDA2LTEyLTE3IDAwOjE4OjI3LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE5L2Ry
aXZlcnMvYWNwaS9wY2lfYmluZC5jCTIwMDYtMTItMTcgMDA6Mzg6NDMuMDAwMDAwMDAwICswODAw
CkBAIC0xNTQsNiArMTU0LDcgQEAgaW50IGFjcGlfcGNpX2JpbmQoc3RydWN0IGFjcGlfZGV2aWNl
ICpkZQogCQlyZXN1bHQgPSAtRU5PREVWOwogCQlnb3RvIGVuZDsKIAl9CisJZWxzZSBwcmludGso
IkZpbmQgQUNQSS1QQ0kgY29udGV4dCBmb3IgcGFyZW50IGRldmljZSAlc1xuIiwgYWNwaV9kZXZp
Y2VfYmlkKGRldmljZS0+cGFyZW50KSk7CiAJZGF0YS0+aWQuc2VnbWVudCA9IHBkYXRhLT5pZC5z
ZWdtZW50OwogCWRhdGEtPmlkLmJ1cyA9IHBkYXRhLT5idXMtPm51bWJlcjsKIAo=

------_=_NextPart_001_01C72131.11CCB378--
