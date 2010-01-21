From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: About Bug 14753 ACPI Errors: Index beyond end of object,
 	parse/execution failed, _BCM failed ...
Date: Thu, 21 Jan 2010 11:38:54 +0800
Message-ID: <8B81FACE836F9248894A7844CC0BA8141C9C54303A@shzsmsx501.ccr.corp.intel.com>
References: <16a2bfdb1001201845j6524345dwb13766def182a62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55724 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab0AUDkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2010 22:40:03 -0500
In-Reply-To: <16a2bfdb1001201845j6524345dwb13766def182a62@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bin Guo <slashbin@gmail.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Yes, this is a duplicate of bug 14753.
It seems that a lot of Asus laptops have this problem.

Len,
I think we should ping Asus to get the problem fixed in BIOS,
rather than adding a lot of DMI quirks in Linux kernel.
What do you think?

Thanks,
Rui

> -----Original Message-----
> From: Bin Guo [mailto:slashbin@gmail.com]
> Sent: Thursday, January 21, 2010 10:45 AM
> To: Zhang, Rui
> Subject: About Bug 14753 ACPI Errors: Index beyond end of object,
> parse/execution failed, _BCM failed ...
>=20
> Hi,
>=20
> =A0 I recently bought an Asus U50A laptop that's having the same prob=
lem
> as bug 14753 at http://bugzilla.kernel.org/show_bug.cgi?id=3D14753 bu=
t
> the product name is definitely different. I suspect several other
> models (like UL50VT) would have similar problems.
>=20
>=20
>  I'm attaching the acpidump and deassembly of DSDT plus dmidecode.
> Following are the common errors seen from dmesg (the only problem see=
ms
> to be lcd turning bright once in a while):
>=20
> [   59.814547] ACPI Exception: AE_AML_BUFFER_LIMIT, Index (000000010)
> is beyond end of object (20090903/exoparg2-445)
> [   59.814563] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0.SBRG.EC0_.STBR] (Node ffff88013fa46140),
> AE_AML_BUFFER_LIMIT
> [   59.814633] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0.VGA_.LCDD._BCM] (Node ffff88013fa40380),
> AE_AML_BUFFER_LIMIT
> [   59.814705] ACPI Error: Evaluating _BCM failed (20090903/video-528=
)
> [   59.820650] ACPI Exception: AE_AML_BUFFER_LIMIT, Index (000000015)
> is beyond end of object (20090903/exoparg2-445)
> [   59.820664] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0.SBRG.EC0_.STBR] (Node ffff88013fa46140),
> AE_AML_BUFFER_LIMIT
> [   59.820734] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0.VGA_.LCDD._BCM] (Node ffff88013fa40380),
> AE_AML_BUFFER_LIMIT
> [   59.820806] ACPI Error: Evaluating _BCM failed (20090903/video-528=
)
> [   59.826937] ACPI Exception: AE_AML_BUFFER_LIMIT, Index (00000001B)
> is beyond end of object (20090903/exoparg2-445)
> [   59.826953] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0.SBRG.EC0_.STBR] (Node ffff88013fa46140),
> AE_AML_BUFFER_LIMIT
> [   59.827025] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0.VGA_.LCDD._BCM] (Node ffff88013fa40380),
> AE_AML_BUFFER_LIMIT
> [   59.827098] ACPI Error: Evaluating _BCM failed (20090903/video-528=
)
> [   61.954710] ACPI Exception: AE_AML_BUFFER_LIMIT, Index (00000001B)
> is beyond end of object (20090903/exoparg2-445)
> [   61.954725] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0.SBRG.EC0_.STBR] (Node ffff88013fa46140),
> AE_AML_BUFFER_LIMIT
> [   61.954794] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0.VGA_.LCDD._BCM] (Node ffff88013fa40380),
> AE_AML_BUFFER_LIMIT
> [   61.954867] ACPI Error: Evaluating _BCM failed (20090903/video-528=
)
>=20
> [ 5340.144703] ACPI Warning: _BQC returned an invalid level
> (20090903/video-631) [ 9890.028659] ACPI Exception: AE_AML_BUFFER_LIM=
IT,
> Index (00000001B) is beyond end of object (20090903/exoparg2-445)
> [ 9890.028675] ACPI Error (psparse-0537): Method parse/execution fail=
ed
> [\_SB_.PCI0.SBRG.EC0_.STBR] (Node ffff88013fa46140),
> AE_AML_BUFFER_LIMIT [ 9890.028746] ACPI Error (psparse-0537): Method
> parse/execution failed [\_SB_.PCI0.VGA_.LCDD._BCM] (Node
> ffff88013fa40380), AE_AML_BUFFER_LIMIT [ 9890.028820] ACPI Error:
> Evaluating _BCM failed (20090903/video-528)
>=20
> Thanks,
> --
> Bin
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
