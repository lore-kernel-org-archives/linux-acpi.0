From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: ACPI Troubles with 2.6.16-rc3
Date: Fri, 17 Feb 2006 12:52:03 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F101A9E4C7@pdsmsx406>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6337D.E5E65C30"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:30098 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751360AbWBQEwY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Feb 2006 23:52:24 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org
Cc: Edgar Hucek <hostmaster@ed-soft.at>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6337D.E5E65C30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

looks like the acpi_os_unmap_memory hasn't the corresponding code to
acpi_os_map_memory's one code path. Does the attached workaround change
anything?

Thanks,
Shaohua

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Andrew Morton
>Sent: Friday, February 17, 2006 10:53 AM
>To: linux-acpi@vger.kernel.org
>Cc: Edgar Hucek
>Subject: Fw: ACPI Troubles with 2.6.16-rc3
>
>
>
>Begin forwarded message:
>
>Date: Thu, 16 Feb 2006 17:44:20 +0100
>From: Edgar Hucek <hostmaster@ed-soft.at>
>To: linux-kernel@vger.kernel.org
>Subject: ACPI Troubles with 2.6.16-rc3
>
>
>Hi.
>
>I have ACPI troubles :
>
>CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140
0000c1a9
>00000000 00000000
>Checking 'hlt' instruction... OK.
>iounmap: bad address dfefd000
> [<c0253684>] acpi_tb_get_table_header+0x67/0x92
> [<c042a630>] unknown_bootoption+0x0/0x260
> [<c02536c2>] acpi_tb_get_table+0x13/0x55  [<c02538b2>]
>acpi_tb_get_table_rsdt+0x1f/0x99
> [<c024e239>] acpi_ns_root_initialize+0x28a/0x299
> [<c0253971>] acpi_load_tables+0x45/0xa9
> [<c0443d56>] acpi_early_init+0x46/0xf6
> [<c042a56d>] start_kernel+0x2fd/0x3c0
> [<c042a630>] unknown_bootoption+0x0/0x260
>iounmap: bad address dfefd000
> [<c0253f2a>] acpi_tb_delete_single_table+0x30/0x33
> [<c0252f37>] acpi_tb_convert_to_xsdt+0x8d/0xa3
> [<c042a630>] unknown_bootoption+0x0/0x260
> [<c0253900>] acpi_tb_get_table_rsdt+0x6d/0x99
> [<c024e239>] acpi_ns_root_initialize+0x28a/0x299
> [<c0253971>] acpi_load_tables+0x45/0xa9
> [<c0443d56>] acpi_early_init+0x46/0xf6
> [<c042a56d>] start_kernel+0x2fd/0x3c0
> [<c042a630>] unknown_bootoption+0x0/0x260
>iounmap: bad address dfefb000
> [<c0253684>] acpi_tb_get_table_header+0x67/0x92
> [<c0253b4e>] acpi_tb_get_required_tables+0x4b/0x1f1
> [<c042a630>] unknown_bootoption+0x0/0x260
> [<c0253db5>] acpi_tb_init_table_descriptor+0x3a/0x107
> [<c0253911>] acpi_tb_get_table_rsdt+0x7e/0x99
> [<c042a630>] unknown_bootoption+0x0/0x260
> [<c0253986>] acpi_load_tables+0x5a/0xa9
> [<c0443d56>] acpi_early_init+0x46/0xf6
> [<c042a56d>] start_kernel+0x2fd/0x3c0
>
>Ataches is the full dmesg output.
>
>The machine is an Apple Intel iMac 17" Dual Core booted with
>elilo.
>
>Any ideas ?
>
>thx
>
>Edgar Hucek


------_=_NextPart_001_01C6337D.E5E65C30
Content-Type: application/octet-stream;
	name="test.patch"
Content-Transfer-Encoding: base64
Content-Description: test.patch
Content-Disposition: attachment;
	filename="test.patch"

CgotLS0KCiBsaW51eC0yLjYuMTYtcmMzLXJvb3QvZHJpdmVycy9hY3BpL29zbC5jIHwgICAgOCAr
KysrLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC1wdU4gZHJpdmVycy9hY3BpL29zbC5jfnRlc3QgZHJpdmVycy9hY3BpL29zbC5jCi0t
LSBsaW51eC0yLjYuMTYtcmMzL2RyaXZlcnMvYWNwaS9vc2wuY350ZXN0CTIwMDYtMDItMTcgMTI6
NDU6NDYuMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYuMTYtcmMzLXJvb3QvZHJpdmVycy9h
Y3BpL29zbC5jCTIwMDYtMDItMTcgMTI6NDg6NTUuMDAwMDAwMDAwICswODAwCkBAIC0xODMsMTEg
KzE4MywxMSBAQCBhY3BpX29zX21hcF9tZW1vcnkoYWNwaV9waHlzaWNhbF9hZGRyZXNzCiAJCSAg
IHZvaWQgX19pb21lbSAqKiB2aXJ0KQogewogCWlmIChlZmlfZW5hYmxlZCkgewotCQlpZiAoRUZJ
X01FTU9SWV9XQiAmIGVmaV9tZW1fYXR0cmlidXRlcyhwaHlzKSkgewotCQkJKnZpcnQgPSAodm9p
ZCBfX2lvbWVtICopcGh5c190b192aXJ0KHBoeXMpOwotCQl9IGVsc2UgeworLy8JCWlmIChFRklf
TUVNT1JZX1dCICYgZWZpX21lbV9hdHRyaWJ1dGVzKHBoeXMpKSB7CisvLwkJCSp2aXJ0ID0gKHZv
aWQgX19pb21lbSAqKXBoeXNfdG9fdmlydChwaHlzKTsKKy8vCQl9IGVsc2UgewogCQkJKnZpcnQg
PSBpb3JlbWFwKHBoeXMsIHNpemUpOwotCQl9CisvLwkJfQogCX0gZWxzZSB7CiAJCWlmIChwaHlz
ID4gVUxPTkdfTUFYKSB7CiAJCQlwcmludGsoS0VSTl9FUlIgUFJFRklYICJDYW5ub3QgbWFwIG1l
bW9yeSB0aGF0IGhpZ2hcbiIpOwpfCg==

------_=_NextPart_001_01C6337D.E5E65C30--
