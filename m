From: d binderman <dcb314@hotmail.com>
Subject: linux kernel bug report
Date: Mon, 8 Mar 2010 10:29:26 +0000
Message-ID: <BLU108-W25C2EFF190E96A11245BBB9C350@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_16528b22-6e3b-4405-915d-432cdf3a9b79_"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from blu0-omc4-s35.blu0.hotmail.com ([65.55.111.174]:13149 "EHLO
	blu0-omc4-s35.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753355Ab0CHKfh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Mar 2010 05:35:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

--_16528b22-6e3b-4405-915d-432cdf3a9b79_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hello there=2C

I just ran the sourceforge tool cppcheck over the source code of the
new Linux kernel 2.6.33

It said

Checking ./drivers/acpi/osl.c...
[./drivers/acpi/osl.c:1039]: (style) After a strncpy() the buffer should be=
 zero-terminated

The source code is

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 strncpy(osi_additional_string=2C=
 str=2C OSI_STRING_LENGTH_MAX)=3B

I checked the source code and I agree with cppcheck.
Proposed patch file attached.


Regards

David Binderman
 		 	   		 =20
_________________________________________________________________
We want to hear all your funny=2C exciting and crazy Hotmail stories. Tell =
us now
http://clk.atdmt.com/UKM/go/195013117/direct/01/=

--_16528b22-6e3b-4405-915d-432cdf3a9b79_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bug36.patch"

ClNpZ25lZC1vZmYtYnk6IERhdmlkIEJpbmRlcm1hbiA8ZGNiMzE0QGhvdG1haWwuY29tPgoKLS0t
IGRyaXZlcnMvYWNwaS9vc2wuYy5zYXYJMjAxMC0wMy0wOCAxMDoyNDowMi4wMDAwMDAwMDAgKzAw
MDAKKysrIGRyaXZlcnMvYWNwaS9vc2wuYwkyMDEwLTAzLTA4IDEwOjI0OjIyLjAwMDAwMDAwMCAr
MDAwMApAQCAtMTAzNyw2ICsxMDM3LDcgQEAgaW50IF9faW5pdCBhY3BpX29zaV9zZXR1cChjaGFy
ICpzdHIpCiAJCWFjcGlfY21kbGluZV9vc2lfbGludXgoMSk7CS8qIGVuYWJsZSAqLwogCX0gZWxz
ZSBpZiAoKm9zaV9hZGRpdGlvbmFsX3N0cmluZyA9PSAnXDAnKSB7CiAJCXN0cm5jcHkob3NpX2Fk
ZGl0aW9uYWxfc3RyaW5nLCBzdHIsIE9TSV9TVFJJTkdfTEVOR1RIX01BWCk7CisJCXN0cltPU0lf
U1RSSU5HX0xFTkdUSF9NQVggLSAxXSA9IDA7CiAJCXByaW50ayhLRVJOX0lORk8gUFJFRklYICJB
ZGRlZCBfT1NJKCVzKVxuIiwgc3RyKTsKIAl9CiAK

--_16528b22-6e3b-4405-915d-432cdf3a9b79_--
