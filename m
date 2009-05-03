From: Kris Rusocki <kszysiu@gmail.com>
Subject: Number of pxm domain bits in SRAT's memory affinity structure
Date: Sat, 2 May 2009 20:04:04 -0600
Message-ID: <b26084c90905021904r77a31325n90bf511613e0f26e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e642d49ace29eb0468f875d8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:9915 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbZECCEF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 May 2009 22:04:05 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1809019ywb.1
        for <linux-acpi@vger.kernel.org>; Sat, 02 May 2009 19:04:04 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--0016e642d49ace29eb0468f875d8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Good day,


First off -- a tiny disclaimer: the following are just my observations
which may or may not be valid (with likelihood shifted to the latter).

In a nutshell they come down to a question -- how many bits should
be used to store PXM domain ID in SRAT's memory affinity structure?

Examination of include/acpi/actbl1.h suggests number 32
(vide: proximity_domain field of struct acpi_srat_mem_affinity)
whereas the only SRAT-related spec I've managed to find
(Microsoft's "SRAT Version 1.2, March 31, 2003")[1] mentions
8 bits.


Where my interest is coming from, you might wonder --

I have a board (Supermicro X8DA3) SRAT of which looks like...

SRAT @ 0xbf79a4b0
 0000: 53 52 41 54 28 01 00 00 01 0a 30 33 33 30 30 39  SRAT(.....033009
 0010: 4f 45 4d 53 52 41 54 20 01 00 00 00 49 4e 54 4c  OEMSRAT ....INTL
 0020: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
 0030: 00 10 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
 0040: 00 10 00 02 01 00 00 00 00 00 00 00 00 00 00 00  ................
 0050: 00 10 00 04 01 00 00 00 00 00 00 00 00 00 00 00  ................
 0060: 00 10 00 06 01 00 00 00 00 00 00 00 00 00 00 00  ................
 0070: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .(..............
 0080: 00 00 0a 00 00 00 00 00 00 00 00 00 01 00 00 00  ................
 0090: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  .........(......
 00a0: 00 00 10 00 00 00 00 00 00 00 f0 bf 00 00 00 00  ................
 00b0: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
 00c0: 00 10 01 10 01 00 00 00 00 00 00 00 00 00 00 00  ................
 00d0: 00 10 01 12 01 00 00 00 00 00 00 00 00 00 00 00  ................
 00e0: 00 10 01 14 01 00 00 00 00 00 00 00 00 00 00 00  ................
 00f0: 00 10 01 16 01 00 00 00 00 00 00 00 00 00 00 00  ................
 0100: 01 28 01 01 00 00 00 00 00 00 00 00 01 00 00 00  .(..............
 0110: 00 00 00 c0 00 00 00 00 00 00 00 00 01 00 00 00  ................
 0120: 00 00 00 00 00 00 00 00                          ........

this. At offset 0x100 there's memory affinity structure with PXM domain
of either 1 (MS spec) or 257 (Linux code). Thing is -- no processor
affinity structures refer PXM domain 257. It seems they just ... can't (?).

In other words -- when I boot Linux, SRAT parsing code gives
me the following:

SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 2 -> Node 0
SRAT: PXM 0 -> APIC 4 -> Node 0
SRAT: PXM 0 -> APIC 6 -> Node 0
SRAT: PXM 1 -> APIC 16 -> Node 1
SRAT: PXM 1 -> APIC 18 -> Node 1
SRAT: PXM 1 -> APIC 20 -> Node 1
SRAT: PXM 1 -> APIC 22 -> Node 1
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 100000-c0000000
SRAT: Node 2 PXM 257 100000000-1c0000000

Such affinity results in all processors using node 0 which is not
exactly what I want.

Obviously, this board's SRAT isn't perfect but I believe a good practice
is not to make use reserved bits (if to assume MS doc's validity).

I've attached a PoC patch which makes things a bit better here. Better, as in:

SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 2 -> Node 0
SRAT: PXM 0 -> APIC 4 -> Node 0
SRAT: PXM 0 -> APIC 6 -> Node 0
SRAT: PXM 1 -> APIC 16 -> Node 1
SRAT: PXM 1 -> APIC 18 -> Node 1
SRAT: PXM 1 -> APIC 20 -> Node 1
SRAT: PXM 1 -> APIC 22 -> Node 1
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 100000-c0000000
SRAT: Node 1 PXM 1 100000000-1c0000000


Your thoughts?


Thanks,
Kris


References:
1. http://www.microsoft.com/whdc/system/sysinternals/sratdwn.mspx

--0016e642d49ace29eb0468f875d8
Content-Type: text/x-diff; charset=US-ASCII; name="actbl1-8bit-pxm-domain.diff"
Content-Disposition: attachment; filename="actbl1-8bit-pxm-domain.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fu93hm3f0

LS0tIGluY2x1ZGUvYWNwaS9hY3RibDEuaC51MzIJMjAwOS0wNS0wMiAxODo0NToyMS43NzYwMDAw
MDAgLTA2MDAKKysrIGluY2x1ZGUvYWNwaS9hY3RibDEuaAkyMDA5LTA1LTAyIDE4OjQzOjUwLjI2
MDM3NTAwMCAtMDYwMApAQCAtMTE5Niw3ICsxMTk2LDEwIEBACiAKIHN0cnVjdCBhY3BpX3NyYXRf
bWVtX2FmZmluaXR5IHsKIAlzdHJ1Y3QgYWNwaV9zdWJ0YWJsZV9oZWFkZXIgaGVhZGVyOwotCXUz
MiBwcm94aW1pdHlfZG9tYWluOworCXU4IHByb3hpbWl0eV9kb21haW47CisJdTggcmVzZXJ2ZWQz
OworCXU4IHJlc2VydmVkNDsKKwl1OCByZXNlcnZlZDU7CiAJdTE2IHJlc2VydmVkOwkJLyogUmVz
ZXJ2ZWQsIG11c3QgYmUgemVybyAqLwogCXU2NCBiYXNlX2FkZHJlc3M7CiAJdTY0IGxlbmd0aDsK
--0016e642d49ace29eb0468f875d8--
